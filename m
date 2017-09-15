Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C828F20A21
	for <e@80x24.org>; Fri, 15 Sep 2017 05:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750830AbdIOFSu (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 01:18:50 -0400
Received: from mail-pu1apc01on0071.outbound.protection.outlook.com ([104.47.126.71]:26975
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750767AbdIOFSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 01:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NoLimitsConsulting.onmicrosoft.com; s=selector1-nlc-co-nz;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=49tICLFGBirDf3zDnrUM7FhlaIcCuHt8cVzbQL4v4CQ=;
 b=VX8BQq0lPQCWjzX0I0KpxtG/SVAi9mEBxWxtRESFbxCR6Hj0xNlWUG9voStv7c+R5C7Z0VW6SI7zXPoRF+lvKHaZ9F1DJPKYZT1mfsr2bVHDAElLctquMwbx6Eg0yVwniZBl2sLqhqvhU1TgFHnFCVMgAAQxU/eXRT1jn72057A=
Received: from PS1PR0601MB1883.apcprd06.prod.outlook.com (10.170.180.21) by
 PS1PR0601MB1449.apcprd06.prod.outlook.com (10.165.210.153) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.56.11; Fri, 15
 Sep 2017 05:18:44 +0000
Received: from PS1PR0601MB1883.apcprd06.prod.outlook.com
 ([fe80::ed29:f8ac:6c75:c6c6]) by PS1PR0601MB1883.apcprd06.prod.outlook.com
 ([fe80::ed29:f8ac:6c75:c6c6%18]) with mapi id 15.20.0056.010; Fri, 15 Sep
 2017 05:18:44 +0000
From:   Gene Thomas <gene@nlc.co.nz>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git diff --name-status for deleted files
Thread-Topic: git diff --name-status for deleted files
Thread-Index: AdMtplB2FFGuO2d0TCCYmH1TzNzo1gAKBZpQAABydqA=
Date:   Fri, 15 Sep 2017 05:18:43 +0000
Message-ID: <PS1PR0601MB188364D92388A08D1D62E7078A6C0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
References: <PS1PR0601MB1883177814CA771567A7193B8A6F0@PS1PR0601MB1883.apcprd06.prod.outlook.com>
 <xmqq1sn8zn1d.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1sn8zn1d.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=gene@nlc.co.nz; 
x-originating-ip: [222.154.250.75]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PS1PR0601MB1449;6:nrdVumcexLrf0i21BYQMxpoZlDVyMuNtO3Hk7nG9P8i/JuNO4u/vgjpvDlLMXbxlyD3HJqCIv9Vf3s3U7Giy6KOp4Z528t1a2j8kgP8xqZQerp3s9uTpLGCkPbHGitMd2GatBfXCX3vYVQWL1uw/bKzidoUpWkiza/ZagHpOTHts3fTHP0kXWqHIKRQGrl0wffW44RPe239TKp3aubSjH3/jfRjbtzaYLXCb0ftLqW9e/Gn0SxGKqhn19jlacs8JocmOGdCd2juEuTVpDcgWZIAGGZzU1CpftG6EblM1eUt5UaZNwOBvdR/E8S1TLKSEIlQGG5CfojiVhMJGizCOrw==;5:APTbM9o1OFqWz/1vcePMkYqzqCLU4FFjasvJt61/MLvmIf9PqZSGBY94LQgqLINNN/cMNIcUXiV5/7NG02xEy5A1p5DNmjsVGxaJw0gtjscxHPqEqlFO9Uxnf5zhGh3v5VAXL86kNKIDUtge/jApKA==;24:AoFUzJyJqKFtmW5/XTl8YrFIDwcXInA0e+3mgvMrXUfsGX02eS663rjSshC2n/JGrtEPhFq3/0z715LahSK5KbCSFPjyEXsZshLU/88+ay0=;7:XhvPdeycoyIiB+VZqr0gjzQCEOcR310t1wefP/FxiOjPBIqfBueWTQ1fnvrDSqTQy60/xzJDufy4XK+LkoD/rE5jHHNvthq9UDAooYP5kEA9k9nAv8g8XnPWNYcHAuPZWU+01ANUvhNMr8TK8Mbu7wsQDU9xRHUU0TRTijAeHRWlvcorI0LRnk20PD6N1j4lwc+Wtk5OfOkqTBttCwV96puNx1QnNXurvrflOYHujts=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ffdfdf53-f175-47fb-da5b-08d4fbf93c44
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(300000502095)(300135100095)(22001)(2017030254152)(2017082002075)(300000503095)(300135400095)(2017052603199)(201703131423075)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:PS1PR0601MB1449;
x-ms-traffictypediagnostic: PS1PR0601MB1449:
x-exchange-antispam-report-test: UriScan:(9452136761055)(100324003535756);
x-microsoft-antispam-prvs: <PS1PR0601MB144987AA9B650726EE838CC68A6C0@PS1PR0601MB1449.apcprd06.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(10201501046)(3002001)(93006095)(93001095)(6041248)(20161123564025)(20161123558100)(20161123555025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(2016111802025)(20161123562025)(6072148)(6043046)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:PS1PR0601MB1449;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:PS1PR0601MB1449;
x-forefront-prvs: 0431F981D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6009001)(376002)(346002)(39830400002)(199003)(189002)(13464003)(377454003)(6246003)(33656002)(66066001)(99286003)(8656003)(50986999)(101416001)(4326008)(54356999)(76176999)(5660300001)(68736007)(53936002)(55016002)(2950100002)(6916009)(8936002)(42882006)(8676002)(9686003)(81156014)(7736002)(305945005)(110136004)(102836003)(81166006)(3846002)(6116002)(3280700002)(189998001)(3660700001)(7696004)(2900100001)(2906002)(106356001)(478600001)(105586002)(25786009)(74482002)(5250100002)(316002)(74316002)(97736004)(6436002)(14454004)(86362001)(53546010)(229853002)(6506006);DIR:OUT;SFP:1101;SCL:1;SRVR:PS1PR0601MB1449;H:PS1PR0601MB1883.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: nlc.co.nz does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nlc.co.nz
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2017 05:18:43.9531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dcf97d24-0da4-497e-88f4-de71fd6a3c56
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB1449
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,
           Thanks for your reply. So git is essentially doing a "git commit=
" when I "git rm".=20

Gene.

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com]=20
Sent: Friday, 15 September 2017 2:58 PM
To: Gene Thomas <gene@nlc.co.nz>
Cc: git@vger.kernel.org
Subject: Re: git diff --name-status for deleted files

Gene Thomas <gene@nlc.co.nz> writes:

> Hello,
>           "git diff -name-status" is useful to list the files one
>           has changed but it does not list file that one has
>           deleted with "git rm". It would be really handy if it
>           did. I am using git 2.9.3 on Ubuntu Linux 16.10.

With or without --name-status option, "git diff" compares between the conte=
nts you have in the index and in your working tree.  After you modify conte=
nts of a file, i.e.

	edit file
	git add file

you would not see that file edited exactly because the file on the filesyst=
em is identical to what you added to the index with "git add".

Your example works exactly the same way.  Instead of modifying the contents=
 of a file, removing the presense of the file and recording that fact to th=
e index (i.e. removing the path from the index, too) is done with "git rm",=
 so after running

	git rm file

your working tree would lack "file" and so would your index.  Hence you wou=
ldn't see "git diff" report any difference on "file".

Perhaps you wanted "git diff HEAD", which is a way to compare between the c=
ontents you have in the tip commit and the paths in your working tree thru =
the index?
