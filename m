Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600B020248
	for <e@80x24.org>; Mon,  1 Apr 2019 19:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDATyH (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 15:54:07 -0400
Received: from mail-eopbgr820117.outbound.protection.outlook.com ([40.107.82.117]:60934
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDATyH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 15:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9jdwKXJWUd8dFn6eskBvXB2jL/jD1+GZEeGpMfC7q0=;
 b=IJOrVoUvGM9VGdndQrnIqn1zxstN2DpB8R7NgVtkFZooORX0Cy4IEi11zFX14ZAMYpmQD/WJwxLIWcH8VYPPt/IVCqer4HyMueeI8+O9x1gGNWQDiomzQ+5qZLv0i3N6w08QOOKaBcUFMoM/XuWaX52eWHVD3HtSwWA1Jew0JmM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5660.namprd08.prod.outlook.com (20.178.27.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Mon, 1 Apr 2019 19:54:02 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::1ca7:6cc5:a0b3:e164%3]) with mapi id 15.20.1750.021; Mon, 1 Apr 2019
 19:54:02 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "Mazo, Andrey" <amazo@checkvideo.com>
CC:     "ahippo@yandex.com" <ahippo@yandex.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>
Subject: Re: [PATCH v3 0/8] git-p4: a few assorted fixes for branches,
 excludes
Thread-Topic: [PATCH v3 0/8] git-p4: a few assorted fixes for branches,
 excludes
Thread-Index: AQHU6LUGbW6r8ueQ60+NtD8GF2ohI6Ynt8wA
Date:   Mon, 1 Apr 2019 19:54:02 +0000
Message-ID: <20190401195342.17515-1-amazo@checkvideo.com>
References: <cover.1554141338.git.amazo@checkvideo.com>
In-Reply-To: <cover.1554141338.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR08CA0058.namprd08.prod.outlook.com
 (2603:10b6:404:b9::20) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 730076b3-6573-477e-c382-08d6b6dbc965
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR08MB5660;
x-ms-traffictypediagnostic: DM6PR08MB5660:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR08MB566020435250A2F7410441A1DA550@DM6PR08MB5660.namprd08.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(376002)(39860400002)(396003)(189003)(199004)(6306002)(229853002)(102836004)(14444005)(1076003)(52116002)(6862004)(6200100001)(6246003)(54906003)(25786009)(8676002)(99286004)(478600001)(97736004)(6512007)(68736007)(8936002)(2906002)(6116002)(3846002)(316002)(7736002)(105586002)(446003)(53936002)(71200400001)(305945005)(7049001)(6436002)(37006003)(71190400001)(81156014)(81166006)(2616005)(256004)(476003)(11346002)(36756003)(386003)(50226002)(486006)(6486002)(76176011)(186003)(66066001)(86362001)(4326008)(966005)(5660300002)(6506007)(106356001)(14454004)(7416002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5660;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WbGRuzYe9Jam9fF7TpmIAYSvBiQKz8b9MhTCDMYgAaoJAmdUtBvMjlEwRYkJbluDanDjowJdRT5gi9wWACzPOtCrmwi2u0yxt2Iy1KxxuxqVus52n/cEvcmTFayzheKhJEP2naNQY5fXwIfOmRskSYgVL0DRCBiqG8GDBnTwEV9ICWu03xR/Hl5bjhWaLEQFbX0Q1JFTks0DAbCY3aascz+Hf/MPdUwXrGfr82c8sFCXB33CCjsgP+Gqr/OUkb8bZRusFBMJTbvvL/xRTdW961akqmADskM76MeyWi7DZx3Y4Y4a8kVtCD0O5BplsEQYFdW5wRwZg+5wFzW3hiQd+zQFh719DBysaEAJMPPjCK581XKYwXGe67Ps0ij1UNKMTOii8jvJK66b4dcCHyyHGPtFgcDqjSC1Hk8st4LcgBk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730076b3-6573-477e-c382-08d6b6dbc965
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 19:54:02.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5660
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This series fixes a few cases with branch detection
> and handling of excludes by git-p4.
>=20
> This is the third iteration of the patch series.
> Changes since v2 [2]:
>  * Added new test cases for case-insensitive branch detection.

Forgot to add:
 * Added a fix for case-insensitive branch detection when running with useC=
lientSpec enabled.
   (range diff below correctly shows the e644a8ab49 vs 6eaad2582c differenc=
e)

> Changes since v1 [1]:
>  * Added new test case for excluded paths when detecting branches;
>  * Added a new fix for excluded paths when detecting branches.
>=20
> [1] https://public-inbox.org/git/cover.1551485349.git.amazo@checkvideo.co=
m
> [2] https://public-inbox.org/git/cover.1553207234.git.amazo@checkvideo.co=
m/
>=20
> Range-diff vs v2:
> 1:  3ac39171d4 =3D 1:  bd009a5ca5 git-p4: detect/prevent infinite loop in=
 gitCommitByP4Change()
> 2:  e644a8ab49 < -:  ---------- git-p4: match branches case insensitively=
 if configured
> -:  ---------- > 2:  68b68ce1e4 git-p4: add failing test for "git-p4: mat=
ch branches case insensitively if configured"
> -:  ---------- > 3:  6eaad2582c git-p4: match branches case insensitively=
 if configured
> 3:  44fed954dc =3D 4:  1bd5e170e0 git-p4: don't groom exclude path list o=
n every commit
> 4:  a0d3fa6add =3D 5:  b657967154 git-p4: add failing test for "don't exc=
lude other files with same prefix"
> 5:  3330f88a0d =3D 6:  035abfff2a git-p4: don't exclude other files with =
same prefix
> 6:  6170d45951 =3D 7:  2bde24b7e4 git-p4: add failing test for "git-p4: r=
espect excluded paths when detecting branches"
> 7:  758d8e8486 =3D 8:  6d3ffb98a7 git-p4: respect excluded paths when det=
ecting branches

--
Andrey
