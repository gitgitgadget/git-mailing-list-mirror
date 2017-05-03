Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF301F829
	for <e@80x24.org>; Wed,  3 May 2017 14:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbdECOXo (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 10:23:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:58489 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbdECOXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 10:23:38 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzKyn-1e9PuP0Aqn-014WhW; Wed, 03
 May 2017 16:23:16 +0200
Date:   Wed, 3 May 2017 16:23:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Abide by our own rules regarding line endings
In-Reply-To: <20170502215627.GX28740@aiede.svl.corp.google.com>
Message-ID: <alpine.DEB.2.20.1705031323390.3480@virtualbox>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <20170502215627.GX28740@aiede.svl.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9gxivNnCBTQY2DMLAQrfoeP/hw2oMNDESLZi6zTiMvyGP9l6gih
 +Fmni0t1uxZV/c9YPyhfu4ct9ILqnfOoOv7q6IDR577ociL5Y5Xx802ij3cel7mSRJrSIVa
 KEaV2ZIXe3Qq+1jdWgtYUiRp01MJ0sz3j/koD5ZYs8vSS1t1wyiyyReWM1E6Y9sgL5TfTFV
 6LrfFJBKiYSHv4KQDu0Lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iTBweyPvh0M=:K9ZzCkNJVv2YPvumUOnNzW
 jD1P1zvN5X+RI58K7JiBGXBlvvlnzLGYbsI5+VhmXuwvseErSYMDgMM6CW3SYK5O+QfGYmwuV
 +JbSivRynW8/0B+wkmOZUG2o0OltOP1IqUDgjdP1yyetwgrL/AwPj5WOY5VDx2sdHj86CZD1r
 pVN5M/Z7sSPrGvCaa8ah0IznQvR9008RfETyRsYhygRbF1vHV0nImX7hmwLml7U+yGP7OhbA4
 jHOsxeJClvGFgRjuoT2D13Wauzm3NQN1Z6G36N4pB6Q+/Jh2wkAgFfMt5S699Xjy1cHKuXP+U
 5QnNFRAziPLf6gZrkCxW59fLxJH/CTBJDsGZarFGV+BHGkQwTx6YWzQfCP3YFhobOtWnNdjBG
 YJ8rcBiKw7zUzTJ0uy08ds4HfE9TdvdFnB3MuPxWxq0Z4IIb/70SQ3/xFiGJ0RHi33NvEqkNb
 QGJOiWJsLGxZyIYe4MD6iCQwo/+ao7UWxJd9pdHus4/CLW2QJF9dac+A69q2vnRlZ1t3ybQep
 Z/PYJwDq+X53f99ifWhPodeyKZlOOgeUSr8vDe3o0zxdkbeYQoq8eVRo1LPBHiFkmyHYcwtMw
 YZUAFGcjC19vkargeQpmib/xMQGldw5Ka93pOox+qhu44vhFFYgtHi58UAhHB/MhUZPdMMgWx
 BdrkIwdx1AX8HGWJZIb10o96X3uwJzVuFiXlxSuu3cmtselY/LF0vWnxC65wrJiFnnOF3Q6Qg
 u8JwSgSrS6YUv/hIQa3pQ1liVUMSx6CfotrCnuW2PpgvhBKnFCrGyUwdBCXe4WWnwIbjLECPe
 q70Fhf+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, 2 May 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > Over the past decade, there have been a couple of attempts to remedy the
> [...]
> 
> I'm intentionally skimming this cover letter, since anything important
> it says needs to also be in the commit messages.

Sure, makes sense. I tried to do that, too, before sending out my patch
series.

> [...]
> > Without these fixes, Git will fail to build and pass the test suite, as
> > can be verified even on Linux using this cadence:
> >
> > 	git config core.autocrlf true
> > 	rm .git/index && git stash
> > 	make DEVELOPER=1 -j15 test
> 
> This should go in a commit message (or perhaps in all of them).

Hmm, okay. I wanted to keep it out of them, as commit messages are (in my
mind) more about the why?, and a little less about the how? when not
obvious from the diff.

I added a variation to the first patch (because the tests would still
fail, I skipped the `test` from the `make` invocation) and the unmodified
cadence to the "Fix the remaining tests..." patch.

> [...]
> > Johannes Schindelin (5):
> >   Fix build with core.autocrlf=true
> >   git-new-workdir: mark script as LF-only
> >   completion: mark bash script as LF-only
> >   Fix the remaining tests that failed with core.autocrlf=true
> >   t4051: mark supporting files as requiring LF-only line endings
> 
> With or without that change,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

I added that footer to the patches (not to the two new ones, though).

> The t/README bit in patch 4/5 is sad (I want to be able to open
> t/README using an old version of Notepad) but changing that test to
> use another file seems out of scope for what this series does.

Yes, it is sad. Maybe I should list the tests that do this (use files
outside any tNNNN/ directory):

t4003-diff-rename-1.sh (uses t/diff-lib/COPYING)
t4005-diff-rename-2.sh (uses t/diff-lib/COPYING)
t4007-rename-3.sh (uses t/diff-lib/COPYING)
t4008-diff-break-rewrite.sh (uses t/diff-lib/README and t/diff-lib/COPYING)
t4009-diff-rename-4.sh (uses t/diff-lib/COPYING)
t4022-diff-rewrite.sh (uses COPYING)
t4023-diff-rename-typechange.sh (uses COPYING)
t7001-mv.sh (uses README.md (!!!) and COPYING)
t7060-wtstatus.sh (uses t/README)
t7101-reset-empty-subdirs.sh (uses COPYING)

Note most of these tests may *use* those files, but do *not* assume that
they have Unix line endings! Only a couple test compare SHA-1s to
hardcoded values (which, if you ask me, is a bit fragile, given that files
outside the tests' control are used).

Interesting side note: t0022-crlf-rename.sh copies *itself* to the trash*
directory where it is then used to perform tests. So while this test uses
"an outside file", that file happens to be a .sh file which we already
have to mark LF-only for different reasons (Bash likes its input
CR/LF-free).

Another interesting side note: the convention appears to dictate that
supporting files should be either generated in the test script itself, or
be committed into t/tNNNN/ directories (where NNNN matches the respective
test script's number, or reuses another test script's supporting files). A
notable exception is t3901 which has the supporting files t3901-8859-1.txt
and t3901-utf8.txt. I would wageer that this is just a remnant of ancient
times before the current convention, judging by the date of the commit
that added these files: a731ec5eb82 (t3901: test "format-patch | am" pipe
with i18n, 2007-01-13). The scripts t0203-gettext-setlocale-sanity.sh,
t9350-fast-export.sh and t9500-gitweb-standalone-no-errors.sh merely reuse
those files, and when those scripts started using those files, they did
not change their location. I made this move a preparatory step in this
patch series.

Back to the question what to do about those tests that make improper
assumptions about line endings of files outside the tests' realm: I think
I can do this more cleverly, as it would appear that only four test
scripts make hard assumptions about the exact byte sequence of the COPYING
file, and I simply turned those `cp` (and even `cat`!) calls into `tr -d
"\015"` calls.

I will Cc: you on v2.

Ciao,
Dscho
