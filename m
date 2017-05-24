Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05D1020209
	for <e@80x24.org>; Wed, 24 May 2017 21:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032690AbdEXVqb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 17:46:31 -0400
Received: from mail-sn1nam02lp0023.outbound.protection.outlook.com ([216.32.180.23]:9568
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030444AbdEXVq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 17:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=TexasTechUniversity.onmicrosoft.com; s=selector1-ttu-edu;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4YObMpg0ObpNOOlsVTqbc+0HV4Af4YxRFiYoSl2JQro=;
 b=HiDap1fUedkibZ1p5309A2E+Sif2ntMViO69RdC9M7lUHfrKLRne/xDZ8qELwyuFHdzoHX3fYuYV5avRoB+rzzdITX05ErpknSzTeuGpwD5qXeaMQIPQvpHtTcDeljT5Cp4uiLAPMe0CuaNe1yUQCik/0l4PELWn7s0ItBL0Ouc=
Received: from BN6PR06MB3475.namprd06.prod.outlook.com (10.175.130.148) by
 BN6PR06MB3473.namprd06.prod.outlook.com (10.175.125.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1124.9; Wed, 24 May 2017 21:46:24 +0000
Received: from BN6PR06MB3475.namprd06.prod.outlook.com ([10.175.130.148]) by
 BN6PR06MB3475.namprd06.prod.outlook.com ([10.175.130.148]) with mapi id
 15.01.1124.009; Wed, 24 May 2017 21:46:24 +0000
From:   "Thompson, Matt" <matt.thompson@ttu.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Sama/Winbind AD Computer Accounts Moved
Thread-Topic: Sama/Winbind AD Computer Accounts Moved
Thread-Index: AdLU1SncLToU2PnwT3m+221OhUGhDgAAfjJw
Date:   Wed, 24 May 2017 21:46:24 +0000
Message-ID: <BN6PR06MB3475A0F44B37A82175E86871EBFE0@BN6PR06MB3475.namprd06.prod.outlook.com>
References: <BN6PR06MB3475DCD7A2588E3EDBE07E48EBFE0@BN6PR06MB3475.namprd06.prod.outlook.com>
In-Reply-To: <BN6PR06MB3475DCD7A2588E3EDBE07E48EBFE0@BN6PR06MB3475.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ttu.edu;
x-originating-ip: [129.118.151.4]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3473;7:2b2UtXGSR4zTjlS+Ow1GaqXxOOdKgT5+CcXrJ0tG9VqgDAPPLutayr/1vumTcgmIAGqgry04KBp4fuW0GQjrBsJoTyhDDf1dOs+G0IKmc8cEnU2/PeM4CsZfvLIaRX+CsWs+2t4cV3RaBlP2FT0rpTAivB+7A8WlOijpww+m3z4HVdA91pKdzFRtvBObuNXvKlee7T9r4rlumABYgAI//AL6qho/r9NiG6VeBJHcyu4uefUo6zMsWHT7XZqadXBkAq9MquNgDyn16a0wWeYb0NQQ4Ydupz+UQ+Bi45/PBlC8kv+y4DuZJmPqbK//6P//M+Np11IzhjQqVajipGeU+A==
x-ms-traffictypediagnostic: BN6PR06MB3473:
x-ms-office365-filtering-correlation-id: 7d179f39-0ea1-40d5-84ba-08d4a2ee531f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(201703131423075)(201703031133081);SRVR:BN6PR06MB3473;
x-techmail-edge-route: EOP
x-microsoft-antispam-prvs: <BN6PR06MB3473155805C9717B28DAE334EBFE0@BN6PR06MB3473.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(6041248)(20161123560025)(201703131423075)(201702281529075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123555025)(20161123564025)(20161123562025)(6072148);SRVR:BN6PR06MB3473;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3473;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39850400002)(39410400002)(39400400002)(39840400002)(39450400003)(6116002)(102836003)(3846002)(2950100002)(6916009)(38730400002)(110136004)(189998001)(2501003)(88552002)(3660700001)(3280700002)(5660300001)(2351001)(478600001)(53936002)(77096006)(75432002)(33656002)(122556002)(81166006)(8676002)(15650500001)(8936002)(6506006)(74316002)(25786009)(2900100001)(6436002)(66066001)(305945005)(7736002)(54356999)(7696004)(5640700003)(50986999)(76176999)(2906002)(86362001)(1730700003)(9686003)(99286003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR06MB3473;H:BN6PR06MB3475.namprd06.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ttu.edu
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2017 21:46:24.5132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 178a51bf-8b20-49ff-b655-56245d5c173c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3473
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=20

We've encountered an issue not previously seen in our environment.=A0 We jo=
in our Linux machines (most are Oracle Enterprise Linux 6.x or 7.x) to an A=
ctive Directory domain.=A0 We do this by using Samba/Winbind. =A0When joini=
ng a Linux host, we create the computer account in AD ahead of joining the =
computer to the domain.=A0 This ensures the computer account is created in =
the sub-OU we need it in.=A0 Historically, this has worked without issue.=20

We recently noticed that this behavior has changed.=A0 Now, when we join a =
Linux host to the domain after creating its computer account, it is moved t=
o the default computers OU in the domain.=A0 This is not where we want it t=
o be located.=A0 This does not happen when Windows hosts are joined.=20

When we run 'net ads join' with debug output, the following line is seen:

"The machine account was moved into the specified OU."

A Google search indicated this is coming from Samba code.=20

The version of Samba we are using is 4.4.4-12.=A0 The samba-winbind version=
 is the same.=20

Was functionality to move the account to the default computers OU added or =
has it historically been in Samba?=A0 If it has, is anyone aware of what fu=
nctionality in AD could have changed to produce this behavior?=A0 I realize=
 this is a Samba support list but I'm curious to know if someone may be fam=
iliar enough to render a guess.=A0 I am not an AD administrator and am at a=
 loss.=20

Thank you,

Matt Thompson
Assistant Managing Director
TOSM Enterprise Systems
Texas Tech University System
(806) 834-3646

