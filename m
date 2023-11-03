Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101010E5
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2104.outbound.protection.outlook.com [40.92.59.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAA5198
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 18:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkDtUKUaI682AgMpF+VARdTr8Ndl2b13/HkLhgjMuyuDIEgxb8xjYqa7J7ELNzCWB1xfHCYvJt5khCmF4DLVLA0YWBKLfVlSLAl3KkMvniMMNTHCmbhaLUqFYCh9jo+XJo+MZXXM28EUZJnprCJbUJCOMHvYkHCHz1xEV1apWbWkGySemSRDkUXmjyZ3j5/LgFujKy8gNec0Z7lNDDBUkwrKKyPlHkFTxQ7aXfAqiiONLDhhhPdJQQ120JCVmbYRcQRhq18PtgH+aN4AbSQrjKipbcokmiw5HIgteSWrhbwmV9TpSYxbtP+wgmylTNfl3uhClKEqFfJlD+O/tZctDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ed3Krup+YxY+5lXxbitm2OA/eZ56zIhaG7QBap8alcY=;
 b=lL8izDgb+s97sMcuUVvAp/JVZtNxcG7lAMrS8JBvKrqFtzZWj6MWRBiL+0OcaJxD5BA3pQRCZB/o2mQegsZuGj8wgH7bg4nt3+NrMpdts3avq/zOIWS+DXnoK2sK+A8ak190rRLXleQB/d5ilgxGjuQL6NZx3lfC+a7AZChzQo/XVxOyaHQY4+sRprvq/AGEZjG7FiY7Sn5LbgkNqP3JYu8OVFA6+1UqWJaKn5xLygyAtjzQAohadIFymwaQsijIzgcsh0CkofECt7VM+caPOdv1L3eFc8JWeR3avSVhgndTeP3hi7JOuUa7UekBaN7stpktvOYN0tvUyit9LEBKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PR3P195MB0878.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a3::5) by
 VI1P195MB0541.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:153::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 01:25:12 +0000
Received: from PR3P195MB0878.EURP195.PROD.OUTLOOK.COM
 ([fe80::5e3c:6010:6ee7:e299]) by PR3P195MB0878.EURP195.PROD.OUTLOOK.COM
 ([fe80::5e3c:6010:6ee7:e299%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 01:25:12 +0000
From: Robin Dos Anjos <robin_1997@hotmail.fr>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: General question about "git range-diff"
Thread-Topic: General question about "git range-diff"
Thread-Index: AQHaDbc9AahPo/u4nk2yXD+mzwKkwLBnqyLKgAAiANU=
Date: Fri, 3 Nov 2023 01:25:12 +0000
Message-ID:
 <PR3P195MB0878B1E5B7E63F767F34EA999BA5A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
References:
 <PR3P195MB087847E68AD2032148EFCA039BA6A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
 <xmqqbkcblp1y.fsf@gitster.g>
In-Reply-To: <xmqqbkcblp1y.fsf@gitster.g>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [3Hlpb4fKH+JVOSzQloIHRtmpZavZdj49sjK9CevVAfaRrRWZOS2w7n8lHVb67IcU]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3P195MB0878:EE_|VI1P195MB0541:EE_
x-ms-office365-filtering-correlation-id: c6ecdfbf-c568-4330-54ad-08dbdc0bb9ad
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2bkeYZyB093uD/Klz9mh9512alhHyRTlixh4pIoFt06044W1lDUr/8SEqnU67Z1QP0YjfCxs6b2FQM36/56B5/YEE+Q6dqylxqQ1KsGcJv3NiCR004ayJfUEz4OjZUrirc2of1WMNOZBwcLmZ3xLbYgV19lyvh3vi/CRHFwRfNiW7UHV/AoIB9D3tzUEr1pgKp7mG7rk907zUvZQ98FVFISwnRg7B6gniJF560YNA79oWueS3UuCarOP8vR5MnEEOQaNq6m6L0S34H2TJh+tNQYAsEIxgIv+2PYst74wZCgvuxCTjDmF7V8wbvCc6iwBr/3VvAR2K+vQKgCqTYJqSkqzQAm7yeiv3vrgh1AQz7NyeOAc1QckDo/vfJM0xfibnaYuXVSTj6ea2p0QP5r8F6/N6wUq4agN+lohgOoA42KPlF1Gj9eO25wyKD1xfIYKSwjs8/7HaWCc6nD8FUabX2okFzGDZe935h/NP+mNmsfVraM1XeiS6OdSqKsESFSCFy/NkWhjfirT+CuAXGFoB/gbDySnAvdVRncs1aQK1BNK6rHstuOIqC0rC7p575ck
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?G2t14a8/Jk0GHI16uqw706qBBtnfc+98AeksDLhQRluZTnGgKUH43cDXeH?=
 =?iso-8859-1?Q?cFMgjrVv2NJW/Bd/u4NbDfJFHssVyhoE5AHfHYEh4BJyp3pa+livUVciwH?=
 =?iso-8859-1?Q?Tfg/5E7TWQdXbGvXZ+0y6oWKFcMW9kB5GGIuWiPIX++FzJuSasjXysQBRo?=
 =?iso-8859-1?Q?5HPTtSy8Ld9Jj4+4mXCun5MgbGdwFUiVzjIgR3TwFjWrTFkoSSIZV8fO9e?=
 =?iso-8859-1?Q?3vvAPrOhXFTKTgZ3Pmmc8KrEKBCEemPkCffx+M7YAd9vQS/EUogNeI5fxg?=
 =?iso-8859-1?Q?ECcqwTsq0tDAyqf0bjt5B1WnsQzEZHhvbT+FiD6RdmY9JRWDHExpkKE07H?=
 =?iso-8859-1?Q?QBpiNVg1B5Upwy5ciz3XzXxgIJwSNLbPR9cc/tdzeAWNkVs5pO2Z8nKyOs?=
 =?iso-8859-1?Q?NPWB67SDQas3D1tctLI3wNP9NUWYf8U/nIJoOB3xKYuWVmw/nF1ocUPea0?=
 =?iso-8859-1?Q?BnTad1coRRX3jFoctOwHeitf0FYBvhJt0ZeOAa47cpzYB3wqzdb2LQYfWl?=
 =?iso-8859-1?Q?SWJfc5N7izezwTAIaU9OugMc0xfhK1mARh7zsiH8DsdIUG9L7dwL1zqf6A?=
 =?iso-8859-1?Q?TZgjplswKPpVKIdmq1wUPCMlg1QGzGn/YdhDfZDndO7/9xSQb3jdysM6kj?=
 =?iso-8859-1?Q?FMqPCqFYNexQGz6rmTTBQEYWPiIB5Hrc+SmB41s36IicGAYtsB2pTzmS6b?=
 =?iso-8859-1?Q?hikHBnURNoKgiEI3F9F3+ogfi5F77Q8JyTAfTV/GiWxbPbcMl0k/Bjkdjn?=
 =?iso-8859-1?Q?8bBT8ye/BDH93ZzMfpgKgqyhDHGiiITS3qITjdseXugf+yyDrDc/6IObwz?=
 =?iso-8859-1?Q?BnnC1E1aZuI1n6dDxyc1/37U6J+0bb3Na4VBcC34mCwGt0URLDbv/Zg7iy?=
 =?iso-8859-1?Q?6Zrg1IcFHqqcdZ13leUj7seutAx4Fqkmk/cOjqxXY5M1qJYPN273TbpcXW?=
 =?iso-8859-1?Q?u02SQgxAa5e1UjZZvudmlcwtHYh47qTN7PfLrDBOy/3yCGfnu3rYcGgvBa?=
 =?iso-8859-1?Q?eygxkPJusbajg0xTKngCFoFyx6p7jbxepZMD1vQNYQIZNpAEaFIGS0qskD?=
 =?iso-8859-1?Q?OgjYDgFgjwpTmht/hWAnMHhRhGkmk4kiN1vDT1h3+Yn1RltyNt/E4iukCb?=
 =?iso-8859-1?Q?Mg3czXrJZEYGyPns+5v3H6ig/9H8Jp2ELpeDsPTjP1nXmq4Oshct+JzVVT?=
 =?iso-8859-1?Q?JW2PsBPLldiSPwy8j1zvYVV/IuETofBvRueGf+DfI2vwB2Cjez2AnVGEd5?=
 =?iso-8859-1?Q?bS1rqYVS1zZOVBlj1nkyM7DNaHWOOGCx10ew2Vnty3+DH0gUtAyJZCs6b1?=
 =?iso-8859-1?Q?6b7deQ0ND4IXrYY02Qxt/lG3Uw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3P195MB0878.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ecdfbf-c568-4330-54ad-08dbdc0bb9ad
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 01:25:12.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P195MB0541

Thank you both for your very quick answers and recommendations! I will chec=
k your links. That sounds really interesting.=0A=
I'm happy to hear that you don't find my suggestion entirely stupid. My use=
 case is so specific that I wasn't sure it would be very relevant as a feat=
ure request.=0A=
=0A=
I will probably take a look at the source code too. But to be very honest, =
my experience with C is quite limited. I have the basics, but I never pract=
iced it in a real world project. So a codebase such as git's will be way mo=
re intimidating to me than sending a message to this mailing list. Building=
 git from the sources would be a good start.=0A=
=0A=
It would be an immense honor for me to invest some time to add a feature to=
 git. But adding this mode to "git range-diff" is probably very ambitious a=
nd not very beginner-friendly. I will check the code and see how it goes. W=
e never know!=0A=
=0A=
If you have further recommendations to start this journey, I will be very h=
appy to hear them, of course. Thank you again!=
