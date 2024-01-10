Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2040.outbound.protection.outlook.com [40.92.18.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E93EA6B
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TJM3kLE8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4jZEOgpHqVuc4VfcgeCraITvyjISWtZDMBDFVfFsSXXhBISNieGY1q97LLSzN22EHAVRp8Q7MSopJmiKPn4E7yLbBcFcuHyqmVz1E0N/pxSwG2mk/PU5Oz7B8eflXUCVbkB3hX0WCWnq42yzy9qcM786cLyqiC9e5BF+m2CyjghwkqRIebt2Dl5juTbT4ancubeNGByRJCNAPJRetJgfodjtkQ06e02ApDkov3Qlu/6zkxYNOD6hkTS+9GeEeOptIpw37Y9/dISxNwUMIuBXfH6Nu1Hjk6bEqLhxme1/SRBTnpbtiEFbxK63WHKa57y2ASTtd9vVw+H/865WFRhCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33cd8/0oclYYX5fZ01HsxF9f1BZ62osykpKNS3z50FA=;
 b=VJMFkjHIwwu9MHe+UEv5Cv2iw2Q+pZNDq4JW6lqwUJhqK0+EwG3DsFP+iz2b9u8HNLGuMwvGJYTySMGPM4HJ0awzkC2DBcIoFajoskg/YFK6pPC5c0cc9EW4W/k8bv1ttU2e9FKZECU5gGgzTZxRZmtJDFRTlGVyav3fOyMcyIpva7qzY1kxfFBdQNYu5lPVRwNn+R7YZWZhzS5L00hdOX/7UY0Cz0Gt6oUaLy7PxLfWIZJG553p9DwDqZ3Ea3ETCoJc7q7ykyyzXAHvW4nJplpl+483qKwgDJTBtIP8y2+l9EukYbBdSbp34X23vIRGZENcLc2xQJSmdL3OJjsGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33cd8/0oclYYX5fZ01HsxF9f1BZ62osykpKNS3z50FA=;
 b=TJM3kLE881S7Tp0eYL+4FdnGlOYXMg23YH73TinXRerdreLdeiUsc56T5oA87QOSsfq8XjJlYGm2DCKiSverlV+bxl/LxSE6dBT/aq4eLki8N6X/dfmeUbBkDNAUFvb41Qja8XgVskusQruXXV6zamo36/WXYYz1jRAJ3IVTpnHUfU/JZ5g1K9L7Ra17Hs74sUz4+88Jx8wVddpByQkaLpmzw5Unb+yanX3sMUnVFTFWbjhQ/C5F9HSRUU3xkyguu6GnHYzEiqFQ+toxklTtu9oW3kGjum8uf9ht4zjAGCnkh8ZzPctVF9RvLLYPBXXDKPpeKo4WLVBynfOvc4xO4Q==
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d9::7)
 by EA2P220MB1306.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Wed, 10 Jan
 2024 08:15:19 +0000
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9]) by LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9%6]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 08:15:19 +0000
From: ross nicholas Oneil thomas <rossrecovery93245@outlook.com>
To: GitHub Developer Support <developer@githubsupport.com>, Github email
	<git@vger.kernel.org>, "zimmermanda@sec.gov" <zimmermanda@sec.gov>,
	"digital_identity@nist.gov" <digital_identity@nist.gov>, GitHub
	<support@githubsupport.com>, Ross Nicholas Oneil Thomas <sales@github.com>,
	ross nicholas Oneil thomas <rossrecovery93245@outlook.com>,
	"jmap-owner@ietf.org" <jmap-owner@ietf.org>
Subject:
 =?utf-8?B?TmV3IEZlYXR1cmUgUmVxdWVzdDogUmF0aW5nIGNvbnRyb2wgKHN0YXJzKSA=?=
 =?utf-8?B?wrcgSXNzdWUgIzMwNTQgwrcgbWljcm9zb2Z0L0FkYXB0aXZlQ2FyZHMgwrcg?=
 =?utf-8?Q?GitHub?=
Thread-Topic:
 =?utf-8?B?TmV3IEZlYXR1cmUgUmVxdWVzdDogUmF0aW5nIGNvbnRyb2wgKHN0YXJzKSA=?=
 =?utf-8?B?wrcgSXNzdWUgIzMwNTQgwrcgbWljcm9zb2Z0L0FkYXB0aXZlQ2FyZHMgwrcg?=
 =?utf-8?Q?GitHub?=
Thread-Index: AQHaQ50m38DmgNS26EievZSHzQ6pjg==
Date: Wed, 10 Jan 2024 08:15:19 +0000
Message-ID:
 <LV3P220MB128628B36F1C3E0F8194DF68FB692@LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [PjuLhNUWHlb0802ckxH7KcvVdewchnCRpazyg4TLH88=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3P220MB1286:EE_|EA2P220MB1306:EE_
x-ms-office365-filtering-correlation-id: 7e2b6be9-b58d-4b22-16ab-08dc11b448e5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 how/NgFvjJrVcZ5nBEWu9uW6RrnXYY68JIsqj9oEhkzSc677EikJzzPPCx0MAw44MthKIqLqdD8nlZZGFxKaI9oudMCoU1FO6rTR0GnfRGVGULP6tzHtQ0+uxPVAl6z7tTtd81ktnbt4j3mig5hu9mQjKWEFie6uT+YY2zzEK13z6Pd0uKzbba1tjBZaMzTOstkRvLBQCneZ35pHwGsEL9OyYzEST7b5MmUlXLI5kjqrWqXM1Ty1zoceY5xkvf0uhEBOsRdpc8aAA7OwtTab+9NciPlWDK//mjTXKnu6lcq7gxR5CiszDnsTw/ijAh/8bky0G+xYbGbLRwC9nBjc+e6frWaLxOs00PYaVbPTCtUFp7LK2kdvaj6xIN1nrOPtmul4jCrYk3We4txZkW8PknsTptEj/s3Y0cGJTsZnjeJ5d3sfWQ3gPxTiwqu8Tf1h4V42a7M3qm3g9x9zxz02ojHJwvbZ6rZMfmFGYTVNnBUxZBO+BXKxKIfyEmaNunWr8tozYz48hQssgyUxaZbYAYenH4V3s9pVE2nlyQ8tP/OXgZZKO6lVPQtl2wmDp0ysWUntjahcvHkC1ot2GFhxKG0twHm6+QvxXdOygZqFh9KZkDcOzqNL9QSnpLCVzoyctsR+3DuYUGt9LcwkD/XausayZ8IwlRjKrSfQfkQGBtE=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?di9NQWhhemR5Q2lTb25KVWRWWElTSnhxRVUxK05KVER2YU9LNFdhNUtxVkg2?=
 =?utf-8?B?K2gydlVlbncyMkVxNDk4K3lKOENEeE1KTDdyTTJPZUYzK1ZzZDFSQmxXb0Vn?=
 =?utf-8?B?QW55STFrc1d3Qkk0UWRyQUpPanVjQUFQMTRFWng2SDIyRXZRM1dMamFVZkZy?=
 =?utf-8?B?RC91aTFQMnp2OFh6VzNSNnVJZ0hzem4rb3ZOVlhvNHU1cEdFNWNCWExwMms0?=
 =?utf-8?B?S0VTNkJXdHc4dW10V3hmdGFLNXU2WTA4dDc3RE9oTlVVWnRLQ3czRUgrT09V?=
 =?utf-8?B?ekFnY1FjQnJkVFlwLzhDQjllM3oyc2x5LzVlN2hSKysraDlOQ1orYVo3ak56?=
 =?utf-8?B?ak9SOXF6bjFHc3dYV1ZCaXRlZndkUU5WbkYwQVY4ajlIK1BMSFRwT2ZRVFd5?=
 =?utf-8?B?ZFk3aTVHRUhEdU5qRU9PVk95aTBEd1FOUXp2cDFRakN1MVRkU096UUZSdGEz?=
 =?utf-8?B?eEIvV3lhYzZReERDcDhjYU8zeHdvTWo5aGQ4bjFlK25DMGpaaW43SU16ZzZv?=
 =?utf-8?B?V0t1dUQ4b3NiYzQ5OVhCNzF2L0cxbFJJZUhBMjNEQ0VtVzUvUGxFUGhZLzZ0?=
 =?utf-8?B?dVcvM0l0NXJxbW95QUdieVJqRkpqWHRlQmdFUk5UT2VQWGV3dzI2TmpZNXBL?=
 =?utf-8?B?a3F5WkEzb3BON0tkekxSTXN6T2xkOHZ4UWxYajVLbnV4WkdJWTl2TU9NdGgy?=
 =?utf-8?B?VFcwNVdJZ3Y3NlFLQjRqVUpQa2UvRGV2UmxFVTZ4cmI1WE9zSWVTQmVVc2Q1?=
 =?utf-8?B?Vlp0b2xTdU1GdHFnTXBNVWdKV21WWlIwMnZLa3J2VW80U2hOVzAxQXd5c2ps?=
 =?utf-8?B?cmdTWnhMWHplWVorVUM1a3gyWE9MODJUelc3cXpyVE9kRlVKTUc1VjZKK1Yv?=
 =?utf-8?B?UTFVK1hOOUxMK0FDdU5TSUJhV1ZUdXVPaWQxRFY0M3ppYkdJazNuMU4zdlpD?=
 =?utf-8?B?V3llRGEyb3B2cjlWd1dPYXZNN0w1OWxONDRGeVdZU1YrM1phR1M2cnN4YzVo?=
 =?utf-8?B?SlNXbWJQbjB3NjNWRUdiSTE2M3dVbnhsZkpoSnAwVEJiL1R0czZGQ3dyTGEz?=
 =?utf-8?B?Z3Q4ZGpTRWVPS2FBbGJVVkpzMFd6QTNoS29uN2w1dnBLSGhPVGxDSDRUb3ZE?=
 =?utf-8?B?dktuSjlDNzRKQjJtTEZYNUJJVzRPaU1LTnlIM1BMMWY5KzBucFFvNW9Wc0xR?=
 =?utf-8?B?NDZJSlJjOS90cllQUVNLS0Nadkk5RlZtNnA3VUlDdVlMZlVDWUlWMjJzVit0?=
 =?utf-8?B?OHdHZXl5a2trWnYzcys2ZXpCaTR1Z0dmeHgvTmNYbkNmY01ZaDZ3Wnl4WWY5?=
 =?utf-8?B?T21RWURpR05ERnhjQmlPcGdiRitEZjQ1dlRpK1pzQXpaeVA0Z0hKdlRBNVV1?=
 =?utf-8?B?ekZvN0RWYU90WHZDaGdQUEZObEVOaXBzTmYvQ05oSTVpQm1LNHZFVmNqMU1q?=
 =?utf-8?B?WE9uc1lUY0I5ZXlLRmF6ak9vZUhFV01xOC9JbmxxU1lTWHRRNFpjdDkrWGRE?=
 =?utf-8?B?OUlwZk1lMFE2SzV1Q0ZQRzNMVmlLK2FWQTBiL1d1TjhaTXlGQ0o4cU5FNWNY?=
 =?utf-8?B?RjNwUWJaWVJ1MmlEYUkzYUFDeEd0cEJ5dThaajNNb01ZRXJWR0Z2dHBxV2dh?=
 =?utf-8?B?NFVEaVhRYlNyM1E5RGQwd0w5SVZqTlFTNHUyeWw0RitLdUp4Z1UvcGZkejRI?=
 =?utf-8?Q?jrYjE2m6u1rrOYmz8Cci?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <C75F22F84BC52846B0F4A995D485F19E@sct-15-20-4755-11-msonline-outlook-3458f.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2b6be9-b58d-4b22-16ab-08dc11b448e5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 08:15:19.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1306

DQpIZWxsb08gV29ybGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEyLzEwLzIw
MjMNCkZyb206IGJhc2VfNjQ7DQoNCiAgICBBVFRFTlRJT04gTkVFRFMgQ09SUkVDVEVEDQoNCkFk
YXB0aXZlIGNhcmQgaXMgYW5kIHdhcyBhbHRlcmVkIGZvciBHaXRIdWIgYW5kIHNvZnR3YXJlIGlz
IGxpa2UgaXQgY29tcGFyZWQgYmFjayB0byBub3JtYWwhIEkgd291bGQgbWVzcyB3aXRoIGl0IGJ1
dCBJ4oCZbSBhYm91dCB0byBob2xkIG1hbmFnZW1lbnQgYXQgR2l0SHViIGxpYWJsZSBmb3IgcG90
ZW50aWFsbHkgaGF2aW5nIGEgc2NhbSBvciBwaGlzaGluZyBhdHRhY2sgb24gbXkgY29ycG9yYXRl
IGFjY291bnRzIGFuZCBjb3Jwb3JhdGlvbiwgR2l0SHViLg0KDQpTb3VuZGx5IEkgaGF2ZSBubyBw
b3dlciBvZiBhdHRvcm5leSwgbm8gcHJvcGVydHkgcmVzdHJpY3Rpb25zIG9yIGNvbnRyb2wgb3Zl
ciBtZSBsZWdhbCBvciBmaW5hbmNpYWwgYW5kIG9yIG1lbnRhbGx5Lg0KDQpQbGVhc2UgbWFrZSB0
aGlzIGFjY291bnQgYmFjayB0byB3aGF0IHNob3VsZCBiZSBvZiBhcyBmb3IgdGhlIGFkYXB0aXZl
IGNhcmQgZWRpdGVkIG1vZGVsZWQgYnkgTWF0dCB3aG9ldmVyLA0KDQpUaGFua3MgZG9tYWluIG93
bmVyLA0KUm9zcyBOaWNob2xhcyBPbmVpbCBUaG9tYXMNCkNhbGlmb3JuaWENCkRPQjoxMS8xNC8x
OTg4DQoNCg0KaHR0cHM6Ly9naXRodWIuY29tL21pY3Jvc29mdC9BZGFwdGl2ZUNhcmRzL2lzc3Vl
cy8zMDU0DQoNCg0KUm9zcyBOaWNob2xhcyBPbmVpbCBUaG9tYXMNCnd3dy5naXRodWIuY29tDQp3
d3cuY29pbmJhc2UuY29tDQp3d3cuanNudWxsLmNvbQ0KKDU1OS04MTYtMjk1MA0KDQo=
