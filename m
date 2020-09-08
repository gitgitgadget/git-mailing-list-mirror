Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB89C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 11:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54741206A4
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 11:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aaKtHOBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgIHLfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:35:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:44883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgIHLeB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 07:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599564778;
        bh=zBuAj5b0E4maJMDFl5rttaCwojF+Z4Xm0kBexBMzOZk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aaKtHOBZdyBQAZz6HWn8byExW01DqiM8WDZDf2jeir3deZlgZL1Kc8B3lPr55IZ+H
         ODEmUnFN3VZTmO62nrieExtKSU7ENVP/ng+euTIAvUklkoXX+G7txxwAb97raSEbp8
         qYSet41uBpe1ie54vLvdwKSPy9fptAgg9UYmdVM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.21.2] ([89.1.215.189]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLiCu-1jxwSX3Ozo-00HhXc; Tue, 08
 Sep 2020 13:32:57 +0200
Date:   Tue, 8 Sep 2020 13:32:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ci: stop linking built-ins to the dashed
 versions
In-Reply-To: <20200903104537.GA27325@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2009081332020.54@tvgsbejvaqbjf.bet>
References: <pull.411.v2.git.1598283480.gitgitgadget@gmail.com> <pull.411.v3.git.1598443012.gitgitgadget@gmail.com> <99a53284925315995e30d417cb58dfb176b036ed.1598443012.git.gitgitgadget@gmail.com> <20200903104537.GA27325@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1049194135-1599564777=:54"
X-Provags-ID: V03:K1:J5x85FM9QphNIbMx7aArJHEQE/RJ54nW78H6HnntBuOn2KiQDB1
 JGiT/6jY5YOdD+728KTIEgFstJCiDRKDq2uxWiGJn/LE+TnVN6/3FBk0dnn9xFUX8piPySw
 bMyOoLpF/gLTvep09eRfFzSeU8vzpFZ05aFFtunes8sVNDnwH8h5LjVCctgRbDsm7h3nrVF
 lpre1sqGM57vUALlYUeEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r6bG/eNby/4=:iAfbWfMCTmasic3hs3PX0E
 CLDpS82HhoLU3yuaVPqxLq0TRwz6jVzz761x7w9SuZQF/Jtx/7LoHesZyXPCW42ZSpeJ1EXDf
 49v2PdCAB2xkAolofgV0CMLQ38lCWeanX1eli2bVIS0/6vq0kdZ2kDD7cMDTc5eNW8QdnA4ns
 VQGEowaKAsxVhvYfA4tkfrlQ4UNpWV/5P/QPHVr7gLlSkg8yMMbw7QL4ANlPEzvXxdIuT0OVR
 J+yvV+od9/EJwJ0eV7/wsKaFMLAri8xtnU8yQPbBmr1wV7HWBwz8OvlPJzhlsPiNgDHCJhAmi
 8FRwIVB75o+r0YBaM40CcGAzy0+md9iNnj1FXkBrbvoWpOHhREv/ZAwAVDnOROo8mlTMllVqZ
 u5IshBl3VY44fvRiQ8VoTrlARIMMEOE2yy9yjLKsYQXpPKldrezHWagw7h7BDJZNBonjHOmJn
 qpfukgWQJQm/AxLKa9wljLRnC0gzcvCm9iLn99p1wEbGGVGqwe/hDKC+LqamphlwlFK33JyU7
 jdrJrypTP6zNO1d9S/o6OPLPYzdFen4rg6C1b56c8haqb1Ax4Hqn3zKwOl9mY+fGoxP1BEVFy
 GYFMqW3/LKv6tElv7q5gzaORXQ1dEJbz82vaWEif6w6Sua7dUflE/FwCltGYe8ftiyfhl2lGa
 aSMA/KPAHCnREwVbDM/JTB61FfG/IzMW5vrv2u6IUlAwR4fp3KVzjmRR6s6erIiYnzJhhvfXd
 ZNyuI+8u0rQvvrf/6SWX1pTFCteThTTWODrkY7clds7TgPa9coNkHIS+P8veEl+Jl1HUpIwPq
 TLOuf7BYCDHs9rByIB2KCMl0EB+Smq5FlrBiTH6ZNc8doRWKlvfNJgIHdt1LMZBY4stpI2f0A
 nvzGCS7qDYoQf99Di0p1tLJTHK0LrSNyfI6EQtChPizCAQicvgYWmDb3cVAhIaxX7ftbsF2M/
 p7v062332kI4X/OcVvNki+iYA/xOREEpDJSHourlCxSTizRh17mtUQNRwyMxuGvSRXMh6SkTn
 woN8gFXytS+Eczot0ca8ZxYhICXfkFtUi8QUzE2zbSdTrSzpBC0MESC8kaOtwxhdFA75cnGOB
 LuTHHmJrWtxLXfb2ubcr9JyTGp4xxg4FVcOgSPmr/ADmaISzVqKlYhQS/8bpuphU+tecS3Tfh
 tIJFX6RyZaBRDf5GtANqrOs8J5lYIgZXSJQpoUHyoUHfZ8Hwh2me7FG1qwJ6VeLdX/SwbZmxY
 kjEvymns6+lacNcqTR1HG7fyB6xWOwxHqhiaDkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1049194135-1599564777=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Thu, 3 Sep 2020, SZEDER G=C3=A1bor wrote:

> On Wed, Aug 26, 2020 at 11:56:52AM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Originally, all of Git's subcommands were implemented in their own
> > executable/script, using the naming scheme `git-<command-name>`. When
> > more and more functionality was turned into built-in commands (i.e. th=
e
> > `git` executable could run them without spawning a separate process),
> > for backwards-compatibility, we hard-link the `git` executable to
> > `git-<built-in>` for every built-in.
> >
> > This backwards-compatibility was needed to support scripts that called
> > the dashed form, even if we deprecated that a _long_ time ago.
> >
> > For that reason, we just introduced a Makefile knob to skip linking
> > them. To make sure that this keeps working, teach the CI
> > (and PR) builds to skip generating those hard-links.
> >
> > This is actually not such a big change: e4597aae6590 (run test suite
> > without dashed git-commands in PATH, 2009-12-02) made sure that our te=
st
> > suite does not require dashed commands. With this Makefile knob, the
> > commitment is just a little stronger (running tests with `--with-dashe=
s`
> > would _still_ not see the dashed form of the built-ins).
> >
> > There is a subtle change in behavior with this patch, though: as we no
> > longer even _build_ the dashed executables, running the test suite wou=
ld
> > fail if any of Git's scripted commands (e.g. `git-request-pull`) still
> > This would have succeeded previously (and would have been unintentiona=
l,
> > of course) because `bin-wrappers/git` sets `GIT_EXEC_PATH` to the
> > top-level directory (which would still have contained, say,
> > `git-rev-parse`).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index 6c27b886b8..1df9402c3b 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -10,7 +10,7 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -a=
w "$cache_dir/.prove")";;
> >  *) ln -s "$cache_dir/.prove" t/.prove;;
> >  esac
> >
> > -make
> > +make SKIP_DASHED_BUILT_INS=3DYesPlease
>
> Please make sure that this Makefile knob is set in all jobs building
> and testing Git, or justify in the commit message why it isn't.

The intention was to set it in all jobs (but the jury, AKA Junio, is still
out on that). Did I not do that?

Ciao,
Dscho

>
> >  case "$jobname" in
> >  linux-gcc)
> >  	make test
> > --
> > gitgitgadget
>

--8323328-1049194135-1599564777=:54--
