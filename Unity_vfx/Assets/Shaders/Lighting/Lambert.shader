﻿Shader "Q/Lighting/Lambert"
{
	Properties
	{
		_Color ("Color", Color) = (1,1,1,1)
		_LightCol ("Light Color", Color) = (1,1,1,1)
	}
	SubShader
	{
		LOD 100

		Pass
		{

			Tags{ "RenderType"="Opaque" "RenderPipeline" = "UniversalRenderPipeline" "LightMode" = "UniversalForward" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 lightColor : COLOR;
			};

			float3 _LightCol;
			float3 _Color;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);

				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				
				float nDotL = max(0, dot(worldNormal, _WorldSpaceLightPos0) );
				o.lightColor = nDotL * _LightCol;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = 0;
				col.rgb = _Color * i.lightColor;
				return col;
			}
			ENDCG
		}
	}
}
