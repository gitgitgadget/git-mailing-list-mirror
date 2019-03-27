Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23B4E20248
	for <e@80x24.org>; Wed, 27 Mar 2019 22:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfC0WEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 18:04:49 -0400
Received: from bureau92.ns.utoronto.ca ([128.100.132.250]:40870 "EHLO
        bureau92.ns.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfC0WEt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 18:04:49 -0400
Received: from exsmtp.utoronto.ca ([128.100.46.58])
        (authenticated bits=0)
        by bureau92.ns.utoronto.ca (8.13.8/8.13.8) with ESMTP id x2RM4lvb018903
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 18:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=utoronto.ca; s=beta;
        t=1553724288; bh=gvN9oj9fm5LnSEMBYmZjmQ42ry/jgtftfcNkIoh/Bg0=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=IVeBlXVhOX9Uv9pDmcpYGnCmf/ji6xWx9Gs6G1bWIpibVdISbXDVxmDPhhm5y52ZQ
         yi7uNUqzFVD+LSe3VlYkuUlwxvEAGDjBuDKpfc+32HWDrHJhZtdDoeo+NuguuPWyLx
         4jhP+aGP9mNw/4/DBP4KDqO/i/s9wYgmnidOKyx8=
Received: from ARBOREXCASX3.UTORARBOR.UTORAD.Utoronto.ca
 ([fe80::d479:357a:c4f:796c]) by arborexhubx2.UTORARBOR.UTORAD.Utoronto.ca
 ([::1]) with mapi id 14.03.0181.006; Wed, 27 Mar 2019 18:04:47 -0400
From:   Julian Cheng <julian.cheng@utoronto.ca>
To:     "liu.denton@gmail.com" <liu.denton@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [GSoC] [t9803]
Thread-Topic: [GSoC] [t9803]
Thread-Index: AQHU5NLUUBNMeD/zM0yu7jlWN2IVv6YgPIQA///H1Io=
Date:   Wed, 27 Mar 2019 22:04:46 +0000
Message-ID: <7BFDFF1D85B3B544BB69BB9AB23D479D01F45370@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>
References: <7BFDFF1D85B3B544BB69BB9AB23D479D01F4534A@arborexcasx3.UTORARBOR.UTORAD.Utoronto.ca>,<20190327211050.GA4062@dev-l>
In-Reply-To: <20190327211050.GA4062@dev-l>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.100.46.46]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton, thanks for the pointers!=0A=
=0A=
I get the following when I run "make" in the top level directory of git and=
 I'm not sure how to deal with it. Any ideas?=0A=
$ make=0A=
    LINK git-http-fetch=0A=
.../lib/libcurl.so: undefined reference to `SSLv2_client_method'=0A=
collect2: error: ld returned 1 exit status=0A=
Makefile:2434: recipe for target 'git-http-fetch' failed=0A=
make: *** [git-http-fetch] Error 1=0A=
=0A=
________________________________________=0A=
From: Denton Liu [liu.denton@gmail.com]=0A=
Sent: March-27-19 5:10 PM=0A=
To: Julian Cheng=0A=
Cc: git@vger.kernel.org=0A=
Subject: Re: [GSoC] [t9803]=0A=
=0A=
Hi Julian,=0A=
=0A=
On Wed, Mar 27, 2019 at 07:26:12PM +0000, Julian Cheng wrote:=0A=
> Hello Git Community,=0A=
>=0A=
> I=92m new here and hoping to get to be a part of GSOC 2019. I have questi=
ons about the main project and the microproject=0A=
>=0A=
> Main Project Quesctions=0A=
> I was hoping to work on =93git revert --drop=94 and =93git commit --rewor=
d=94. Are there any mentors available for this project? The ideas page list=
s mentors for other projects but not this one.=0A=
>=0A=
> Also, =93git revert --drop=94 and =93git commit --reword=94 appear not to=
 have been discussed yet in the public inbox. Is this correct or am I just =
not finding the threads?=0A=
>=0A=
>=0A=
> Microproject Questions (test_path_is_*)=0A=
> I would like to improve t9803-git-p4-shell-metachars.sh=0A=
>=0A=
> On the microprojects page, it suggests I should run the tests to make sur=
e they all pass. But if I=92m making changes to the tests, is it really ade=
quate testing just to make sure they all pass?=0A=
>=0A=
> To run all tests, I assume I would just navigate to the tests folder in t=
erminal and call =93sh *.sh=94, but that doesn=92t seem to work. Also, when=
 I call =93sh  t9803-git-p4-shell-metachars.sh=94, I get =93error: GIT-BUIL=
D-OPTIONS missing (has Git been built?).=94 Git is definitely installed on =
my computer though. I=92ve been using it for months. I cloned this repo wit=
h Git. What am I missing here?=0A=
=0A=
When the tests run, they don't test your installation (the git you're=0A=
currently using in /usr/bin/git). They test the git you've built in the=0A=
project directory.=0A=
=0A=
First of all, you should build the project. You should run "make" from=0A=
the top-level directory of git. This will fill the directory with git-*=0A=
executables. These are the actual binaries that will be tested.=0A=
=0A=
Next, go into t/ and run "make" again to run all of the tests. You can=0A=
also run individual tests by doing something like=0A=
./t9803-git-p4-shell-metachars.sh, for example.=0A=
=0A=
For even more details on testing, see t/README.=0A=
=0A=
Also, some other helpful documentation to read include:=0A=
=0A=
* Documentation/SubmittingPatches=0A=
* Documentation/CodingGuidelines=0A=
=0A=
Hope this helps,=0A=
=0A=
Denton=0A=
=0A=
>=0A=
> Best,=0A=
> Julian=0A=
