Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299321F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeHJXui (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:50:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:51311 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727234AbeHJXui (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:50:38 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBExR-1feeRA42DN-00AG34; Fri, 10
 Aug 2018 23:18:58 +0200
Date:   Fri, 10 Aug 2018 23:18:59 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
In-Reply-To: <CAGZ79kbj2sgKOmouvLDuXic3vq9RG1LZ_retOqMwX_YZtMP+1Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808102313070.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com> <nycvar.QRO.7.76.6.1808081422160.71@tvgsbejvaqbjf.bet>
 <CAGZ79kbj2sgKOmouvLDuXic3vq9RG1LZ_retOqMwX_YZtMP+1Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MHO2Uv9UXF3v/1vUEkPG1TBv18VhFasWMAYJZxwNNUsk8eIsSzs
 TdVPk+e/6345t26+WhAe+/w3/pdgOmFSp9a2YbTnoVSv0FUeu3RTdeVmSwqaf/I0rBL2240
 ZxRZVRWztRDtGmKFAEsZxvjZltyXzzqCZxLH5GzpzK13Damz+FZVgyUE/v9WVozbethXiEy
 GDDZB4Sao1+mcUrWtnNQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1PK1O2kkXpk=:qVrZVj6R5HXE0KepZUr4wZ
 /p/xUAFjyMZ20l4fBCMQYW3c2TPN1GRDUXKOIlnaEJBA98biGDUJSmxrRlPpm+3NGOzMmPWtQ
 I/VMi4lTORklaF7h9Wx5s2ze1wf4qL/PFSTZUPrHz1FE8hrPuaEB5Ya3JaAlLxqc9HCgWT0uD
 jVIEScbGI0/5ovqEJd6WR856GGFkyPHpFEQJnINgcVnpLaUg2icIB3xTcKpedxI56SgDeKY16
 Wt2jPxgsX3sGtSY11NhYjCVU3XNF2B0tYAJnML5m1JNzpUVHhjwTn1DOGGIh9FE4Y1WRVB4Cp
 yLs6Hk7IINBXq1ZYtYpVFDMp4Usa23QFP4PjXVP3jaHHiCGDhSF1zInAiQv+OxxjC3XVVHk+r
 CUHnwkbJBOodwivf38QQk9J55U+8dG8yO+Bsn6HmBHd2GfwYNdUDFn0ahTMdH3rSzOaVL58ni
 XSufIfeMRuZSlxorF41+1TGoq0QJnX1cqezUmCSEBjp6W/pR4as5t7CKAcV3OfBcxeuRlZi0L
 NmMIEYffJS0R488NT3BXUsCtYa78HRpCFUgTwPmCRbJNpudohvYiPo12sdXks+trdJLor/Ft9
 5sPjwiliq1NVwthRG+WnDM5eVXPrs3duljtqEo/PnI++x38E8Zs7m4aOox+8Xrm3d/QzhAa0S
 oqsi42HHMlw4tZPIo9SRPNVuW3Tq1HSE729IJEXfL+61oohVvDwzErVduEu2QbvFnINS4R9Hz
 yVW9UNK4TuAchGCmL+HjaumjqPDyR5J79WkFaM/pGJ1IpZwS/ju25x6mRPcaLE8Sc25nTcbWE
 nbzD9hm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Wed, 8 Aug 2018, Stefan Beller wrote:

> On Wed, Aug 8, 2018 at 6:05 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > > [...]
> > > >       diff --git a/Makefile b/Makefile
> > > >       --- a/Makefile
> > > >       +++ b/Makefile
> > >
> > > The line starting with --- is red (default removed color) and the line
> > > with +++ is green (default add color).
> > >
> > > Ideally these two lines and the third line above starting with "diff --git"
> > > would render in GIT_COLOR_BOLD ("METAINFO").
> >
> > I agree that is not the best coloring here, but as you remarked elsewhere,
> > it would require content-aware dual coloring, and I am loathe to try to
> > implement that for two reasons: 1) it would take most likely a long time
> > to design and implement that, and 2) I don't have that time.
> >
> > So I would like to declare that good enough is good enough in this case.
> 
> I anticipated this answer, so I wrote some patches myself, starting at
> https://public-inbox.org/git/20180804015317.182683-1-sbeller@google.com/
> specifically
> https://public-inbox.org/git/20180804015317.182683-5-sbeller@google.com/
> 
> I plan on resending these on top of your resend (if any) at a later convenient
> time for both you and Junio, as noted in
> https://public-inbox.org/git/CAGZ79kZnVEsvpicNu7LXkRcHuRqGvESfvG3DL5O_2kPVYrW-Gg@mail.gmail.com/

Thank you!

> > > >   3:  076e1192d !  3:  4e3fb47a1 range-diff: first rudimentary implementation
> > > >      @@ -4,7 +4,7 @@
> > > >
> > > >           At this stage, `git range-diff` can determine corresponding commits
> > > >           of two related commit ranges. This makes use of the recently introduced
> > > >      -    implementation of the Hungarian algorithm.
> > > >      +    implementation of the linear assignment algorithm.
> > > >
> > > >           The core of this patch is a straight port of the ideas of tbdiff, the
> > > >           apparently dormant project at https://github.com/trast/tbdiff.
> > > >      @@ -51,19 +51,17 @@
> > > >       + int res = 0;
> > > >       + struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
> > > >
> > > >      -- argc = parse_options(argc, argv, NULL, options,
> > > >      --                      builtin_range_diff_usage, 0);
> > > >      -+ argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
> > > >      -+                      0);
> > > >      +  argc = parse_options(argc, argv, NULL, options,
> > > >      +                       builtin_range_diff_usage, 0);
> > >
> > > This is really nice in colors when viewed locally.
> > >
> > > >  16:  dfa7b1e71 <  -:  --------- range-diff --dual-color: work around bogus white-space warning
> > > >   -:  --------- > 16:  f4252f2b2 range-diff --dual-color: fix bogus white-space warning
> > >
> > > Ah; here my initial assumption of only reviewing the range-diff breaks down now.
> > > I'll dig into patch 16 separately.
> >
> > Right. This was an almost complete rewrite, and then next iteration will
> > hopefully bring another complete rewrite: disabling whitespace warnings in
> > dual color mode.
> >
> > > Maybe it is worth having an option to expand all "new" patches.
> >
> > Sure.
> >
> > And I also have a use case for --left-only/--right-only.
> >
> > And I also have a strong use case (and so does Junio, it seems, or for
> > that matter, anybody contributing to Git due to Junio's insistence on
> > signing off on each patch, rather than on the merge commit) for something
> > like --ignore-lines=<regex>.
> >
> > And you probably guess what I will say next: these features will make for
> > really fantastic patch series *on top* of mine. There really is no good
> > reason to delay the current patch series just to cram more features into
> > it that had not been planned in the first place.
> 
> Yes, I agree.

I am happy to hear that.

> I am unsure about the current state of your series, though;
> 
> Junio thinks (expects?) a resend, whereas you seem to call it good enough
> but also said (some time back) that you want to resend due to Thomas
> feedback.

Sorry about being so unclear. When time gets scarce, sometimes I get too
stressed (and too short on time) to communicate properly.

Yes, I want to limit the new features put into this patch series, in the
interest of getting things into `next` (and maybe still into `master`
before v2.19, but I am not allowing myself to hope for that too much).

And yes, I want to send another iteration, as there have been too many
changes that I do not want to ask Junio to touch up, in particular because
I am a little bit of a detail-oriented person and want my fixes just so.

> I do have 2 series on top of the current range-diff.
> * The first (queued by Junio as origin/sb/range-diff-colors)
>    adds a basic test for colors and improves diff.c readability
> * The second (linked above) changes colors for some lines.
> 
> I do not want to build more on top as long as I do not know if
> you resend (and how much it'll change)

It will not change much. The biggest change is that the white-space
warning thing is done completely differently, so that I do not even have
to be in ws.c's author list.

I'll just try to get that option parsing change in that Eric suggested,
force-push, then wait for macOS and Linux builds to pass (trusting that
Windows will follow suite) and hit /submit.

Ciao,
Dscho
