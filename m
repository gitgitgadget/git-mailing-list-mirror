Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA64B207D6
	for <e@80x24.org>; Sat, 29 Apr 2017 10:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166572AbdD2KoR (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 06:44:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:60289 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164079AbdD2KoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 06:44:15 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKyn-1e8juY1SZF-014Ugo; Sat, 29
 Apr 2017 12:44:07 +0200
Date:   Sat, 29 Apr 2017 12:44:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] t7400: add BSLASHPSPEC prerequisite to 'add with \\ in
 path'
In-Reply-To: <f9dfd9b4-e753-1a53-175e-8f20fe904501@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704291232410.3480@virtualbox>
References: <5b8e0f3a-0b64-1384-d830-5b65a43e44c4@ramsayjones.plus.com> <xmqqk265kz2v.fsf@gitster.mtv.corp.google.com> <7cd09c17-30a1-b157-2454-4c9b399a8628@kdbg.org> <a575542a-e5b6-389f-e240-d5ac5a4b4107@ramsayjones.plus.com>
 <f9dfd9b4-e753-1a53-175e-8f20fe904501@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AW97umxJMAI5QniK/9A1pO+RrJOE4459zTFXF96HDXgrL2TNea+
 69+TeZnZd2NDUaELu8gMYV0chQmRD6UOy7GLdnh5hSPKXAxc+t1zXP1E1gyVgYDFT55yFs1
 nd7Y8QOJux+0b/0UDGzDiXk6uDhkVoV/wezxTONJ+6ZO4gjqesG0zhBmktkoiCFTgWLNJ9a
 zPNO3G6lGS+XmdC+/TpgQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z8LpsblHKNw=:q7/LIUs1WRPPd1NbFMHPat
 DlWTr4+Wg5S9nm/qrA0AjkifYjAT+BbjO2bnPJ6WzO4AqqA3vZaH6AzH9QlsVECruZBC7vpcD
 W6yC5R9oinMp5juHs0YTp4f8rsQ21I7y6vvo1HuHUJHOz9eq69gP4ikZIKcd68JkpaUUfI4/2
 96T9uPUsAoXpMSN/DDiju/b9/0fxhhY+j1g2ptb50tjp782W2Sjt4xwTqhVfjIt7Bwi4Fwge3
 2UJ7P8pZRe/RBMN0UCAEwoJBBtXc9FxcnGoqEalJW2XECQ2nFYOV5CV20xgVWy5K7NPf5/4Oy
 Q4X0HrN6LK62KgkXt+yJVpzCRox3Xi4sfXNZ3zG02GYkKRsu56y5QCkun7U03k6Ocz1XmBMfF
 WvSs6JReoum8yJngwncBzuGojJWF0gnY4qKqxfTQjPpIFC5pEGn2TfKC0B5IT7jOrdFtx2pqt
 1l7wRoTViGaGUUOHavI4hABr7QAHTqptJRLnU0ZKgUsYWJhxB8vTyfAGR5gWnv7q3Kg5e24jG
 nAmBWCd4wq1vWo+Xsoz0HQ+lZ0MnAgrUHHARNziRCm9uh+MqaKHx3yZ2TF1ZTzrQp82k7vPOe
 9cvyeajywr78Zxue//uwOZIYMaX/01pf8eoMD1Kofcga2GZg/GW2wXldwCRGDl+KzFuwP3/oB
 9nzm5FEJ7bqyl7FQaGVgt1YlqP2MC4el350YDRmoCJicRqX40gdpsjZFnJnoItUzBkZJJpILn
 zIfVeP0FQ8YWx09tt8p/X9csL4Trtos5OsRrwE87wQOIHnz8AAmmOGd+Ka1YQ4m7+4AZhfsag
 X/rr0VU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 29 Apr 2017, Johannes Sixt wrote:

> Am 29.04.2017 um 02:15 schrieb Ramsay Jones:
> >
> > On 28/04/17 20:54, Johannes Sixt wrote:
> > > Am 28.04.2017 um 05:09 schrieb Junio C Hamano:
> > > > Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> > > >
> > > > > Commit cf9e55f494 ("submodule: prevent backslash expantion in
> > > > > submodule
> > > > > names", 07-04-2017) added a test which creates a git repository with
> > > > > some backslash characters in the name. This test cannot work on
> > > > > windows,
> > > > > since the backslash is used as the directory separator. In order to
> > > > > suppress this test on cygwin, MinGW and Git for Windows, we add the
> > > > > BSLASHPSPEC prerequisite. (see also commits 6fd1106aa4 and
> > > > > c51c0da222).
> > >
> > > First, let me say that meaning of BSLASHPSPEC was
> > > "keeps backslaches in pathspec arguments" originally,
> > > but it apparently changed meaning since then.
> >
> > Indeed. I started to give some of the history in the commit message, but
> > it was nearly 3am, so I punted with the 'see also commits 6fd1106aa4 and
> > c51c0da222' ... ;-)
> >
> > > t7400.20 does not fail for the MinGW port because the
> > > test case only operates on the file system, but never
> > > checks whether an entry 'sub\with\backslash' is present
> > > in the index.
> >
> > Ah, OK. I only looked at my (64-bit) MSYS2 build, which fails
> > exactly the same as cygwin. Hmm, wait, let me just rebuild on
> > MinGW64 ... indeed it passes (well it passes t7400.20, but it
> > fails on t7400.11, 61, 63, 87 and 89)!
> 
> I don't observe these failures. Are you using a vanila MSYS2 environment?

Please note that the "vanilla MSYS2 environment" is *not* expected to pass
the test suite when compiling in MINGW mode. In fact, it is expected to
fail.

In 2015, I made a couple of changes to the MSYS2 runtime in preparation
for the big bump to Git for Windows 2.x (which switched from the old MSys
environment to the new MSYS2 environment), and released Git for Windows
2.5.0 with a heavily patched msys-2.0.dll. My hope was that those changes
would be welcome in the MSYS2 project, but well, they kinda weren't. So I
was forced to abandon my original plan to contribute all of those fixes to
"upstream MSYS2".

To see the changes I (and others) made:

	https://github.com/git-for-windows/msys2-runtime/compare/master%5E%7B/Start.the.merging.rebase%7D...master

I even started collecting the exact tests that are failing with the
vanilla MSYS2 runtime vs Git for Windows' fork, when I still had hopes
that we could test things with AppVeyor (but the builds were already too
slow, we hit the timeout even before trying to run the tests, so I gave up
on that front):

	REM MSYS2's runtime does not carry Git for Windows' tweaks yet, so these
	tests cannot pass:
	set GIT_SKIP_TESTS='t0003 t0006 t0024 t1100 t1400 t1402 t1501 t1504 t1506
	t1508 t1513 t3001 t3070 t3200 t3301 t3400 t3404 t3513 t3703 t4116 t4150
	t4208 t4211 t5000 t5001 t5002 t5004 t5500 t5601 t5602 t5603 t5801 t6006
	t6018 t6041 t6130 t6132 t6300 t7201 t7400 t7501 t7502 t8002 t8006 t9001
	t9350 t9700 t9903'

The reason I did this was to avoid having to spend time in the CI job to
replace the vanilla MSYS2 runtime with Git for Windows' forked one (and
AppVeyor offers a -- rarely updated -- version of MSYS2 in its build
agents out of the box).

I might have dug deeper in order to skip only specific test cases, but as
AppVeyor was already a dead end...

Ciao,
Dscho
