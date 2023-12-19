Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2082.outbound.protection.outlook.com [40.107.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5F14295
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rageshkrishna.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rageshkrishna.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rageshkrishna.onmicrosoft.com header.i=@rageshkrishna.onmicrosoft.com header.b="HIGmMDlT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USgGIESe3dzVOVgnEs39pi9JmeR1RZVLIAsRGurlRI6osfGlFjAKKKB8v6hZZDQA8mGqozwAPElT2+/ng6aWHrFIXh5nKfEkKDx4L/T6k64tkaa30pDlP4CMrTID6mBT+z1nlLmR43GWEwpLqhEP22Bo3XCEFo5SDKO/TbGmzRiIyukSQ2ghSnvNs2L9VX3bGNuv/YhX+vvdFa7h4EeEpHno8mIOLL1GPlU7sVrPWVqdggZcCUi/+c0zLEmHDiJNwTCeBVa8M0av9Xec0iJQiyz5GLpEwIuht1YowNPsAcqOKw8HF39zKOQNEvkYDsffh/DEn/5xc/CCvBT8JyGDPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mvZvZnFXsfGjytE/1NWd/vSyXOm4yEqI3NVGY8BByU=;
 b=ehLS4srQl3cCr0MNAgL3odWHg6ZX6cpQk9pPZRlKCy3p+veMQil3cJ/MNEIbuTyaDl0VrieU9pyzJybcVJVpkhRcKJDMtiAxGptF2DMsQWRcQvn/2NWJXqX6OkZKSY+eSDpHe4e5hazLC0xv8ku6SixkpMQv9JyjiWnToXh100Hq6wD4g62asYNGXLfBMyFsvXh8BhmpEjYAFETBBX+yhdV7xvyy07HRGE6U48+HXV60cghMKtEohmTr/bexqQ7RIzyX1BZH1WCl0th1+EXE2qrx6s6Fbdals2zbkDZCrVBugF4pbkuhXCVTYvnFTjXj681AyMRzylFEK8dFz2iY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rageshkrishna.com; dmarc=pass action=none
 header.from=rageshkrishna.com; dkim=pass header.d=rageshkrishna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rageshkrishna.onmicrosoft.com; s=selector2-rageshkrishna-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mvZvZnFXsfGjytE/1NWd/vSyXOm4yEqI3NVGY8BByU=;
 b=HIGmMDlT1fe6CqHn/bNzf5SnAGANoQdJJqYhkedemsNHBjB/Xdoei8eqdhWzlgxP84sKPjQrzndi/40HD6rl13C3zbCScHZ4aQ7orvgBFsprTy3q6CGIQ8V7NHhC18F1gmIuZY5vpJUCCpF2MLeO6nrehlKVHarzO40YMbKEgGE=
Received: from TY0PR06MB5442.apcprd06.prod.outlook.com (2603:1096:400:31e::11)
 by TY0PR06MB5029.apcprd06.prod.outlook.com (2603:1096:400:1bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 10:18:24 +0000
Received: from TY0PR06MB5442.apcprd06.prod.outlook.com
 ([fe80::f8a7:e213:c1b8:dc97]) by TY0PR06MB5442.apcprd06.prod.outlook.com
 ([fe80::f8a7:e213:c1b8:dc97%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 10:18:24 +0000
From: Ragesh Krishna <ragesh@rageshkrishna.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Problems with Windows + schannel + http.sslCert
Thread-Topic: Problems with Windows + schannel + http.sslCert
Thread-Index: AdoqxlN6hY5l/8FIQF+TIZhwEG8Y/QC9Rg6AASo5eIA=
Date: Tue, 19 Dec 2023 10:18:23 +0000
Message-ID:
 <TY0PR06MB54426B92E745B3035F0CC2DFD197A@TY0PR06MB5442.apcprd06.prod.outlook.com>
References:
 <TY0PR06MB544239787E909DD4EAC1CA42D189A@TY0PR06MB5442.apcprd06.prod.outlook.com>
 <710affcd-f6bf-371c-d7e3-8bce3b01da3c@gmx.de>
In-Reply-To: <710affcd-f6bf-371c-d7e3-8bce3b01da3c@gmx.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rageshkrishna.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB5442:EE_|TY0PR06MB5029:EE_
x-ms-office365-filtering-correlation-id: 0bec6452-03c6-4cde-827c-08dc007bd510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EueHeENUpTLY1qiUO4vMEgjGsGMnBfs52OnHnw6Qtxl3c8VnwXK0ZYAFnpJqkHaBAQP3lGahNNNqAYSflqx0TJcOHODqBpTAwROBHCCqkk+cvohyzz+EdFaq6jOxH+P6jyUvxQ9TpxzN/kiRxWOCfoQ+53vGtixD6zGM6yhphGjH1w5xLIK4WvofB8owMljJ8o82RhR3VVN88JrebnKnjxPgMUDFxVrXgIKpAucSxEpAyQZzCAITswr8iFSqWn5fBl06nYRCMZWdvOmBmpYaUivvKEOWeuOvxJBJnG/C7zKdNdtoNbdcCydcoE+AyowqtYZxjd/70qJqxkMZ74QZNi5GVNNUrsYyWlnhyDaMwOJOsUez6mpH5uCL6GPmxewrRNELDEzU4Yc19INC8BdMwwyEz1ZBWDnymu8gaWBJE+sxukk3wt0tiEejPxwl2dcFGh1HBxEsUndJSG1E4YbjHRkUyeL7USo34BjpjwjA9P0SBWXRmyVOcVzOL2E421YuteFQ0uGEzavS5vLKSqRN6OkIgttWCzLafLvEhaQiXj1VmPaDiywKhi4M3zqbwK1+ZS7Tj1fsydc30OmcEz14ZBdNgUfkSznWrmuix08AguUKHzIMibJPdASpITJkPPzW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB5442.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39830400003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(71200400001)(8676002)(316002)(8936002)(6916009)(66446008)(66476007)(64756008)(9686003)(4326008)(66946007)(55016003)(66556008)(6506007)(4744005)(7696005)(52536014)(26005)(76116006)(478600001)(122000001)(2906002)(5660300002)(38100700002)(41300700001)(86362001)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OHn/U0TgcyKbfXkhIA6zYzwT433bCt1n6LKa3OIG98+6tC8EUwNrJCinwhW6?=
 =?us-ascii?Q?291yZcChV9Dhk3V+597hM/dLJoUn3Y3OjHBxIKn06XVJOWggaTB5Qx50+nUF?=
 =?us-ascii?Q?OuR055Ag2Zmc6NaK2oxqfVVG6xStxxJ5F1F43iC+tze9W9FFBpGPAqhv7EAO?=
 =?us-ascii?Q?ETgH/rzXvM3d4mwW+bItj1ldMAI+RNH7o0KnoVXZlI99QQJmiJWbLrmj2RpL?=
 =?us-ascii?Q?7mnq/fzGRAUnk6VCm88PaLJACZTgp9UL5eOTl9Lborv04qh122eAZMx096+l?=
 =?us-ascii?Q?dwl5pGokO0SOW5uedjC+L2GvtWIH4+nRiv0j9zgd4c3qkDFeFla7V52rWXPL?=
 =?us-ascii?Q?H+692ONU88oeeitjuiujcsdR2Y3Od34V/K1s+6vwYOzVCPMZmymxZGBTSUIj?=
 =?us-ascii?Q?TlbLCqrquMELCLk0gTmsKpaX27jb/iRWwL4H+UiqLffMDCf18K5KT9mpU9S6?=
 =?us-ascii?Q?7ejWjeUFngqoo/Fuj2Ye6rWHd6LOGXIyvOrhbYWzIghI6Lx04BamN4CghVix?=
 =?us-ascii?Q?HB5cmOhVSgY7yRgnY/CuuNnbXxuy29GzHpaa6LlHxZ3TmXUqw22DCKCQsLo9?=
 =?us-ascii?Q?dSn1n3ZNej03J0mQKRBXdRI9jJnaSBIbAvZxfGwZOSnvs3oloix5muHR4oyg?=
 =?us-ascii?Q?gmu1AicSoPRvLOO/m6KKYK8wj4DbKzRrPHKdChq6Evd4bz+rYvVRZ8lcJjV+?=
 =?us-ascii?Q?zoyhjQ7TlO0s/X3ImxY7MI1hA5tWd1iLV1S8wyRfwwCFv1VE9mvHaU8Xafk6?=
 =?us-ascii?Q?TUPJk7N0Vlup0Xy1JiECYGfNH2o4uqx6DXbR6bKaSuXvpQRAWGuPBqTeCXRB?=
 =?us-ascii?Q?vS0PrGkU27FeO4sw4LuCd4+7zI9UUtETk69TJsBTwEUq03ZWvwiF0uRBUE1N?=
 =?us-ascii?Q?MUTH6xGKFkN2CzxrPJ/Bs5bGNUw+8QHmeARCX4wIgmRYK29ko2rTfNfrthDN?=
 =?us-ascii?Q?LbPNl3vsVHCCVr4hH11OQUOuzE0L0n8piDbuM8lWUW4d/lT3rbgF+O9rP6qr?=
 =?us-ascii?Q?BqX7KTPgI81XEgcTRxb9aEDPH2DoocHwLD6fLlE4GFeHLdWsvGh3rK4TS8hB?=
 =?us-ascii?Q?fF1mgbnxGGWsxYZY9qog9RTiI1472PAAT767ZPg+ZxKviuj+oVwvw9lEqduF?=
 =?us-ascii?Q?e0oE8X2b9/hRq+6+3XXHXDgD9Fol5DUKFKec07loh3qsuE7+DA8ZOc1kgc6O?=
 =?us-ascii?Q?CRXkQkywcd4iyAq2xbNXp4jwRh1W3VTtlySlgM0xdSeuWgFNwxWe5IhxdJ80?=
 =?us-ascii?Q?t9ptRRcXWyUhrMV7Oku9iFwR0O1M3/mktO9CCngMFwRgBI/06WlpHpZr89b7?=
 =?us-ascii?Q?luC+1nSbJbxRUY2czsRG5cm5HAdlTJpE83KyDYrziLmol6+a9IhnhJ/91Z0Q?=
 =?us-ascii?Q?6Pf53ie2T+gdnaU6r7xffLjiuMDdPO4G4zZK3BUDoOE8AAa+UvTXdfV7hqf2?=
 =?us-ascii?Q?QYmbWYGC2lqOOmIwFuFuc5HYZCH5NrOLeRuIkQotU+RAi5X+BL69zuuNsi3t?=
 =?us-ascii?Q?cSbuEI1hAkI8EOyPRnov/YnwrEWXByg4L/nZsHJtVRsLfCbXAKiKGKjpgtgj?=
 =?us-ascii?Q?TqesR8qowPDH+pRLgMQMLy/mfdRsD4lqofgZO5Ek?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bec6452-03c6-4cde-827c-08dc007bd510
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 10:18:23.5329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb23b077-6391-471e-8a55-ab9f219e59ad
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddoUH51+8d9+kmAp3eOjiU+tByQqSoGdXovKfqIOQ1alT1B5wpcjt2tZqShghEA6yG0JuC1lZau9I7crF6DWIxKR+en7eIxZkkyvnBBA44Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5029

Hi Johannes,

> However, contrary to what `git -c http.sslBackend=3Dlist ls-remote <url>`=
 says on Windows, `git -c http.sslBackend=3Dopenssl ls-remote <url>` should=
 work, too.

Thanks for the tip! Although I haven't made any further attempts to try and=
 force openssl, I was able to get client auth to work with Git for Windows =
by ensuring the client cert and root cert are present in the Windows certif=
icate store and then setting "http.sslCert" to "CurrentUser\\MY\\{certifica=
te thumbprint}}". This gets everything to fall into place and I suspect tha=
t it is the "correct" way, for better or worse, to make it work on Windows.

One thing that tripped me up was that my root CA was using ed25519 for sign=
atures, and my installation of Windows did not seem to like that one bit. S=
witching to ECDSA seemed to fix it. I suppose that's another rabbit hole I =
need to jump into, but it has nothing to do with Git :)

Regards,
-- Ragesh.
