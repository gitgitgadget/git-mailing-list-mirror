Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rageshkrishna.onmicrosoft.com header.i=@rageshkrishna.onmicrosoft.com header.b="LMzZfMi3"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEC11986
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 09:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+pKybvYZv3Q+5QSyIXsBKGh+t2S9osyC1bRPkmY16VWcFwx4SWCMcHTpWdnQ70YPNh/xq3N2GgUs12jwurBClmRPblWH0Q7FFTsRl1atpWMgIQxoRObLFLkyDVKctx9uOcpRbwrsBNKcCG2LkDpu1mDAkI0xATdTXbZf1Jbpw4dVDyWA4Ehu5B0C2efavg1L/v0NcibjbBqwNukAbGRWcY+UCc/8LgRNbwkgsopZl6qkiZReCqFExE0hZSbF1kisjmgAL02mPm4FbCt6hOky/ma7VTje6w08rjxoPXCdLqz+RyCdKz6rLNQS7AzgiiRtrep9YNeeeotdVpdYoV2Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BewSW3dTkpSYBnC1vlpGdyG26G2yJk/JJqmcPu7LoR4=;
 b=lAE9+tW//EZZdvBewcz9WHP968PhR9u0DmkoWLSEaWTAVmrRc8N+2I+sZhf8RJLxKlvrkuf4TUpmqZlvBck2Z8MIAm9GHz7dDPgkrVhW7xHTm0T5GQPjIH/Wn3OGVeAENpO3Zaie9LKXVs1FQuG4IgzJDDmlT+bqk9d0uiTYYZIzcxd5TuoAJtU6R7gtC1ZyxxKD71JurzXooLduRKW8WOpItZqrmWPh9BxQFWrX8xry+sZYusFVzA05AL3joSlWyrA51nQUGtgSsb9ADfzSDly/mcDq3eLBWcrzJXrapy5U6iqckoUwiYicSrAgW4yM8wMkr/ETya/quliGnCc+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rageshkrishna.com; dmarc=pass action=none
 header.from=rageshkrishna.com; dkim=pass header.d=rageshkrishna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rageshkrishna.onmicrosoft.com; s=selector2-rageshkrishna-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BewSW3dTkpSYBnC1vlpGdyG26G2yJk/JJqmcPu7LoR4=;
 b=LMzZfMi3veZ7YlZc7fAPIkduVB83Hx67gkKPWXDvIhCwjs4Epq4dcZlMcZ3N7ns4YZhWWkS7hqS3bYGnv8y4dJnFPBCaKNdDiTBvmC4PtIlq3u7wqonjCR1iMQ6C0NBjCZ/eOsSXpz/JdIJuiMF/dxsUIxuf2rgeP5yOxHMmYjc=
Received: from TY0PR06MB5442.apcprd06.prod.outlook.com (2603:1096:400:31e::11)
 by JH0PR06MB6850.apcprd06.prod.outlook.com (2603:1096:990:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 17:53:15 +0000
Received: from TY0PR06MB5442.apcprd06.prod.outlook.com
 ([fe80::f8a7:e213:c1b8:dc97]) by TY0PR06MB5442.apcprd06.prod.outlook.com
 ([fe80::f8a7:e213:c1b8:dc97%7]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 17:53:14 +0000
From: Ragesh Krishna <ragesh@rageshkrishna.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Problems with Windows + schannel + http.sslCert
Thread-Topic: Problems with Windows + schannel + http.sslCert
Thread-Index: AdoqxlN6hY5l/8FIQF+TIZhwEG8Y/QAAg3Sg
Date: Sat, 9 Dec 2023 17:53:14 +0000
Message-ID:
 <TY0PR06MB5442CF7CC4F1952500E8C98AD189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
References:
 <TY0PR06MB544239787E909DD4EAC1CA42D189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
In-Reply-To:
 <TY0PR06MB544239787E909DD4EAC1CA42D189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rageshkrishna.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB5442:EE_|JH0PR06MB6850:EE_
x-ms-office365-filtering-correlation-id: 080601cb-7bb8-4424-6c50-08dbf8dfb7d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ciJ/COOhaUgY4L+8Z+jffiUT98FIgcksaobsb3mnZUMGCNzcnz1fcC6TFg1Kt5lbMY1Ltn8cHexxDqrj5JnKImytfhhHqjgFUuQsaO7smNotbJDJywMFbRmVUz8gQ18KKR7JgKyXIocJQQwLN71FcS6DC6okxkA609h0uTyLUj+7+MTlzYZt9odstVg328koHh+yCdLvWMuzp/VBwwAp4zwFbuxpNw5qFKhfZACq2d2h5yWDKSq/Psp6+goGPxA3aSuywern3sNkQh9+2ml/zULHQnv2XSgwR3Lp4wiCF9/wQTOySf6paNrCB21yowcus//7j51KkJFZe8eP4CU58PhM4VenQ2ABbuvRdEAzaw+uf13tRK62ALBBv7+Ux0iE6P1aG6mg6CEIkv1WHAt1DrtUkbHtrjpclOvpMRkKjRBqjL7m+4doDMzyUVW66CJcguNrssrfLrdXLKFlDugp/+uaZb9vyHZZCkBoTHlCMK9IMzcuWuIKlnWHLsHMkYtE6y6CWEjqiuEEIgtubcV8WgFeeUFVkeKIREcL/IhlsJzVw5gdpFVdhyBFmK/ILg6W2h7q0bb8FgT3mxCctWFVZcBNG0s6YDyhoKt1mlu+onzy3JpU2iT7YiTMucgk5krp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5442.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39830400003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(26005)(53546011)(6506007)(7696005)(9686003)(122000001)(2940100002)(71200400001)(8936002)(52536014)(8676002)(41300700001)(5660300002)(4744005)(2906002)(316002)(478600001)(66476007)(66446008)(6916009)(64756008)(76116006)(66946007)(38100700002)(66556008)(86362001)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?x+68SIKp1HxUSdi7z/mL0Fu/bsy2iR+0A4ouIRPBrKRadfGZ9aHtI0cIwEUq?=
 =?us-ascii?Q?3Ejz6McGPKPCJjBzfsZH3QSKWj8xOxUvFPwlMRkLCm1uyVgbRRAn6hfd8JRO?=
 =?us-ascii?Q?sbDHmORpHtBtpY75imU5zuILtw7DCF8QDDn1mahciFfv8TAe1SGEcwenHQ3W?=
 =?us-ascii?Q?+T82E+8Vf18T1SKorPT0XkQ2+uPw8wvJ1YrwDF+PWkmq4J+yPYMWjnClVbIr?=
 =?us-ascii?Q?sBFuo8fADkXsY8NqgjA+ary+Nr7GzFo8ZvyDbh/AUSxxsez81uC554j3d3QL?=
 =?us-ascii?Q?7HhAwHp99g+Rv3kvEWLkE0U4kzmiAe+55c1jYXHdVX1coUVVCyackMd3TkCA?=
 =?us-ascii?Q?SIiPFgjv3bjCv/BFqVAacCYQjfwv/Gde7KpwtiVhfrGsGeHEUUM785BFpuh2?=
 =?us-ascii?Q?Vy7jL+SJU3pGijq5T8P/QyfyC7RJLXexVpv1EG4SXMZcRL5hjaMoZS/RXTt2?=
 =?us-ascii?Q?paXlvasJpGoBe+0VQsDoDRKk2RkZwnPQKq3Eq9a37J2OTpkvTPcFlTgvRR6b?=
 =?us-ascii?Q?Mo6ipfJT5e3XphoksJZ/KesC/apwWC7dIEmSlcAnXqv44ciwSAU837gOGndz?=
 =?us-ascii?Q?K8mwRchFuJlNxHbTLOZJ51wi0FXLNpBlIFVkj3SgqbRtJeRKsygE0FbhseCs?=
 =?us-ascii?Q?oD+HsIAV0WXcvzMix4jRvt8yAe5PgF1E2fv8IbsmOmEODe01dGtQIGuFHQtR?=
 =?us-ascii?Q?S2UrS4KB68PLBCqg/B1H64hqTZij9DVREijxHgdm07wqXgRkYtFUBLZEDAbB?=
 =?us-ascii?Q?VaG1d7eGVW1/+7NUGsy+rEfK+bcssU3iI/Ssz2lKJeh8Pr9lrbIW7EiGhvi5?=
 =?us-ascii?Q?MQ1k13M1g26Cx/f3icJY7cxUTY7UU2tVW1Koy5S7lefdaAsgf+js2gaoDEL7?=
 =?us-ascii?Q?weTRp+Kbp/i5yzYGo33Px4ZhXToBFgaM4cynUTuKXgcfmYu9FBejFdHB0Cf1?=
 =?us-ascii?Q?5iE0B/A8JmtFmJ51OYhFxDvNh4r04Lq4zarrP2IwhnDU79puMyZqaHszQOlR?=
 =?us-ascii?Q?mHHxb5Rh2HMyB5IIs/bmO5T4PUTYlaYv9QjP1g5yclqxGsajPrBUxVRbJx10?=
 =?us-ascii?Q?LLsZPBMoxFvIHPWGt1P3xHjIeOR3CYrIeWMJb0m5iUHuFgyrh0ryno5vQ5T4?=
 =?us-ascii?Q?8emnlKT4VRjq2sYbnMMF9rHac4G/OMe7rAzakBvvymkqJBbpb9PP9eY2utwA?=
 =?us-ascii?Q?X5sQ6lHiWkQ8hEFl4X77me66/ymTAOcQk+NrNMzoN+TPQDHjwZiHMQibFR0T?=
 =?us-ascii?Q?L5vNpLdhJha1kx9y0GIdFcJCv8J55lbYUmOsRYB3Jc9cdBUj5Hvbqz+UpgRy?=
 =?us-ascii?Q?zY1xo/7OdIXWFH2pcEPzZHsBXpEaohu8N1IwU8CNHfiSzcqiMlwOPk3DAl7X?=
 =?us-ascii?Q?n+SOXT4yhsJhvfCLGS+AGoiAqg9U6TVI4EtQsknh/q2O/UcXMEbdfVugWpN4?=
 =?us-ascii?Q?t+/cyWWH46XU7TmalWch63vTW0BRC2DQ1BOO2plxBAkWG7XMzR/O35noxtNZ?=
 =?us-ascii?Q?9povLwPz6elzClC+KhZlIoF/CfQ3Kp7pByK+t2vGDC00XzovcH3d1KwkAarU?=
 =?us-ascii?Q?tMnBYOFPyglLrrBok1j5CRV1btfDmX/KmhxBPUsX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rageshkrishna.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB5442.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080601cb-7bb8-4424-6c50-08dbf8dfb7d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2023 17:53:14.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb23b077-6391-471e-8a55-ab9f219e59ad
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BSieJQGzY1T+JVLtb2vcyThtE5CsSUkT/xNXanIbvOAKtt/ZDjEa2z6MABkuZVTDCdlrQ5irDq6yyz9Id80M+kLW5oFbahh4afrVXGfVW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6850

Please ignore. Further research suggests that this is an issue with curl on=
 Windows not yet supporting client auth with the schannel backend. Sorry fo=
r the noise.

-- Ragesh.

-----Original Message-----
From: Ragesh Krishna=20
Sent: Saturday, December 9, 2023 11:08 PM
To: git@vger.kernel.org
Subject: Problems with Windows + schannel + http.sslCert

Hi folks,

I'm trying to use SSL client auth on Windows. My git installation currently=
 lists only schannel as the supported backend. The problem is that this alw=
ays gives me "fatal: refusing to work with credential missing host field". =
I can see from my server at the other end that a connection was attempted a=
nd then terminated unexpectedly. However, I'm not sure what git is expectin=
g me to do to make this work. I suspect it is an schannel vs. openssl diffe=
rence, because the same credentials work fine on a linux machine. Is there =
something I can do to dig deeper and understand why this is failing?

Thanks,
-- Ragesh.
