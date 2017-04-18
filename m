Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FABC1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 12:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbdDRMsM (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 08:48:12 -0400
Received: from mail-sn1nam02on0096.outbound.protection.outlook.com ([104.47.36.96]:64282
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752125AbdDRMsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 08:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icct.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NF6/JeoetYPXkAxanvKoBebH/3cddUpGMItUMNwl/6w=;
 b=5DxzTnkABfbXOu/wQj6rLnncPxGfecZKclx6D0PMEdw5XVzgVeIbZ1S11i/qXrM3euyEbpp37HsTgJKWnFXJScz9R8F24BIUfGrU934HbOpDpNbvE1IjDQgP6VDLUX/A8b5QUBadVsoKVg/nho60ZmNp22zXaqlvDM27wWyfwyo=
Received: from DM5PR04MB0619.namprd04.prod.outlook.com (10.172.187.9) by
 DM5PR04MB0618.namprd04.prod.outlook.com (10.172.187.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1034.10; Tue, 18 Apr 2017 12:48:09 +0000
Received: from DM5PR04MB0619.namprd04.prod.outlook.com ([10.172.187.9]) by
 DM5PR04MB0619.namprd04.prod.outlook.com ([10.172.187.9]) with mapi id
 15.01.1034.015; Tue, 18 Apr 2017 12:48:09 +0000
From:   "Bonk, Gregory" <gbonk@icct.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: FW: Issue in gitbash changing directory
Thread-Topic: Issue in gitbash changing directory
Thread-Index: AdK4QOcpeKwOr5T/RBKi7/W9CtJc4QAAEgrgAAAnsuA=
Date:   Tue, 18 Apr 2017 12:48:09 +0000
Message-ID: <DM5PR04MB061992BA437ACAD18A5F44DBC7190@DM5PR04MB0619.namprd04.prod.outlook.com>
References: <DM5PR04MB061907F6F650E56FE2ECBCD5C7190@DM5PR04MB0619.namprd04.prod.outlook.com>
 <DM5PR04MB06197EF8FA0344708A69C842C7190@DM5PR04MB0619.namprd04.prod.outlook.com>
In-Reply-To: <DM5PR04MB06197EF8FA0344708A69C842C7190@DM5PR04MB0619.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=icct.com;
x-originating-ip: [66.162.75.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB0618;7:8dfdGOhjJlXHOv4XB6UCVVxgw85GD9Wnvjh86mP4ygzdixSC4GsSt75yu8Cz/yxGRdUlYlo7BPW4bab9UNueF2qkM+vI2WeLe3SBbTDa0vtMAN3FWWfoEFoAf8zU7JrC0NGA28lJxkyTVDn3s4MV/Ua0IfWalALVT6ZaCT5WW6wy3GTEJDEG/5RmRDqpwPMnK1Kv8tP+i0ddaZiXTmWrt9loxGc+g2tFu6el0NXwPI4QBVGiZtQaAYk4rStQVjvDgmGGet0rNrqdQ8HxLW0V2KBrR9jI3LeEZBnlO8tDIBLGrbbvhVQDVmrEQ1A6XEaYqmVxFDQFxSx9kDRzfuwgWA==;20:4VJ9EHpgbDqa2+GGUyksQRXQZAQ7IlR7d2zFvpy1+elYp0QkBbvKyi5hFArff8kXt5VhebcHknP0ftiZte4OwliPH6t1jmBfW3qFvjLsso9FpazpRZ/Dj8L9ZuK8s0Vx38Qcsr6AWO+zQT49iQIlZepzRiSrJrbjD5OhEjYGMR0=
x-ms-office365-filtering-correlation-id: 7312e0af-4afd-4a40-4350-08d486592ae7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(201703131423075)(201703031133081);SRVR:DM5PR04MB0618;
x-microsoft-antispam-prvs: <DM5PR04MB061862D6FD27E4A958FC51DCC7190@DM5PR04MB0618.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(6041248)(20161123560025)(20161123555025)(20161123564025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(6072148);SRVR:DM5PR04MB0618;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB0618;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39840400002)(39410400002)(39400400002)(39450400003)(189998001)(1730700003)(81166006)(8936002)(229853002)(122556002)(3280700002)(3660700001)(2906002)(2900100001)(86362001)(33656002)(50986999)(2351001)(76176999)(54356999)(102836003)(6116002)(38730400002)(2501003)(2950100002)(305945005)(53936002)(7696004)(9686003)(5660300001)(3846002)(558084003)(110136004)(6916009)(74316002)(8676002)(7736002)(66066001)(5640700003)(6506006)(77096006)(99286003)(6436002)(25786009)(2473003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB0618;H:DM5PR04MB0619.namprd04.prod.outlook.com;FPR:;SPF:None;MLV:sfv;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: icct.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2017 12:48:09.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1f24096-28ce-464a-90b1-23ece9b5535b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0618
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I accidently typed 'cd //'=A0 and it worked.

gbonk@ICC11167 MINGW64 /c/git/mtb-messagehub-information-radiator (master)
$ cd //

gbonk@ICC11167 MINGW64 //
$ cd ..


