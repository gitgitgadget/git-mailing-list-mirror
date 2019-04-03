Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C93E20248
	for <e@80x24.org>; Wed,  3 Apr 2019 06:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfDCGri (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 02:47:38 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:53415
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfDCGrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 02:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=matrixil.onmicrosoft.com; s=selector1-matrix-co-il;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6llKcSBN+Cds8L5gm4smGJDsarHfbaf00Tm5u9hmgUY=;
 b=lkm3IWzf74Vpm4AhXEWeuLUfxV4ClE4XYZqoUFl1Y2QwzQz/cqxJjaS5yR05tzDOSsJzsLn8XA9xZrsxYn9ZzFzlI7T5P7f4amjCyqnLLVrXWp0AMJjLIVpISefndd8Cyx+n9HrfjXYfN1MiAbh4IjUGwHp06fSt679akWaze04=
Received: from AM6PR08MB4199.eurprd08.prod.outlook.com (20.179.3.202) by
 AM6PR08MB4119.eurprd08.prod.outlook.com (20.179.3.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Wed, 3 Apr 2019 06:47:34 +0000
Received: from AM6PR08MB4199.eurprd08.prod.outlook.com
 ([fe80::ecff:bf65:983:9a4c]) by AM6PR08MB4199.eurprd08.prod.outlook.com
 ([fe80::ecff:bf65:983:9a4c%4]) with mapi id 15.20.1771.011; Wed, 3 Apr 2019
 06:47:34 +0000
From:   Amiel Elboim <amielel@matrix.co.il>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Fw: git describe issue
Thread-Topic: git describe issue
Thread-Index: AQHU6eQfRF4BjkBwkkaGQKDd1PgbEaYp/jU6
Date:   Wed, 3 Apr 2019 06:47:34 +0000
Message-ID: <AM6PR08MB4199B076CB886AE814AFF4528D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
References: <AM6PR08MB41993844F57794DDF4B33B8F8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB41993844F57794DDF4B33B8F8D570@AM6PR08MB4199.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amielel@matrix.co.il; 
x-originating-ip: [2.53.138.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0353ea9d-670c-4939-be40-08d6b8004080
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR08MB4119;
x-ms-traffictypediagnostic: AM6PR08MB4119:
x-microsoft-antispam-prvs: <AM6PR08MB41195F211BAD6AB619A30E4E8D570@AM6PR08MB4119.eurprd08.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(366004)(346002)(199004)(189003)(5660300002)(256004)(99286004)(74316002)(7736002)(7696005)(305945005)(26005)(102836004)(186003)(7116003)(14454004)(486006)(11346002)(446003)(93156006)(476003)(2351001)(76176011)(478600001)(6506007)(2501003)(6116002)(3846002)(74482002)(316002)(97736004)(66066001)(106356001)(33656002)(71190400001)(71200400001)(229853002)(9686003)(55016002)(2473003)(1730700003)(105586002)(81166006)(81156014)(8676002)(2906002)(6436002)(5640700003)(6916009)(68736007)(8936002)(52536014)(4744005)(25786009)(53936002)(2940100002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB4119;H:AM6PR08MB4199.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: matrix.co.il does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kslBEbFDiwZMYh0VWgUzr4uT/dk4bSlzt0UmV1sFgGjhr2OZmkgu8+h8maqNwOeMUH6uVJfQhHyaPDjEw4tRJL0wY9XLx6zDhVz4/9sYHo2tKSzxHZSX4Sx21/FJdEI7GFp2lkpbG4zQ3Fc7B3UPNG8mJIH3fMVYdRoeJkv031cf73iMuDIx0sie2WI0vFhaP6UJcWzkOI8B+63fEJon8ZjK8d8lCNupUPgT11pzmNxjsxHHUM7a5atuT7hbjdoFYgae+ioNODSfEPspx5RQc7mpgeZYaEDCmt5ON18+lw4yTInY6Ivrif4VTlhn8UHPpJQUtu3KehdeauMyxxS6OS50ea84Bn5ikLE843anI2i5OtLdbJ04agx56IJVBdUN71ITOBZzftcRPL4SLfmudNbZo27+asveAIsWhZG31qM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: matrix.co.il
X-MS-Exchange-CrossTenant-Network-Message-Id: 0353ea9d-670c-4939-be40-08d6b8004080
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 06:47:34.0293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b3747c3-cccd-4b17-8f18-bd610edc86e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4119
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Hi!

I've found strange behavior with 'git describe' command, look like for me a=
s bug.=A0

In the case I create 2 tags on same commit and I run 'git describe --tags' =
I expect to get the latest tag, but always I get the first tag I created on=
 the commit.

Unlike=A0git-describe documentations - "The command finds the most recent t=
ag that is reachable from a commit. "

Simple example -=A0=A0=A0



amiel@CLINIKALDEV10:~/Xpress$ git tag v1
amiel@CLINIKALDEV10:~/Xpress$ git tag v2
amiel@CLINIKALDEV10:~/Xpress$ git describe --tags
v1
amiel@CLINIKALDEV10:~/Xpress$ gl
* 4f54749 (HEAD -> master, tag: v2, tag: v1, origin/master, origin/HEAD) st=
art point with git



I'll happy to know if is bug or I don't understand something.


Thanks


Amiel=A0=A0

=A0=A0


     =
