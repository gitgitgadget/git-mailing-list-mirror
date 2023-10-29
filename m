Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D38A49
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h68Icf49"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2036.outbound.protection.outlook.com [40.92.53.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23DC1
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 19:18:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAA3yq2YAO2UUdPjyjwoeYrHH5G0v6e6TQILySJOZdLrP/5ddKWnXKK3GfeEjQqhtkzWsVfT5pI0ZzGxYgWdDsaHtl8f8t/+cP6uAkI79nuYwUTTqYRdfBk9kqht02vkMASI5usOJUVbdVQm7/qpIBWZLK52JaGJgEWSy89hBfcxV/5G6zPA7WA5gqAb+TiX4iyAq48erPOLK8GfibbpidgUabG8zaZH0fLVOCC1sKCVJIfmjPScs8iRnqBPH32BzrfX489zOguYal3HrBVqNrn1Zan/JoBviuJk/1neDBugFk6UO3GpxxO7K4W2ugvE7YcNfFmRbL40HzaUQQGzbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdiVvQV05qmd7aYSAHKif6X85UL4VeGzSDQMMDvZcPI=;
 b=awhCzvYYLWNLOae+LjwGCyJUTzr1Ho5egvuldzfpEXkxaPwN0QzsFjaG5+mJf3PFRV2U5N2jEiOgoHUE7V5BsTlNoh7FHM4vay4vaYhuREMKdH4eT0YRGc/fVC9nvMS5C4wf6388e0qhfn07i2N9dgwn83YlcPujtjyfovmGPkmorTwvJj9F/g9YxnT/1SUA1b4NERHoORiNW6BoQniJ6YahbDGISqdUYm3lVIfHwr8AM9zochZzbNQ+8cVh9lQchlBiEm7dTsyLg6AeD2DqWeg1id7kb0YeY4+qnD4LxrGoGkNRacAgapSmzRNH0SKI/ZPUTgLqaUtfQVHE0susKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdiVvQV05qmd7aYSAHKif6X85UL4VeGzSDQMMDvZcPI=;
 b=h68Icf49uPNTZ78OSI/ncYFo89qux4jkW2BKsULXqbhI4gv5kLql5SXAlJ2OYYkR5AdURerZrzUGZI49QBZsXjsUTp+stBNfKBIQFgSLLapvX1RCW/JHiSsGo3LWgdailqktvqaHrerfsxnj2jCd8xIQ8fnvtzc2abO2uUPseKEPEyu8TjpFp1+0fJ7gtvkGGyKT6JWe8i1wBwG1mFSZSCWwpaFFfZpUgxDPq+Kpcxt2ev4PnsdTa6OTJnra8U8wv6Zm0WHumGewfnlCLPFS0h3hTLUyToK0reNXSBuZuVsOKz+sWiEHhnD8A6sY4KgkOnE0cbYcH2oUYuNdU9NRQg==
Received: from TY2PR0101MB3549.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8005::12) by JH0PR01MB5795.apcprd01.prod.exchangelabs.com
 (2603:1096:990:4d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Sun, 29 Oct
 2023 02:18:39 +0000
Received: from TY2PR0101MB3549.apcprd01.prod.exchangelabs.com
 ([fe80::4716:6309:e304:4d1c]) by
 TY2PR0101MB3549.apcprd01.prod.exchangelabs.com
 ([fe80::4716:6309:e304:4d1c%6]) with mapi id 15.20.6933.025; Sun, 29 Oct 2023
 02:18:39 +0000
From: h hm <haoming9245@outlook.com>
To: "sunshine@sunshineco.com" <sunshine@sunshineco.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, h hm
	<haoming9245@outlook.com>
Subject: Re: [Bugs] Hello,I can't build git by ./configure
Thread-Topic: [Bugs] Hello,I can't build git by ./configure
Thread-Index: AQHaCg460QSu5E1MEkyt84XSesw6MQ==
Date: Sun, 29 Oct 2023 02:18:39 +0000
Message-ID:
 <TY2PR0101MB3549C9B4C8344CCAC654D663BDA2A@TY2PR0101MB3549.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-tmn: [eW1DOuyRaOLzOz2REDeN+22NujvApGzCF2kcCb4uaqI=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR0101MB3549:EE_|JH0PR01MB5795:EE_
x-ms-office365-filtering-correlation-id: 8f9b5717-2d3d-4e58-3b42-08dbd8255d1f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aIKe6G/XFiNcVmuLNf4KGyRb0yEgNEr1vkTdHgK0Zbz8ma+0UpLCEXmZqR2SCzX7RG9gcA6VcZuoafEVWmBDsDYU+Rqe4dwfTsTqywRAFj3TGD8W+O5UelvvzZ1KQRm3eVlJoS/ssh3HJLnI0mryb+/nQHgax+AekAoVDO6yvv4ZdIbWx6T+WlhQVnIR2ZVy340ZwD2dDn3yYuYMRDcaZmoTGpqiRqCI29mR2pKFz03VtvvDkj40D26pL69LLtenILbJi+5kxcGNbrmMTXiJ3Wq/zu1TnBoVS7YnstrtUJE0z/c+Aeb6gcJiazX00ZnI55sXS/cwd5m2aommxzo/JHDoYuLcpQzT9CcuudtkvsB/Vg62LIzHecn64AC7VKdcukA7znkqsLZvBN5jRaJsG2OzQrtK264kWOBUO9WOgbMVDooz36Lqu22Eo9edVomp/A1Upm/yIuFROEEBVwv7e/IZxUeJBsHDU4tw5wJA+7F1c2gCDDFIgzwyJp0KMzTx6Dss+yC92uyZ3+r9zj4k9sJ3VAnqmlhJ/AIXz8EB4A8pwUE0fAR5FYy0l0jUgnDKxbrl2UuB4sZY92HxYt7T21kvquW2IQRUiq5W/8UxCJNOWuxIuUFkbBn1S2lYvHVn
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?QUZLV25kamxRLzhXeVN0Wm44TC9kRnpkQ0h2bkE4TW5aNWZ0RC9NcjZ3N3Uv?=
 =?gb2312?B?UFhhSnlGWmFQaHBwL2N1YkZtK2dlNjdHaGFIV3I1RHBxYW80RTdFK2FXM2ow?=
 =?gb2312?B?c2VGSlJBdmo1cGs4S0lKRUNIS2ZlVXE5SzN5eTdKOHI0VGxEYlI3WFgrKy9S?=
 =?gb2312?B?RXpITjNXVG92U3BZNy9WWVF0N3VIZWZUK3ZOajRxVDlOZVVkVHFVejBHaDBC?=
 =?gb2312?B?eWt4SnJ3SlAyZi9naTNBNFhuN2RXT0J3dnlyeThPeWhtVWdqamtFL1lTdG5X?=
 =?gb2312?B?TTYxMnhERzRQRzMyK09WTjRUMGxHY3ZMS3ZUcThxYnJnMTBpVmExaGI5S1Qr?=
 =?gb2312?B?L2NMQ2tqWjlZL1I3U2R2S3dIRHNScitCcTRuMFRaaG9SUlV1YWlza1JOa0M2?=
 =?gb2312?B?SEZldXBDYjZZT1NrR0hkNUFWMVZsVlpvR1Y3S2xsQTR2TVhDSkFQTUplanll?=
 =?gb2312?B?c0VZbXpmL0ZFcjBTbDQ4YmlhYVNuUG9oOTgrV09xOWFEeEgyc29sNkVva3oz?=
 =?gb2312?B?ZzdHRXI5Y3VHejJzTTVoL1ZhZ3dUNTQ3T0k1aWxBeDlSQ1B3Q3J0T2ZZbEJq?=
 =?gb2312?B?Z3Vvb2p5QTQ2WC85SkNtb1BDVWRuQkRiQ040eGR2b1JvbE5qUUR1OFlBTXRv?=
 =?gb2312?B?ZGlMOUZPY2ZuM21aOEJEUytxT1B2Mjd5cGN5U3pGbTRpZmF5SlphMk9WaU9X?=
 =?gb2312?B?MkExdk9uanlDNTh6Y1ROb3RGb1pVT0pkeWZuc0E0RFpMYXVTaHBkZy9wRVFE?=
 =?gb2312?B?UXJGMjBhc2lVQlk2Rk1sUDJhUGUzdjdhV2VnbkFlL0p0UTg0ZHdRSUtjd1Vy?=
 =?gb2312?B?MnZQNU1wOFhUOUU4aEZ3Rmd0bzRCV2kxeWhXeUt4c2dad1I5K3JnVkhkRlZZ?=
 =?gb2312?B?TkNDWTUySE5VaHM0aktrRXVoODNXOWF6d0hMWVFTS0xvKzNvcUFmRXFxb2Qw?=
 =?gb2312?B?V0pXOVlvdmpOaGdoS01kUDcxRUpuVE1MUXNMYkdxbXV1bFpjOFRDbFloRHVh?=
 =?gb2312?B?bDB0azBKb253Z0NvYTV5My9hS05UWnZsZDZnU0RCR0o0NFAzckRMRWVIS2JU?=
 =?gb2312?B?ODdyT0c4Yk9HbUVIeDdvRks5NVRHOW1yZ01uVkNXVzYyeWFmRkFxL1dmL3U4?=
 =?gb2312?B?VkVkS2orRGZkTWVHaGJkRVdaSjJYVnhmVVJoQnVRN3F6Nnc3Q0RUeGZ2aTlO?=
 =?gb2312?B?aitUR0kycHdDNkxnNm9tNkZsYytERjJ6Z3RST1ZsWW5yN0FvMmZqVHcwSjRL?=
 =?gb2312?B?alkzZytrL3lreDA4dTJ1SWVSUDJjeVp0M0pKRTUwM3lOaWg4bU8yUFhWeDdp?=
 =?gb2312?B?bWs4bnFrNUhKa1haMU9VL3VLSlg1TXlFTjNjOFlwTUFoVEI5azVWYnI4UDh5?=
 =?gb2312?B?aEZHc215RmxwK3ROS3VuZTZHaHNMbElPd242d0NwK2N3Y2VUbDJkQXY4WWJs?=
 =?gb2312?B?U3I1Y1VqZlN6QkUwdkxKQXhvZUhoUTZxRkg2OEx4cDlBS3V4aCtrWXJXYnBO?=
 =?gb2312?B?bWh2Z3RWVnMrQ1dnMU9jeW9lOGYyMy90eEx4K2dvRzJWYmdaVjU0K3ZHc0Fo?=
 =?gb2312?B?cktiaUpjQmVDa2dSSWM4cEdZVERVRnQ4SzhwUXNOK1lHOFc1ZHQ5bFphd25p?=
 =?gb2312?B?YTNsdFh1MitrR1J1TStxU0NTSDB6c1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB3549.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9b5717-2d3d-4e58-3b42-08dbd8255d1f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2023 02:18:39.0706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5795

SSB1c2UgdGhlIGBnY2MgY29uZnRlc3QuY2AsYnV0IGl0J3Mgbm8gb3V0cHV0CgpUaGFua3MsYnV0
IGkgZGVsZXRlZCB0aGUgZ2l0IGRpciBhbmQgUmUtdW56aXAgaXQgLGl0IGNhbiBidWlsZCBub3cK
TWF5YmUgaSBtYWtlIGNsZWFuIGFmdGVyIG1ha2UgaXQgLGFuZCBtYWtlIGNvbmZpZ3VyZSAsaSBk
b24ndCBrbm93IElmIHRoaXMgaXMgYSBidWcgaW4gZ2l0IG9yIGluIG1ha2UgLG9yIGl0J3Mgbm90
IGEgYnVn
