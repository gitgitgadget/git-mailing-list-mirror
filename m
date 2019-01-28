Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE8E1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 13:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfA1Ngh (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 08:36:37 -0500
Received: from esa2.hc595-16.c3s2.iphmx.com ([216.71.156.178]:43653 "EHLO
        esa2.hc595-16.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbfA1Ngh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 08:36:37 -0500
X-Greylist: delayed 670 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2019 08:36:36 EST
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=alstomgroup.com; i=@alstomgroup.com; q=dns/txt;
  s=alstomgroup; t=1548682597; x=1580218597;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dhlqRROJz+r61rpIOw47qh3mYOTrye37Fx3Us03UKUU=;
  b=DnTugWOMG5fTv1B2wsnQis2zBGKfPEtAFstYxWPwmb1zsP/o5/pG1TQi
   de0o0xnkZhWcfP511EQlCgOB9v3Q5Oy17YIGdeGqjLydhgfbh/xb0IPhL
   GxGXoRl2jkmCEttFgygnpRBkQyRG9z1clSIB2WAm1QlHWeZ3SOMuMOVeX
   s=;
Received: from mail-db3eur04lp2052.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.52])
  by ob1.hc595-16.c3s2.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2019 14:25:14 +0100
Received: from HE1PR01MB3722.eurprd01.prod.exchangelabs.com (20.176.161.147)
 by HE1PR01MB3804.eurprd01.prod.exchangelabs.com (20.176.162.17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.18; Mon, 28 Jan
 2019 13:25:12 +0000
Received: from HE1PR01MB3722.eurprd01.prod.exchangelabs.com
 ([fe80::255a:24d2:7814:ba6f]) by HE1PR01MB3722.eurprd01.prod.exchangelabs.com
 ([fe80::255a:24d2:7814:ba6f%6]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 13:25:12 +0000
From:   COLLOMB Joris -EXT <joris.collomb-ext@alstomgroup.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git checkout multiple options issue
Thread-Topic: Git checkout multiple options issue
Thread-Index: AdS3DOSUeSahnLF1Sp2hV0Z9qGG2ag==
Date:   Mon, 28 Jan 2019 13:25:12 +0000
Message-ID: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=joris.collomb-ext@alstomgroup.com; 
x-originating-ip: [165.225.77.64]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR01MB3804;6:1+8nLNbd+KnUJIagdbtH/bZ9W2ikueZiprV3oU9/0oDu/qGd5wloVDrJl7EAMmISqH9bv7X/IFjnR8FZxsnLdMqwCP4Nk4UDgXQ4aYt9qClBB9fFsk+Mf6+Zs6mYmTUFqU6kBFr2gufQc85ikyx2j0ZHWEbSb3t22ezxTgQcCjR8kP+2aOU17SJz903y3ekhkoX6WLDj5IcoVutvKG3bcgh+m4SyFHMMPJ9DqhE1xVR8ZDoyKWcvDzBIAYuDkkTMA25fVlzGRVRK5Qq6VwXZ7c6SWCNSHwF4oX3gy3KJ02h8avhkYpB+2zDI128MA5u28v4c7gxaHEJpulkpJenJdsmupmxHPbvLpM2LZ1OtyYQRKp/zfZkdF3wMYIo4clxXpYbQTDpsB31UgcOjLnCOxyx7upzxySlxl7EV7ZUWmQnRe09e10hNfPEd09Gfg0cur7BRFkiIrhrrBZ6umY0mDw==;5:iM2OtShg/vy5sltBxPj6pIrPChoCF8EvkLtNamOaYv78HuPZxndethJYPor9PfDaYN8Xog8bEKcjAknqmmc1Qa16ZgY4T9Db43inrTYXqfN4NzwgOqMvaJkwvGBFzltEFb6v6dciu5dCL8natRaIIQaizQ1jAf+N9tHthAYAKAhMvq23yYgobqX2LhFHErvuuEpOU/bv65xzF6SSrvXuOQ==;7:Mr8f48Y5X/f/o58XxR/4QHSkjuZGUTmWcJPFioJXG5ZcemiQnB4AKVlYwO2re+0XKNkgz30iTGPSWdjN8W+YztheNkLtuHfFT7DEK/QT4G8NsYWqb412qmspcOv6UVORmGjuBGPPgmrhyKilOcDZCg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 3187f966-360b-403f-5816-08d68524088c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:HE1PR01MB3804;
x-ms-traffictypediagnostic: HE1PR01MB3804:
x-microsoft-antispam-prvs: <HE1PR01MB380488ECBCC9969B5DDAC279A9960@HE1PR01MB3804.eurprd01.prod.exchangelabs.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(39860400002)(376002)(189003)(199004)(40434004)(55016002)(476003)(68736007)(486006)(3846002)(6116002)(97736004)(5640700003)(5024004)(14444005)(25786009)(2501003)(2906002)(74316002)(6506007)(186003)(55236004)(7696005)(102836004)(71200400001)(26005)(71190400001)(6436002)(256004)(86362001)(2351001)(14454004)(106356001)(66066001)(8936002)(4744005)(478600001)(81156014)(33656002)(8676002)(1730700003)(81166006)(99286004)(9686003)(316002)(305945005)(7736002)(53936002)(6916009)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR01MB3804;H:HE1PR01MB3722.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dmp1KU8CfmZdAKRZl5AnQ63utWmRBLJWCGNhJrnCGFV8jPsTMZDsZJU+QoT8TouhY4Ja4W749Iy3d1IEcmraQbwK7woYxB0PwpYuw7qtXYIPFCWx5PyJZcUxG/HRMQ5kb8oFhuYfLogD/78FAFRmY6PVNwcz1r+Q+Fu8vdNDb2nJlRiFJdxfiDEu7pL3NkjY/XgOG13OA8purZffayyBlhBWYzFCN0bPcX14AZS+UdbbhcAT8/ZoaYodKd2ywL5wF/ok9YIyHX9r3gwIcQoTibGdqHL5j3PykeRzBQBF7+fPwB74Rt2f58SuUU58wjp+Xuxwk+nvMMoeou2oF2qPqHGCl+51VEj520l21PLyDFyVNy0OU2w/ivxrjE1t9HB2QPcdSlALVjB1ne2LtncyTy2eh18X5f8M6vkbV4jKLiM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: alstomgroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3187f966-360b-403f-5816-08d68524088c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 13:25:12.6254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d993ad3-fa73-421a-b129-1fe5590103f3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR01MB3804
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Something like this:

git checkout -fb "branch_name"
(force branch creation and checkout it)

doesn't work (even if option a separated).

I don't know if this is consider as an issue, but here it is.

Thanks for reading,
Joris


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.
