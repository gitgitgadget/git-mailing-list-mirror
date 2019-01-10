Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F661F803
	for <e@80x24.org>; Thu, 10 Jan 2019 07:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfAJHfG (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 02:35:06 -0500
Received: from mail-eopbgr1320079.outbound.protection.outlook.com ([40.107.132.79]:56384
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726923AbfAJHfG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 02:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onedevio.onmicrosoft.com; s=selector1-onedev-io;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBjOkpWYOTCooV/+koenjTQZZgpNac3CCU03p9KlEvE=;
 b=2xxpMdtFn0lQUijd0XfWZDdxr1SQoDvw0QhJ/lckKXLBiScS+HKSH//ok3dQxHsqEkyTpFVC7cfpIvkaHMPQCyBnmNeMLpHMgXpQuu2QOW7CmAgZf0ake/BFk1LJ/Jbv51U5ru7xN/ZoBlP24uJ0bib5u37MprUnnjVBK6lzGao=
Received: from SG2PR04MB3205.apcprd04.prod.outlook.com (20.177.91.205) by
 SG2PR04MB3481.apcprd04.prod.outlook.com (20.177.15.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 07:34:16 +0000
Received: from SG2PR04MB3205.apcprd04.prod.outlook.com
 ([fe80::e1d4:be7d:f237:7389]) by SG2PR04MB3205.apcprd04.prod.outlook.com
 ([fe80::e1d4:be7d:f237:7389%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 07:34:16 +0000
From:   Robin Shen <robin@onedev.io>
To:     Robin Shen <robin@onedev.io>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jgit-dev@eclipse.org" <jgit-dev@eclipse.org>
Subject: Re: Introducing OneDev - an open source git server with interesting
 features
Thread-Topic: Introducing OneDev - an open source git server with interesting
 features
Thread-Index: AQHUpn4BzlRRgp+PvUiq+jnBHPmaiKWkYxeAgAOpI1OAABQO2g==
Date:   Thu, 10 Jan 2019 07:34:16 +0000
Message-ID: <SG2PR04MB320504B60122C1B6DB632734B9840@SG2PR04MB3205.apcprd04.prod.outlook.com>
References: <SG2PR04MB3205E9C83085CFF2F426FE65B9890@SG2PR04MB3205.apcprd04.prod.outlook.com>,<20190107222631.GB192553@google.com>,<SG2PR04MB320586447FF738E008C373FFB9840@SG2PR04MB3205.apcprd04.prod.outlook.com>
In-Reply-To: <SG2PR04MB320586447FF738E008C373FFB9840@SG2PR04MB3205.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robin@onedev.io; 
x-originating-ip: [52.76.41.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2PR04MB3481;6:OT4K1zdTo0j9a5H4aC7D1b4Q+HW7jjL+/RtY0wL3gccznvcWpk8Q5I8mDpb+uw535R2u1rFMJDcYbmrZbqDtr5wri8Yy5ST2+E8bM3CVFKUYBAwqujl9IkyEep91KpjAEVVNN9yijzrfgQPNtll9jx1AB2i18VPVLwi+XGhvspiE5P7v/tV+Z6viMrZ7jKZXftrrsbgLhQe6GMAIG3M/jywC7Temq9m4N8BG37sXkyV2TyoBzFJt/BvOKN7OAjjs5bcOpMGBORy1zMnXdA9IAv7U0AzKVv7SPeigaYsOsRWGBNZp/JbW+0Jswp5pEylMXCOD5lDH/ikd+XuaCg0brD0OP5Qi7RMJqb7f90Q1x5Qz2wMfEdrV7ALGTWxfLysvJDfip2awCzvjebroGYMX4KN5H0ENiTzyqqCdueQRa24MhsozT3OUtItnbU5bE3ZVny/YIwuPKPpY6BGMDI77eQ==;5:ER4823Snj22CLWbItMzxw0FU+lABgjWGGBeWYwwIExvUHxnq1/8Y0oRc2/oNQ5fGJLgoWs0wGghmFxiNOdXQdiOcC1YG/7HB4hhCLxmvJKkd26elAWvEybkCNzIhjmgSqSGBNVLEDCw8qQCJNZZF+S24bA54gJ/1WKneyXK8xHVA2U+nnZxhJCOBo2jeH0LNuruXZYOwL6OxEZrykDBw9w==;7:8o9S5bi9kPzkQa7QMODAWNc6/+bgI7TDIZ04E8I8YYa/tyqqxgAug8oeXXODkJipiWcTJ1JUsQeMaXD5hGHSBpnnkMysGFWnI04L90Sn2PR8klfg3OgQkC2/EFPPQ2f1ubgy/5hdt75RuWgWYt1Y/Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(396003)(39830400003)(376002)(346002)(136003)(199004)(189003)(51914003)(6862004)(54906003)(6306002)(6506007)(966005)(26005)(53546011)(102836004)(11346002)(186003)(14454004)(476003)(86362001)(446003)(9686003)(7696005)(66066001)(508600001)(256004)(6246003)(76176011)(53936002)(99286004)(14444005)(74482002)(229853002)(3846002)(4326008)(305945005)(6436002)(6200100001)(6116002)(2906002)(25786009)(81166006)(81156014)(8936002)(33656002)(71200400001)(93156006)(74316002)(68736007)(7736002)(486006)(105586002)(71190400001)(2940100002)(316002)(5660300001)(106356001)(55016002)(97736004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR04MB3481;H:SG2PR04MB3205.apcprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: d7001c5a-f746-4a89-e291-08d676ce0665
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:SG2PR04MB3481;
x-ms-traffictypediagnostic: SG2PR04MB3481:
x-microsoft-antispam-prvs: <SG2PR04MB348132660837B0A2DF9357AAB9840@SG2PR04MB3481.apcprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:SG2PR04MB3481;BCL:0;PCL:0;RULEID:;SRVR:SG2PR04MB3481;
x-forefront-prvs: 0913EA1D60
received-spf: None (protection.outlook.com: onedev.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4qglAK2DTpdy+FYwBeZbgU6rYg2UjkYV+tUWzRCIQNqSCrQmLohKhSXrCJUvXehzHjl9Sw8slizwjDCtYMkiGTksez0oXVGf9VdW2sEFXev15j5S20+hFYJ9GHXrWtyrpIx7CHsmMJlmQUMigFONhiD9xm3SdnOavHhpi6Q3WsU5VG9Y3pjbDYprp7BpQTlM68BaiDfV86UiB/18m9hSKbQh+qbNxu1Ve418haV89tnGNE2W+LcG+4B7HjuMWdRDvT7xvgPEka5v+u9dLnd9sABFagHso64l54lK/4N5kXuzBpJOLZLUiCIuRV17gd6b
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: onedev.io
X-MS-Exchange-CrossTenant-Network-Message-Id: d7001c5a-f746-4a89-e291-08d676ce0665
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 07:34:16.0622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d3c83b7-53a7-44a7-952f-341c4e10ca6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3481
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add cc to git@vger.kernel.org and jgit-dev@eclipse.org

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

From: Robin Shen
Sent: Thursday, January 10, 2019 2:37 PM
To: Jonathan Nieder
Cc: git@vger.kernel.org; jgit-dev@eclipse.org
Subject: Re: Introducing OneDev - an open source git server with interestin=
g features
=A0=20

Hi Jonathan,=A0

Yes it is using JGit for most operations. JGit API is very well designed an=
d is a joy to use. The performance is very good, except for long operations=
 such as full clone. So for pull/push=A0I am calling native git, but  for o=
ther=A0operations which may need to be executed=A0several times during a re=
quest I am using JGit which=A0is much faster thanks for the in-process cach=
e.=A0

I also filed several suggestions/bugs while using JGit:=A0
https://bugs.eclipse.org/bugs/buglist.cgi?email1=3Drobin%40pmease.com&email=
reporter1=3D1&emailtype1=3Dsubstring&product=3DJGit&query_format=3Dadvanced

I'd like to help fixing, but right now does not have time to dig into JGit =
internals...

As to compared to other=A0software listed here, I am only used GitHub inten=
sively, so can not provide any valuable information.=A0

Regards
Robin
 =20
From: Jonathan Nieder <jrnieder@gmail.com>
Sent: Tuesday, January 8, 2019 6:26:31 AM
To: Robin Shen
Cc: git@vger.kernel.org; jgit-dev@eclipse.org
Subject: Re: Introducing OneDev - an open source git server with interestin=
g features
=A0=20

+jgit-dev
Hi Robin,

Robin Shen wrote:

> Dear git users,
>
> OneDev is an open source git server with interesting features such
> as language aware code search/navigation, issue workflow
> customization, free source/diff comment and discussion, etc.
>
> It is using MIT license and hope it can be useful to someone.=A0 Learn
> more at https://onedev.io

Thanks for writing!=A0 Looking at
https://github.com/theonedev/onedev/blob/master/core/pom.xml, it
appears this is a web interface that uses JGit for Git support.

Can you say a little about how it compares to Gitblit
<http://gitblit.com>, Phabricator, Gerrit, and other interfaces?

Also, if you have time for it, mind saying a little about what your
experience using JGit has been like?=A0 Any thoughts about what worked
well and what didn't work as well?=A0 This can help both the Git and
JGit projects:

- Git, since it can help us learn from JGit's successes and mistakes
- JGit, since it's not too late to make the API better :)

Sincerely,
Jonathan
     =
