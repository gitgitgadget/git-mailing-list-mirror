Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80911208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 13:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeHHPZM (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 11:25:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:52733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeHHPZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 11:25:11 -0400
Received: from CN-A-YUPLIU-X1C.fareast.corp.microsoft.com ([37.201.193.145])
 by mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfVzj-1fXeaD40EN-00P2av; Wed, 08 Aug 2018 15:05:27 +0200
Date:   Wed, 8 Aug 2018 15:05:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
In-Reply-To: <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808081422160.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CoI7T7e0fLDHy9VjTd6Bkvarhw/d+f0+lLXureRI/DUGIAtYi1j
 Ms2HJBypJGbevT//B+Ej5EY/nJNeZAp51R7esWvlc/fsMxJAABHPS9nqoac1dwhATH329Nw
 +DlfYFvsssY28YjJJum3bYQD+gMCZX61YXNpYPVF1dcWGhXX2zw7+XylkcDJ1/pa/Hc/Fu2
 RDAq2gNHWS05c2y5uINRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T8ZrtZHutlo=:dD/vBh446BSL8Zg07MqW74
 4YXHfynOzQQZMWadh2GppPPS1yCfAhLaOS9jNyqI5mY3S030tEYk1WraRv3Yk0CmA1MkQa1UR
 5pVIoVh6cWCXVGLkp9iy62euHu/ujjcezqzZpa7ChNsMbqt4sRXU19ZTyPr2d2Ca3bh7qNsOD
 qpttEakxYjSy3Ph1cQEaP1MIQRKj91ibNK8gPggFVruFTImWGYhWlAzjOkT8mUMRfGPiN5VjP
 +HfmquhXFAhXoe8Pwv6paPyf07TA7ti5dclGYs2SrByN93YWeOhmuovL4SvrF7inqcGDZftQ8
 aeZNHq660U0m/F4u9YE4teYQJdynGWPXeQi6kykt/nWopFumEkfHO3agKydmSv9NPfKHrm+f+
 0Xnk0llAiS9nkbNjPafrI2AXCUU/8QXWtwz2MtOQ7wsY6xzs6dZbzKiBfJbCxeSVQTkOZbvg0
 etBSZmX90xxpt36ifPMpnbH+399EleXnkzpWi33ZJ3uVusbQ1erOfJAi7QIBOvK/GK2bYHMiU
 zAqNCrHf0PJvgKJrF0npWou97PreCQ8VTS15WPvaRe9Lpm4gicLi4KZRChPG0yXHWlp4tVRbC
 AhjVa8H2pl3jHORUF1Z/ijM+zaFbdKG7fiQvaYco79M1+17qMDl/E5GDvXw8P6qPGUgqEC/FG
 JcyhoqMnhPVgbVo56bHWThF0cq/apr140Smip28KKMl15P2a9U4wWIn21ZGA/OPUMYX21syDG
 lVp4BHP2YIEpuxWdhWxwa+OW/u2WYuwRr7AQqg+8yqNcBwXA/A6NCVEXHdoCcg7/EaWUUf0si
 AFSolaJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 23 Jul 2018, Stefan Beller wrote:

> On Sat, Jul 21, 2018 at 3:04 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> >   1:  39272eefc !  1:  f7e70689e linear-assignment: a function to solve least-cost assignment problems
> >      @@ -223,9 +223,7 @@
> >       +                         BUG("negative j: %d", j);
> >       +                 i = pred[j];
> >       +                 column2row[j] = i;
> >      -+                 k = j;
> >      -+                 j = row2column[i];
> >      -+                 row2column[i] = k;
> >      ++                 SWAP(j, row2column[i]);
> 
> The dual color option (as a default) really helps here. Thanks for that!
> Does it have to be renamed though? (It's more than two colors; originally
> it was inverting the beginning signs)
> 
> Maybe --color=emphasize-later
> assuming there will be other modes for coloring, such as "diff-only",
> which would correspond with --no-dual-color, or "none" that will correspond
> would be --no-color. I imagine there could be more fancy things, hence I would
> propose a mode rather than a switch.
> (Feel free to push back if discussing naming here feels like bike shedding)

I do feel free to push back on that.

> 2:  7f15b26d4ea !  82:  88134121d2a Introduce `range-diff` to compare
> iterations of a topic branch
> [...]
> >       diff --git a/Makefile b/Makefile
> >       --- a/Makefile
> >       +++ b/Makefile
> 
> The line starting with --- is red (default removed color) and the line
> with +++ is green (default add color).
> 
> Ideally these two lines and the third line above starting with "diff --git"
> would render in GIT_COLOR_BOLD ("METAINFO").

I agree that is not the best coloring here, but as you remarked elsewhere,
it would require content-aware dual coloring, and I am loathe to try to
implement that for two reasons: 1) it would take most likely a long time
to design and implement that, and 2) I don't have that time.

So I would like to declare that good enough is good enough in this case.

> >   3:  076e1192d !  3:  4e3fb47a1 range-diff: first rudimentary implementation
> >      @@ -4,7 +4,7 @@
> >
> >           At this stage, `git range-diff` can determine corresponding commits
> >           of two related commit ranges. This makes use of the recently introduced
> >      -    implementation of the Hungarian algorithm.
> >      +    implementation of the linear assignment algorithm.
> >
> >           The core of this patch is a straight port of the ideas of tbdiff, the
> >           apparently dormant project at https://github.com/trast/tbdiff.
> >      @@ -51,19 +51,17 @@
> >       + int res = 0;
> >       + struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
> >
> >      -- argc = parse_options(argc, argv, NULL, options,
> >      --                      builtin_range_diff_usage, 0);
> >      -+ argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
> >      -+                      0);
> >      +  argc = parse_options(argc, argv, NULL, options,
> >      +                       builtin_range_diff_usage, 0);
> 
> This is really nice in colors when viewed locally.
> 
> >  16:  dfa7b1e71 <  -:  --------- range-diff --dual-color: work around bogus white-space warning
> >   -:  --------- > 16:  f4252f2b2 range-diff --dual-color: fix bogus white-space warning
> 
> Ah; here my initial assumption of only reviewing the range-diff breaks down now.
> I'll dig into patch 16 separately.

Right. This was an almost complete rewrite, and then next iteration will
hopefully bring another complete rewrite: disabling whitespace warnings in
dual color mode.

> Maybe it is worth having an option to expand all "new" patches.

Sure.

And I also have a use case for --left-only/--right-only.

And I also have a strong use case (and so does Junio, it seems, or for
that matter, anybody contributing to Git due to Junio's insistence on
signing off on each patch, rather than on the merge commit) for something
like --ignore-lines=<regex>.

And you probably guess what I will say next: these features will make for
really fantastic patch series *on top* of mine. There really is no good
reason to delay the current patch series just to cram more features into
it that had not been planned in the first place.

> (Given that the range-diff
> pr-1/dscho/branch-diff-v3...pr-1/dscho/branch-diff-v4 told me you used a
> different base, this is a hard problem, as I certainly would want to
> skip over all new base commits, but this one is interesting to look at.
> An easy way out: Maybe an option to expand any new commits/patches after
> the first expansion? Asking for opinions rather than implementing it)
> 
> >  19:  144363006 <  -:  --------- range-diff: left-pad patch numbers
> >   -:  --------- > 19:  07ec215e8 range-diff: left-pad patch numbers
> 
> >   -:  --------- > 21:  d8498fb32 range-diff: use dim/bold cues to improve dual color mode
> 
> Those are interesting, I'll look at them separately, too.

Thanks,
Dscho
