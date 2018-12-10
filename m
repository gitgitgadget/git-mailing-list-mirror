Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2277720A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 13:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeLJNCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 08:02:05 -0500
Received: from mo-csw-fb1114.securemx.jp ([210.130.202.173]:52838 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbeLJNCF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 08:02:05 -0500
X-Greylist: delayed 2360 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Dec 2018 08:02:04 EST
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id wBACMjIE000950; Mon, 10 Dec 2018 21:22:45 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id wBACMhfk003067; Mon, 10 Dec 2018 21:22:43 +0900
X-Iguazu-Qid: 2wGrJ0StP5FiGkBWlM
X-Iguazu-QSIG: v=2; s=0; t=1544444562; q=2wGrJ0StP5FiGkBWlM; m=+s54OSHMEpzbJ3IM1rcue0WziKNIpxfOj5tE2BmGjdA=
Received: from gwmailsv2.oki.co.jp (okigate.oki.co.jp [202.226.91.194])
        by relay.securemx.jp (mx-mr1113) id wBACMgxi008525;
        Mon, 10 Dec 2018 21:22:42 +0900
Received: by gwmailsv2.oki.co.jp (Postfix, from userid 0)
        id 8E961E7019; Mon, 10 Dec 2018 21:22:19 +0900 (JST)
Received: from s24c63.dm1.oii.oki.co.jp (localhost.localdomain [127.0.0.1])
        by postfix.imss71 (Postfix) with ESMTP id 5E95216FA41
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:22:19 +0900 (JST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01lp2054.outbound.protection.outlook.com [104.47.125.54])
        by s24c63.dm1.oii.oki.co.jp (Postfix) with ESMTP id EFA359FDD01
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 21:22:18 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oki365.onmicrosoft.com; s=selector1-oki-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaqmkXyH5iyFS5o5oG/BzhfCTi3cndKmAiyGGdr+Qg8=;
 b=iyy4XcbUO7+UyFM9CR3RZH9u2y6/uoc1Kbe5jqvkVqIMMvIvd85P8oB98Kj/qqO2bqlA2po1k6C89giXvL9AZpKxrOupm1LhbVI0ywAdg7sBIP/RHVqm0UfJC8LmHcwbGSv93yhbHcLqWmZVcfJncf0OEwk2VHy7VkN3C6l08AQ=
Received: from TY2PR01MB2700.jpnprd01.prod.outlook.com (20.177.96.83) by
 TY2PR01MB5081.jpnprd01.prod.outlook.com (20.179.171.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Mon, 10 Dec 2018 12:22:17 +0000
Received: from TY2PR01MB2700.jpnprd01.prod.outlook.com
 ([fe80::6518:9914:43d3:c516]) by TY2PR01MB2700.jpnprd01.prod.outlook.com
 ([fe80::6518:9914:43d3:c516%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 12:22:17 +0000
From:   =?iso-2022-jp?B?GyRCSXAwZhsoQiAbJEI5bkxAGyhC?= <takei744@oki.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?iso-2022-jp?B?GyRCSXAwZhsoQiAbJEI5bkxAGyhC?= <takei744@oki.com>
Subject: Questions about ubifs,ubi and mtd?
Thread-Topic: Questions about ubifs,ubi and mtd?
Thread-Index: AdSQgt7XzXPTMw3JRJybNXlGyOJFFA==
Date:   Mon, 10 Dec 2018 12:22:17 +0000
Message-ID: <TY2PR01MB2700AD659601C0341B5C06929DA50@TY2PR01MB2700.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcaGMwNzc0OTVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zOGRlNzcyOS1mYzc2LTExZTgtYmNlYy1kNDZkNmRjNTc4YzVcYW1lLXRlc3RcMzhkZTc3MmEtZmM3Ni0xMWU4LWJjZWMtZDQ2ZDZkYzU3OGM1Ym9keS50eHQiIHN6PSIxMDMyIiB0PSIxMzE4ODkxODEzNTkzMDkzMTEiIGg9IkVJU1BxU0R5RGJCTUROVWE3ZVc3bi85aHI3dz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=takei744@oki.com; 
x-originating-ip: [202.226.91.114]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY2PR01MB5081;20:h+X4Q2BtIVZuNZJl6Q3+DH3kJXfuqbZ6edBQVDeCCO5M8neQ5lN6IX/fCeurdHQhflb5hrgTgxEJFrTS/FARgV3hpZ2wVbgtS240imLz9uACLRkRkuqy+clLnLGyeA0gI6iGzjL6aL2VYSi/3stwqXqL046QQmpzDR9WpJe0Rts=
x-ms-office365-filtering-correlation-id: 91c4dc4f-f34a-4b71-66d0-08d65e9a2003
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB5081;
x-ms-traffictypediagnostic: TY2PR01MB5081:
x-microsoft-antispam-prvs: <TY2PR01MB50817B962E4B1ACD86D926FE9DA50@TY2PR01MB5081.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TY2PR01MB5081;BCL:0;PCL:0;RULEID:;SRVR:TY2PR01MB5081;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(53754006)(2906002)(7696005)(256004)(14454004)(478600001)(99286004)(85182001)(486006)(2501003)(6506007)(102836004)(105586002)(26005)(25786009)(106356001)(2351001)(476003)(6916009)(8936002)(33656002)(7736002)(305945005)(81166006)(81156014)(74316002)(6436002)(1730700003)(4326008)(316002)(5640700003)(186003)(53936002)(8676002)(97736004)(55016002)(5660300001)(9686003)(66066001)(86362001)(6116002)(71200400001)(14444005)(71190400001)(3846002)(68736007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:TY2PR01MB5081;H:TY2PR01MB2700.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: oki.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ei1So0Gm98MY75FNIG5rT3TNgvQiy8yiER0bn9+nzfbwO2JCpJAcXBX2I3uewI5M5DDPPTt2eg2hdpGyJ5SGHq2lmueoV+aogdq0oDDwJLfa2qEsrhA9mdBHA5ocCejorocV+DFLiyOYqq0xWjfXaqRusZxEmSv7sLlFtL9eGF2yeuRh8dRERqMOhx2zDorOq8syt4ZENxMfEN5e/IGSsnURWz0cqwV9/YzSufBc4ne9p+zV9U+cmz3bpvyWCIBDjnjOxL3t83Sy6TXnjCafKPK/4inhURfQ2iGbZEiQGVuElDP1U6EVvtKAkruMF2nu
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oki.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c4dc4f-f34a-4b71-66d0-08d65e9a2003
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 12:22:17.3501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e23be703-cb62-4f3f-96f6-127abea71aef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB5081
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

We are developing the product using file system using ubi, ubifs on hardwar=
e with NAND flash memory.

Although the development of the product was completed, we are seeking your =
help as the customer who is using it is having trouble with it.

The product we have developed has 6 MTD partitions for NAND flash memory.
These consist of 6 MTDs named 'kernel-a' 'kernel-b', 'rootfs-a', 'rootfs-b'=
, 'data-1', 'data-2', and online program only accesses 'data-1' and 'data-2=
' for write access.
Nevertheless, when loading our program from 'rootfs-a', trying to read the =
inode with the ubifs_read_node() function will result in "bad node type" (e=
x: 193 but expected 9) and the LEB can not be read with the expected value.=
 (Even though you do not have write access to rootfs)

Is there anyone who encountered such a problem? Is there patch?

Please let me know, if you have any questions.

Best regards,
Katsuaki Takei/Oki Electric Industry Co., Ltd./JP
