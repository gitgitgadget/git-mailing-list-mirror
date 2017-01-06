Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CA821FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 17:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbdAFRZp (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 12:25:45 -0500
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com ([104.47.37.88]:9664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750896AbdAFRZn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 12:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netorgft759928.onmicrosoft.com; s=selector1-onahill-co;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SDf+CvZU3nB5Ym50tNg1tAhMqNJ3jPmThQTdDgOkxjM=;
 b=P3twNUY2Lti7G+E1bsEJphzybA8pBUBVVlGtfDiu1Jz91RyIrwH8hqrP12ilxkFlDrMLvoyj1n3hdbn2/NKG9yimkYGT9B0aWIYZJhsw0zW+RrI5umbqWXi4rbPa8vW+btohVRRu6sHVSuRyJYRpwOra9PxOVRzwq6NmqIL7qAc=
Received: from MWHPR19MB1135.namprd19.prod.outlook.com (10.173.124.23) by
 MWHPR19MB1136.namprd19.prod.outlook.com (10.173.124.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.829.7; Fri, 6 Jan 2017 17:25:40 +0000
Received: from MWHPR19MB1135.namprd19.prod.outlook.com ([10.173.124.23]) by
 MWHPR19MB1135.namprd19.prod.outlook.com ([10.173.124.23]) with mapi id
 15.01.0829.007; Fri, 6 Jan 2017 17:25:40 +0000
From:   Jake Lambert <jake@onahill.co>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git branch --editdescription fatal error
Thread-Topic: git branch --editdescription fatal error
Thread-Index: AQHSaEEPGvNcnWvWdkWenWzlAb0mzA==
Date:   Fri, 6 Jan 2017 17:25:39 +0000
Message-ID: <MWHPR19MB11357994E6C43DBCC0931CD7BC630@MWHPR19MB1135.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jake@onahill.co; 
x-originating-ip: [25.164.163.132]
x-ms-office365-filtering-correlation-id: 1ce64861-e5b0-4441-ee84-08d436590987
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:MWHPR19MB1136;
x-microsoft-exchange-diagnostics: 1;MWHPR19MB1136;7:oOJKGLD7IQrwQ9GuXqA2Yud61VMR8AEZ8GcWldY7lRfLVlmLvupKLbeDnRFueL3tWhFgPCUaxqWQy6tJ9mZXTEQowwWmzlzNm+XH5yjrX8jrvDYszmu3Ssx1gw5/doiL8S7iuJqRqYt1IELs+PLE9NXrSRQgJ17vXs0uaPnHBniSVJJUdhw/iu6uaCTR78PrVBMD289NAOAxwcWYS/fDFpNM2INXxJRGlp4BGdEEpbSu4Lgt5hxcBja89Up1c6djFK4KaPOjmx4rWUdumFpnEJUavFyGWkEZlV1xlaaH8qaYaTJHZ9tFKypT45EA7sVjxBL9zt7yXoAcLktjkabBM1LSFpaRq9TjJdj9pPO/aYu88oVLiINRDGc6iQY12TIddYj/gvIOCSFBTbf95azDhicvmnT0lREEjXi6O86dnhMmz3MAUwL9v6TgnjgkF0Oh/AFZxDd4M7JHzbNOZshsmA==
x-microsoft-antispam-prvs: <MWHPR19MB1136D0CAF42CF2EBA2E33C0EBC630@MWHPR19MB1136.namprd19.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040375)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6041248)(20161123562025)(20161123555025)(20161123564025)(20161123560025)(2016111802025)(6072148)(6043046);SRVR:MWHPR19MB1136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR19MB1136;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(39450400003)(199003)(189002)(189998001)(107886002)(66066001)(7696004)(6916009)(110136003)(3280700002)(97736004)(9686003)(122556002)(33656002)(305945005)(38730400001)(77096006)(74316002)(25786008)(2900100001)(92566002)(6506006)(5640700003)(7736002)(450100001)(6436002)(50986999)(54356999)(105586002)(106116001)(106356001)(15974865002)(74482002)(101416001)(2351001)(345774005)(81156014)(1730700003)(81166006)(8936002)(2906002)(2501003)(55016002)(8676002)(99286003)(3660700001)(3846002)(102836003)(6116002)(86362001)(68736007)(5660300001)(18886075002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR19MB1136;H:MWHPR19MB1135.namprd19.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: onahill.co does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: onahill.co
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2017 17:25:39.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78ba671c-66a6-472f-a5ba-245b626a33e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1136
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

When executing "git branch <branch> --edit-description" on a branch with no=
 description set, I get "fatal: could not unset 'branch.<branch>.descriptio=
n". It would seem that the unsetting piece should occur only after checking=
 if it was set in the first place. I am not too familiar with the inner wor=
kings of git, but if you accept pull requests, I'm happy to give it a shot =
if you can give me directions as to how to submit one to you.

While I have you, I would also like to make a feature request for branch de=
scriptions to (optionally) be included in the output of git branch <noargs>=
 (or something like git branch --descriptions). This is particularly helpfu=
l where branch names match JIRA tickets numbers or are simply so old I don'=
t remember what they are but don't want to delete them just in case.

Thank you for maintaining this absolutely wonderful program, and have a hap=
py New Year!

Best,
Jake
    =20
 Jake Lambert
 Full Stack Developer
=20
=20
 The Company On A Hill
 www.onahill.co
    =
