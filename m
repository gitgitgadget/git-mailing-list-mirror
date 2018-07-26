Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7961F597
	for <e@80x24.org>; Thu, 26 Jul 2018 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbeGZLEL (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 07:04:11 -0400
Received: from mout.gmx.net ([212.227.17.20]:45235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbeGZLEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 07:04:11 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRjd7-1fXRmo0Lnt-00StZa; Thu, 26
 Jul 2018 11:47:59 +0200
Date:   Thu, 26 Jul 2018 11:47:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
In-Reply-To: <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807261121570.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WfouMsZUy4cSeU+Kh/y/SudziD7f8gUZciHsNAOt5OXFVRlKjO5
 qVWcM2NFuKS5SaCCXRLqsNYSZVNTfsFyNY5ddkD3wUrbySyXS5qsAM89tBe2fSwThsfes+y
 oKze8LIQ4Ba9Oktl+WSiKVNV7jdhotM/vjHyaVg1cpBYNei78HmqRS9/lbjp/Rgt3UbMAyy
 b4005OMqOFff1IiryVGVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+g9II3kwWiQ=:Oa/8FXpxkEy1TSoPxfephw
 0Ci8V7Ggd4I8lECCIykEMQTso77IhDkb0BXSPpTaCK6T2zIn3StuHD80cqXgQNPsWq6sGSF84
 gqPnLgu/JfVuCnNaE4n+oo3lEjABegU4XSZtl2RM+sSyoaSAglyVZfU4VrI6xb4bwGSQeBqvK
 JTeVb3mFK0+fViGO7vGlOlBmpoui+UGC7mv08mHURd2dzMfSfdbYAEAWXZSAJ8pYlP3NPgpfo
 C01L2skiBLbHQAX17+zKpBlCtWFzAHoPFg/BCo5yqL7W6w/GBgRRfo3ZZ5JEL+5XbvUdCNAEF
 +qc7YusaawRYO8MzljJkf5/YDpr/u+fR5cxCZolaVsjIdYdkxM5IgV2rNFLvodJrfsf12TA2q
 2A3fjEWYNpWm0CgsEKfwmdaQq0Pazr2kwaA6QkWE+4rPjNstTkNYHDbYYYYv5SBFoLD79odim
 GVXG1oYMR8DzB7hNIPcQS2ujt8KYh37HT6w4Z8Pzv/+6Vdlr04lmSg5uPpfRIPm19B8T8Zapm
 dyWfpMzdV/w2PoVch3J+HQUq+GtjhRLQe5fSD/UwTvzEnK2cuce/Ti1fdJmL/yaxImRJc2+ND
 +iDtmEbGyON4Ig//vR+EnuI8iEx76yNaDcjlDJ3utNSYlJkgFTqfjnF1vx1AsNsvwkFOdfrZY
 0fz0hbZ12NEh2kYz3NKNZNw/9evPybIUOXGIEFroc3ZIoWRfXoEb26nC3YQ2x9Y0TZoig4NqL
 +wffiRbZY8vie9jHM2E4sB5mQkwTYgxHFIkB02uz6577Rm6vkYWHD9eivrNtf10kHoBIpEXOc
 Nq75TFU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 23 Jul 2018, Stefan Beller wrote:

> On Sat, Jul 21, 2018 at 3:04 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> 
> > Range-diff vs v3:
> >
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

I understand (and understood) the "dual" to mean that there are two
separate coloring methods, the coloring of the inner, and the coloring of
the outer diff. (And in my mind, the dimming is not so much an "inner"
diff things as an "outer" diff thing.)

> Maybe --color=emphasize-later assuming there will be other modes for
> coloring, such as "diff-only", which would correspond with
> --no-dual-color, or "none" that will correspond would be --no-color. I
> imagine there could be more fancy things, hence I would propose a mode
> rather than a switch.  (Feel free to push back if discussing naming here
> feels like bike shedding)

Your suggestion does not really feel like bike-shedding to me, here, I can
see the merit of it.

It's just that 1) overloading `--color` here would be cumbersome, as
`--color` is *already* a diff option that we actually use, and 2) I am not
all that certain that new fancy things will crop up anytime soon. It was
hard enough to think of the dimming feature, and then implementing it.

So while I think your idea has merit, I still think that we can do that
later. The --no-dual-color option can easily be deprecated in favor of,
say, --color-mode=<mode>, when (and if) new modes crop up.

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

I see where you are coming from, but given how complicated it seems to me
to implement this (dual color mode gets away with working line-based for
the moment, and what you ask for would require state, and would not even
be fool-proof, as the `diff --git` line might not even be part of the
context.

Seeing how long this patch series has already simmered, I would want to
invoke that old adage "the perfect is the enemy of the good", and rather
see a version of range-diff enter Git's source code, if need be marked as
"EXPERIMENTAL" so that the maintainer can claim that it is okay to be
buggy, and then invite contributions from other sides than from me.

> >  16:  dfa7b1e71 <  -:  --------- range-diff --dual-color: work around bogus white-space warning
> >   -:  --------- > 16:  f4252f2b2 range-diff --dual-color: fix bogus white-space warning
> 
> Ah; here my initial assumption of only reviewing the range-diff breaks down now.
> I'll dig into patch 16 separately.

Right. In this case, it is a total rewrite, anyway (and I'll have to ask
you to overlook my frustration with how complex and hard it is to work on
ws.c without breaking anything). For the sake of review, you should ignore
the old patch. Unless you find that the new version is so complex and
prone to introduce bugs (with which I would agree) that we should go back
to the original workaround, which is so easy to understand that there are
no obvious bugs lurking inside it.

> Maybe it is worth having an option to expand all "new" patches.

Sure. And I would love to have this in a separate patch series, as it is
well beyond the original purpose of this patch series to simply make
tbdiff a builtin.

I should have known better, of course, but I was really not keen on
improving range-diff *before* it enters the code base, to the point of
introducing new features that might very well introduce new regressions in
unrelated commands, too.

Essentially, I am declaring a feature-freeze on this patch series until it
enters `next`.

> (Given that the range-diff
> pr-1/dscho/branch-diff-v3...pr-1/dscho/branch-diff-v4 told me you used a
> different base, this is a hard problem, as I certainly would want to
> skip over all new base commits, but this one is interesting to look at.
> An easy way out: Maybe an option to expand any new commits/patches after
> the first expansion? Asking for opinions rather than implementing it)

Any fulfilled wish is immediately welcomed with offspring, it seems.

Again, this is a very nice feature, I think, and even nicer: it can be
implemented by somebody else than me, on top of my patch series, after it
stabilized and entered `next`.

> >  19:  144363006 <  -:  --------- range-diff: left-pad patch numbers
> >   -:  --------- > 19:  07ec215e8 range-diff: left-pad patch numbers

Yes, this is something where I would have used a different
`--creation-factor` locally, but I did not want to hack up GitGitGadget
*just* for this patch series.

> >   -:  --------- > 21:  d8498fb32 range-diff: use dim/bold cues to improve dual color mode
> 
> Those are interesting, I'll look at them separately, too.

That last one is indeed very interesting, from a feature point of view,
and a little intimidating from a review point of view: it entered the
patch series only in v4. Combined, this is a clear sign that I should not
have included that feature in this here patch series. But I did fall prey
to "featuritis". I'll try to be better about this. The most important
thing now is to stabilize the `range-diff` command and to get it included.
It already simmers for way too long.

Ciao,
Dscho
