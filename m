Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25438200B9
	for <e@80x24.org>; Sun,  6 May 2018 12:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeEFMIP (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 08:08:15 -0400
Received: from mout.gmx.net ([212.227.17.22]:54179 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbeEFMIO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 08:08:14 -0400
Received: from MININT-6BKU6QN ([81.92.17.130]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LmeGF-1efgrC1g3f-00aF2e; Sun, 06
 May 2018 14:08:01 +0200
Date:   Sun, 6 May 2018 14:08:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
In-Reply-To: <CACsJy8D0HYZFAWWn-8XEk63QohBKBE8Gx4=39Cp9_FMmbtJDew@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805061405350.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de> <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet> <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com> <CA+P7+xphRqZhwQAutph9RHAYxq=v0Zv9omdaPD3m8oV3KPdRhQ@mail.gmail.com> <CACsJy8D0HYZFAWWn-8XEk63QohBKBE8Gx4=39Cp9_FMmbtJDew@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ncZddkFZoysgpEiY71PjEZ7c5MVUHHKWKLDWot50nHW5VOBcMiB
 3nnC/V/oF7d9khb3bYIe6GXbG0ssxKHzA1q3lOeXJtRxTFJGe+AWZAvHz+MtVo6WrL+1wxN
 LNujlm4meSf0PQipb+/KqDYygWq4/bl9j3YDOwFRa1/ynrUcLEN5RQyysuobIO42GR7fvPl
 dWaOrXN8qJlBClGAk7ijw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xqqaabU1yCA=:vO13+ok9YywJbYbM3YWDXn
 e6Z9pRvzzNE26qzFQ76Qfm6Z/kWjfzd98JGKLhkR6GHC42NwwthRP6nDE32HjVimIvx6kVs20
 xT/dBtuAJIr+I0PBk0em5jfDAyXOds6cDg3OP1XZz26nVmgC2URWuWzZ7t3i5WrZFNcMlDsTj
 m/EzaQdhxUoqGnz8xZP2us7wG81gw8H5HEGxAWvSn2lvaVrjUuiDmMGWM7vk+S/fxZ2ARMCZC
 c3IXcvvWPiog9AjRtCACN3pkDtpBl6YXN9TTEtrfgnJJryskyWLB66zRO5tCNBBDAFfRSc/74
 AvAqG14Pnvc9VRxnQpAqypNuodQ7bF1u2fZFNJBdK6YiufSQ3umB8fOSkVXP6KHwsBCUTut2M
 IFJmt7GhsB01q23rjFWtwOH7ZIL2DEMcy8fquMtCHEGbQcG8JwhW7Ih6iNCKYHDFRH3EhbOoM
 6LFdF3uXhJ9fRVtc8+nr4LBh4mx+2ylC1Bsimi/ZXG6jhnwJXLZuL5PNLoOU7FX8p1Aefqhuj
 XScDk9Ro6KNYL7URmpp8PbCnf0D0i7WuI59ZYRAlpwMgXlRG3GZU+7muRx0FpuqR0iVNpmVmj
 YCzOsLYzPrC7enwEcKQuPB9WQGpQQsetIfhe6Hie4c5el7XTo5f2ap7UPgNY+u2eKXFmEOt8g
 7XBMbAaDjhVg5xwKxmFuZDbZcgTxL/dDVCbSKmPY33v/5TpuP1otu94SZNn0iR5ZUIEFbe2/U
 hwNxZLRnsbeGEN3pwQFhK459OrymkPvJlm/0Dg7h9DdWWavv4KqTYdxQWqZ48rOOH95VQ7BLL
 MvgI0Nf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Sun, 6 May 2018, Duy Nguyen wrote:

> On Sun, May 6, 2018 at 6:53 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> > On Sat, May 5, 2018 at 6:05 PM, Igor Djordjevic
> > <igor.d.djordjevic@gmail.com> wrote:
> >>
> >> On 05/05/2018 23:57, Johannes Schindelin wrote:
> >>>
> >>> > > This builtin does not do a whole lot so far, apart from showing a
> >>> > > usage that is oddly similar to that of `git tbdiff`. And for a
> >>> > > good reason: the next commits will turn `branch-diff` into a
> >>> > > full-blown replacement for `tbdiff`.
> >>> >
> >>> > One minor point about the name: will it become annoying as a tab
> >>> > completion conflict with git-branch?
> >>>
> >>> I did mention this in the commit message of 18/18:
> >>>
> >>>     Without this patch, we would only complete the `branch-diff` part but
> >>>     not the options and other arguments.
> >>>
> >>>     This of itself may already be slightly disruptive for well-trained
> >>>     fingers that assume that `git bra<TAB>ori<TAB>mas<TAB>` would expand to
> >>>     `git branch origin/master`, as we now no longer automatically append a
> >>>     space after completing `git branch`: this is now ambiguous.
> >>>
> >>> > It feels really petty complaining about the name, but I just want
> >>> > to raise the point, since it will never be easier to change than
> >>> > right now.
> >>>
> >>> I do hear you. Especially since I hate `git cherry` every single
> >>> time that I try to tab-complete `git cherry-pick`.
> >>>
> >>> > (And no, I don't really have another name in mind; I'm just
> >>> > wondering if "subset" names like this might be a mild annoyance in
> >>> > the long run).
> >>>
> >>> They totally are, and if you can come up with a better name, I am
> >>> really interested in changing it before this hits `next`, even.
> >>
> >> I gave this just a quick glance so might be I`m missing something
> >> obvious or otherwise well-known here, bur why not `diff-branch` instead?
> >>
> >> From user interface perspective, I would (personally) rather expect a
> >> command that does "diff of branches" to belong to "diff family" of
> >> commands (just operating on branches, instead of "branch" command
> >> knowing to "diff itself"), and I see we already have `diff-files`,
> >> `diff-index` and `diff-tree`, for what that`s worth.
> >>
> >> Heck, I might even expect something like `git diff --branch ...` to work,
> >> but I guess that is yet a different matter :)
> >>
> >> Thanks, Buga
> >
> > I like diff-branch, though I suppose that also conflicts with diff too.
> 
> How about interdiff?

No. An interdiff is well defined as the diff you would get by first
applying the first of two patches in reverse and then the second patch
forward. In other words, it turns two revisions of a patch into the diff
between the result of applying both revisions.

I tried very hard to avoid using that term in my patch series (tbdiff used
the term incorrectly: what it called an interdiff is a diff of two
patches, where a patch is an author line followed by the commit message
followed by the commit diff).

Ciao,
Dscho
