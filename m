Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAE6F2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932564AbcISSQZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Sep 2016 14:16:25 -0400
Received: from mail-by2on0079.outbound.protection.outlook.com ([207.46.100.79]:3736
        "EHLO na01-by2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932536AbcISSQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:16:25 -0400
X-Greylist: delayed 882 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Sep 2016 14:16:24 EDT
Received: from YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM (10.165.130.13) by
 YQXPR01MB0021.CANPRD01.PROD.OUTLOOK.COM (10.165.130.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.629.8; Mon, 19 Sep 2016 18:01:39 +0000
Received: from YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM ([10.165.130.13]) by
 YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM ([10.165.130.13]) with mapi id
 15.01.0629.006; Mon, 19 Sep 2016 18:01:39 +0000
From:   Paul Williamson <paul.williamson@mediamiser.com>
To:     Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Switching branches not working in a cloned repo
Thread-Topic: Switching branches not working in a cloned repo
Thread-Index: AdISfZQ3kSlGE8JHQfuYXxD9ERxQOgAE6ZZFAANrQ2A=
Date:   Mon, 19 Sep 2016 18:01:39 +0000
Message-ID: <YQXPR01MB0023C5D73A5C4634D1D76E259EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
References: <YQXPR01MB0023CDCFA27BDD4959B4F9B19EF40@YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM>
 <3999677D12354A3CB2035E932353981A@PhilipOakley>
In-Reply-To: <3999677D12354A3CB2035E932353981A@PhilipOakley>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul.williamson@mediamiser.com; 
x-originating-ip: [72.143.112.138]
x-ms-office365-filtering-correlation-id: d57d3d53-8137-46b1-4564-08d3e0b70168
x-microsoft-exchange-diagnostics: 1;YQXPR01MB0021;6:JM9LfM5UyVgJ0YaKOIjdXGAtaSCW1RFvui8jhAwFhXPbH72u5F3Sg9r41VkRGTKudR/gqAyR9kw5gqSULx8c9VzSsCw8AbAh4/UNW1OCjFT+o7nHpwyTjyLtbCOiyeIHjFW+y+rHLG3z9YFYPZyM+QXkCgFCGxgdlgfX8n5kLd1r57DknFDz6GXXR3SKNtYpGZgzfjT38AuohcQKEGz+7nmFFQPd4/VDCi4WO5nWopcZGE9B4l2vpiH+VG+pvTh0fZ2LydSi6qiqjJEcqFo56h7ALtgjyff+iheYgzyEnCkYDcAfHe+H/IAgiM1EZwiD;5:lyLpOQLJ5I4lNHFxCD/eI7/o5GcuK+pHvTB3NZ4oyOEDh8JbKMieYmKY3/tIF6XD7JxLymA1dFVi72bo4iiLRkKL+EqTvEhy/ndR2u/NEnZwn4FVynuZyOXnfi68F4+xZVs5dO0eYPoxhex/nJmMjw==;24:lcjd8V7Gr2OyhWFCcNy2OhTUPzLE68Q48AqlNc086z8QlENVaGzIXgnx0N0VHVgpwL1lLRpi7ARgBrOVQrk9ibO7ZzsDiyuY2W3OMLNvPrM=;7:yBor5Sx2tefEL2cPha2O9vqH12qKoYD0oVrfnpyl02F0RjbLBkKS3yiKS1v8hHJLHF79oMockHCklJdPl6nC1/tsNGyTfaYnEGLU6pIDH3lr8aFXzKqW47g3NVh8knvjW86CAbk1I4QeAlUU3W5+07OmCDVNrpFxPE6HS7W9BDibrTuQu9EV4ccNLU7QfSUfkyKiS1G5LaaZSAzLY7eTUr9xlaVKM1117kitno9+G2bANUQcl0IIF9Wuu0TSTTRhxKu8lYMH9eZWTtsW+RhlV6Li708gmbFw9P8TFBFElrSxQorey5MjSxxT3TYoaDU1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:YQXPR01MB0021;
x-microsoft-antispam-prvs: <YQXPR01MB00214281BA0416961D33BC1E9EF40@YQXPR01MB0021.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040176)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6042046)(6043046);SRVR:YQXPR01MB0021;BCL:0;PCL:0;RULEID:;SRVR:YQXPR01MB0021;
x-forefront-prvs: 0070A8666B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(7916002)(199003)(189002)(13464003)(3846002)(7696004)(2906002)(305945005)(102836003)(92566002)(7736002)(6116002)(7846002)(107886002)(2501003)(105586002)(74316002)(11100500001)(87936001)(586003)(86362001)(10400500002)(66066001)(8676002)(1720100001)(81156014)(81166006)(5002640100001)(8936002)(19580395003)(122556002)(15975445007)(19580405001)(77096005)(3660700001)(5660300001)(68736007)(2950100001)(189998001)(5001770100001)(97736004)(54356999)(106356001)(76176999)(101416001)(9686002)(2900100001)(50986999)(33656002)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:YQXPR01MB0021;H:YQXPR01MB0023.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: mediamiser.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: mediamiser.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2016 18:01:39.4617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9009f71a-c1b6-4b55-a665-0aeb582e95d3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB0021
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
From: Philip Oakley [mailto:philipoakley@iee.org] 

>Have you tried `git ls-remote` ?
>The `branch -r` just lists the local 'rtb's (IIUC).

Nice, I didn't know about that command - I tried it though and it does list the remote branches correctly. I checked the commit refs given and it tallies with the refs at the gitolite server end.

>It could be someone has accidently pruned or deleted that branch at the remote.

I don't think so, as I say it's a gitolite server, so usually nobody is on it. We just push to it and set up post-receive hooks for if updates need to be pushed on to a deployment server.

Do you know of ways to check if anything is corrupted within the repo? I ran git fsck, but that didn't show up anything.

>What version are you (they) on?

1.9.1 at both ends (my laptop and our gitolite server)

> Gmane had to quit. Try http://public-inbox.org/git (see the help link)

Ah! Thanks. I tried searching but so far only turned up this thread.

> philip 

Thanks for your reply, Philip.

Paul

