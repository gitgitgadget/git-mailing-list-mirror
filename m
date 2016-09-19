Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AF9E2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751146AbcISPbr convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Sep 2016 11:31:47 -0400
Received: from mail-bn1bon0087.outbound.protection.outlook.com ([157.56.111.87]:36032
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751076AbcISPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 11:31:46 -0400
X-Greylist: delayed 3580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Sep 2016 11:31:46 EDT
Received: from YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM (10.165.130.13) by
 YQXPR01MB0024.CANPRD01.PROD.OUTLOOK.COM (10.165.130.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.629.8; Mon, 19 Sep 2016 13:58:00 +0000
Received: from YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM ([10.165.130.13]) by
 YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM ([10.165.130.13]) with mapi id
 15.01.0629.006; Mon, 19 Sep 2016 13:58:00 +0000
From:   Paul Williamson <paul.williamson@mediamiser.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Switching branches not working in a cloned repo
Thread-Topic: Switching branches not working in a cloned repo
Thread-Index: AdISfZQ3kSlGE8JHQfuYXxD9ERxQOg==
Date:   Mon, 19 Sep 2016 13:58:00 +0000
Message-ID: <YQXPR01MB0023CDCFA27BDD4959B4F9B19EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul.williamson@mediamiser.com; 
x-originating-ip: [72.143.112.138]
x-ms-office365-filtering-correlation-id: f4903b78-e73d-42fe-6a77-08d3e094f788
x-microsoft-exchange-diagnostics: 1;YQXPR01MB0024;6:mZE4Ekfax7e+iBgqt0YO00VxuoGe1SjPBoiH3nc/eK1nqbH5pcr/jsVxdMqL0yxMTuqGUvtAFtC9UeXtVRlrCD5wPikNpOjVNJ4KDxVk3Fxp8Aqd0EXAL06Z1p0Dw5bTkLuD5ELcdIN/7HMAYqCqgWrNXaib4yE09usmSPA6MPwTiDyJzgQO+mSkt6sWAq4/ZwOilRkDXAWJ2VMcRDgIsLI84XLiIZwVxmwsyT+xr4TW44wMbkFhKgTzANClsj7TkVl9r1HKUzTYSPL2P1aM8jGywwwgLLtqs5lw3KNyMUbVmm5FLmnDuAp/qbuc85Kd;5:OM22aqyOfqsQ6JvLvutpLg8OJZD5KQjl70f5SyHXu0qcAyWaUSnrTsik6Bn0UxJuIDt/QnIVeAywEVvR9QUS+93CL9oJlsIbLmBQOEssKhEJFJRdicPbwNDH5izS02Aewsng5h8U8QJ6yOK3YLKs/w==;24:/VVo6ysN2zYAaVOZqUKEptFfFqLCXkWNYht2pnMDJOSln1koHCHfxud6ocwRkPYZxhdb25K9h957zQgEVAvf7yV8LxLfWrU8x04KI69nLFY=;7:YmZEywhBkrc94zPsC66CO6b0fK7UZVA+8JE45FL8EHJxM3MZsS2KVEzJUUsNIUqMvImdyJE3+75aGMiHXpoEEaOx82TTnIo9PIfZaI+JePFLUsqYGdYTGS31HQFlfHJh5ML7c8ykSMOx1kErKbvNnqnNLljhc+xVwLZ2xzZYnmKA/eyszNj5y9JZEgj/0TumTE7X17+kWhhf62EOBSoBjMyjGQcFAd9jgwqWMk3Q2sHp5RX4FwxZWAh0t1V6IWX2rQwifWqwfDjo2y+b6PKglfXsea2FqOQOEV45ANRTCBQWV3bY2JmuZtmVQ0yylNzC
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:YQXPR01MB0024;
x-microsoft-antispam-prvs: <YQXPR01MB0024C19CD5831073E2DDAC9E9EF40@YQXPR01MB0024.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6042046)(6043046);SRVR:YQXPR01MB0024;BCL:0;PCL:0;RULEID:;SRVR:YQXPR01MB0024;
x-forefront-prvs: 0070A8666B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(189002)(199003)(2351001)(92566002)(229853001)(66066001)(33656002)(189998001)(107886002)(87936001)(3660700001)(10400500002)(122556002)(11100500001)(68736007)(9686002)(2501003)(3280700002)(1730700003)(50986999)(106356001)(6116002)(5660300001)(102836003)(54356999)(3846002)(2906002)(586003)(105586002)(8936002)(7736002)(110136003)(450100001)(305945005)(101416001)(7846002)(81166006)(77096005)(7696004)(74316002)(5002640100001)(2900100001)(86362001)(97736004)(81156014)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:YQXPR01MB0024;H:YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: mediamiser.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mediamiser.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2016 13:58:00.1355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9009f71a-c1b6-4b55-a665-0aeb582e95d3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB0024
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We use git extensively on a number of repos. Recently, we have had a problem with one of them. This repo has a 'web_dev' branch. For copies of the repo cloned before a certain (recent but unidentified) time, we could 'git checkout' between master and web_dev and everything would be normal.

However, now if we clone the repo, we can no longer do 'git checkout web_dev'. Git doesn't complain, in fact there is no feedback and we are still in the master branch. Running 'git branch -r' still shows the branch as existing at origin.

If we try 'git branch web_dev' we then see web_dev listed locally and can switch to it BUT on closer inspection we realise that this action has created a new branch off master.

The first time we saw this was under Bash on Windows, so we thought maybe it was a beta problem, but a) other repos work as expected under that environment, and b) under cygwin, pulling the same repo to a new directory alongside an older copy shows that the problem occurs with the new clone, but not the one that that was cloned longer ago.

Also in this situation, there are no local outstanding code changes that might cause problems switching branches. This occurs right from a cleanly cloned repo.

It seems something has gone wrong with this repo, and we don't know what. It's a tough problem to google, and I was not able to search the gmane archives (DNS errors).

Any idea how to investigate?

Thanks,
Paul


