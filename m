Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EF4820189
	for <e@80x24.org>; Wed, 22 Jun 2016 17:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbcFVRRk (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 13:17:40 -0400
Received: from mail-bn1bbn0108.outbound.protection.outlook.com ([157.56.111.108]:12898
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751242AbcFVRRi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2016 13:17:38 -0400
X-Greylist: delayed 2027 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jun 2016 13:17:38 EDT
Received: from CS1PR84MB0133.NAMPRD84.PROD.OUTLOOK.COM (10.162.189.24) by
 CS1PR84MB0135.NAMPRD84.PROD.OUTLOOK.COM (10.162.189.26) with Microsoft SMTP
 Server (TLS) id 15.1.523.12; Wed, 22 Jun 2016 16:43:49 +0000
Received: from CS1PR84MB0133.NAMPRD84.PROD.OUTLOOK.COM ([10.162.189.24]) by
 CS1PR84MB0133.NAMPRD84.PROD.OUTLOOK.COM ([10.162.189.24]) with mapi id
 15.01.0523.015; Wed, 22 Jun 2016 16:43:49 +0000
From:	"Crabtree, Andrew" <andrew.crabtree@hpe.com>
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Problem Following file history through sub-tree import
Thread-Topic: Problem Following file history through sub-tree import
Thread-Index: AdHMpBgrn6X4uL9NQiyQhZFjSs13+A==
Date:	Wed, 22 Jun 2016 16:43:49 +0000
Message-ID: <CS1PR84MB0133D7DE01AB62F197ECED4CF92C0@CS1PR84MB0133.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results:	spf=none (sender IP is )
 smtp.mailfrom=andrew.crabtree@hpe.com; 
x-originating-ip: [15.211.195.4]
x-ms-office365-filtering-correlation-id: 6352df31-4a0f-424d-12f9-08d39abc6323
x-microsoft-exchange-diagnostics: 1;CS1PR84MB0135;6:MgF/tUdu7ejsSreq6dBOv9ACFQUZkJPuJpC0k6wwVwA6LtzaY3pGZEMFRKtB2MKQ4FepFPvQy/QlmD5u7O66pFdeoN/iKyu2k5E4Kwse/yJxdn4mSLrSRd1z8MVSuKg+7oKmCNE2cwpQx1StffxKJ7omZJ3J1tAIdocnkbJ5yvPWq6JG1zRJxPx0juHLYkmQG2wyjZv7fRSvM1Ic3vO4oapR7Fq2sKtOWJhnbUGF94Ki3qlKMpUS4N9utG0AtmrGqTyeHwSMAWg4zLQn865QMexdqvTelRyQzbTKKHRndljmlpkjnlpuSjwpt682pjyK;5:dDh3H89dFeXLgEb3kMXHXGeu0JMfQ5o4t6kC+bRMnPLUTkfxybrEylAddlSZQQL5Zymq3GxbVHXBZumD5rZT2UBHVwy4kEEa2OArdAuyKBn/bZFuS2SRxmKA5EvjaVDKtszJdyTJzr/h7cr40gTdkQ==;24:fmsQZ6HErNPzrc3HK4i9/FOB99djHsRIbJosyRdnRNpJfTRQDli9dmqvJPvwl/3iw1LT+hWMVGmhr9za15PaJlpg1Ofwr1KlVWYO/CZEyj8=;7:1p5HVYaEkibC/j3CF82QmAgmqLrRgiCuuwQbTFms2mJbrJCt/xLZq8pdzVIuaspfDaK8vO2JfY2qPY97T3lbmol3qh3Eg/MFKIQujbIGIgpmjgrzl80W30oDEFHjWTArO6Ow/3qEDamQRWCp0vnCgpt86sI6hfStyC4EMtdY+MKll64H9SzPNcr1imwJml4PJjoLbx1ut7j7RnDYsDDycdxV+cF+ZHycDrHHI81ljh9vJP7bM+ZNc1KgWq6D1NVs5hAY2LmmEMSh6E7Z+n62MA==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:CS1PR84MB0135;
x-microsoft-antispam-prvs: <CS1PR84MB0135756B5F39957E17AD4FF1F92C0@CS1PR84MB0135.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(166708455590820)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);SRVR:CS1PR84MB0135;BCL:0;PCL:0;RULEID:;SRVR:CS1PR84MB0135;
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(7916002)(189002)(199003)(2900100001)(8936002)(6116002)(92566002)(86362001)(229853001)(122556002)(2501003)(450100001)(66066001)(9686002)(3846002)(575784001)(10400500002)(7736002)(50986999)(5003600100003)(54356999)(3660700001)(68736007)(2906002)(189998001)(2351001)(586003)(102836003)(8676002)(3280700002)(106356001)(105586002)(5002640100001)(97736004)(99286002)(87936001)(19580395003)(19580405001)(11100500001)(77096005)(81156014)(15975445007)(81166006)(101416001)(107886002)(33656002)(110136002)(7846002)(1730700003)(7696003);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR84MB0135;H:CS1PR84MB0133.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata:	NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: hpe.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2016 16:43:49.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR84MB0135
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Having difficulty understanding how to invoke 'git log' to track the history of a file that was imported into a different location through a subtree merge.
I had thought just '--follow' was needed, but I don't seem to be getting any results with that. 

Example below.

Thanks!
~Andrew

git --version
   git version 2.9.0
cd /tmp
mkdir subtree_test
cd subtree_test
git init 
touch foo
git add foo
git commit -m "initial"
git remote add git_src https://github.com/git/git
git fetch git_src
git merge --allow-unrelated-histories -s ours --no-commit git_src/master 
git read-tree --prefix=git_src -u git_src/master
git commit -m "import git as subtree"
cd git_src
git log pager.c
commit 22e7b2600b54f25314c399d45b1ea45d2427c754
Merge: 8df5087 ab7797d
Author: Andrew Crabtree <andrew.crabtree@hpe.com>
Date:   Wed Jun 22 08:58:04 2016 -0700

    import git as subtree
git log --follow pager.c
# nothing 

gitk pager.c *
# only shows merge commit 22e7b 

git gui blame pager.c & 
# shows history as expected 


git log HEAD^2 -- pager.c 
commit c3b1e8d85133e2a19d372b7c166d5b49fcbbfef2
Merge: 595bfef 708b8cc
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Feb 24 13:26:01 2016 -0800

    Merge branch 'jc/am-i-v-fix'
    
    The "v(iew)" subcommand of the interactive "git am -i" command was
    broken in 2.6.0 timeframe when the command was rewritten in C.
    
    * jc/am-i-v-fix:
      am -i: fix "v"iew
      pager: factor out a helper to prepare a child process to run the pager
      pager: lose a separate argv[]

commit 3e3a4a41b0dac564c0302ced4ccc423d0d39bc21
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Feb 16 14:34:44 2016 -0800
