Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC651F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHJXhA (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 19:37:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:58713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbeHJXhA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 19:37:00 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08ia-1g2Jbi1yzU-00uJS8; Fri, 10
 Aug 2018 23:05:22 +0200
Date:   Fri, 10 Aug 2018 23:05:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 16/21] range-diff --dual-color: fix bogus white-space
 warning
In-Reply-To: <CAGZ79kZRoN6DmKYPyvQ33yXqxz8ukfuXVROw9pzZBvob-vjHAQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808102303270.71@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <f4252f2b2198cf13d5b0a21c54098e2a1d8158dd.1532210683.git.gitgitgadget@gmail.com> <CAGZ79kZRoN6DmKYPyvQ33yXqxz8ukfuXVROw9pzZBvob-vjHAQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ash7Y/PwyZy6tf3VMZyuTXDvmWHLd7u3G1kAzMsNHJ1IGGbA4xq
 dZkw/RRc6994XtHi5xd8xpI0vygGC5lO7K6ZO14YBZ1MTaRDvj1E9Hp2DoslQFqLJNLzb9/
 bjc0DRpO8AMDnhd5gKLz3InFnLpec1OGZAGB1Tq7Vlvv6E6CGh9tOQqDIDy92PcZjdmWpyK
 Fvic/pzPA5XrbMNcM/lLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ea5Mw4irtz4=:ZodegMBN9h02jPHy4Su0ni
 8NCF8zDUjz09LPDkrQLPvY4upPfFWPHfZIK6a6kApnqIdd2q/F6kKJwk73YoxcTDFOHgKf3tA
 m5oyXnmkjpE7cUws85BaXmqCVTwcV+JHMl3YE4UNGgH0pbif782x7TP1z6rU3gkjAWZrapJTl
 bC1YMf5WM9dIamvYhnzGIjZR4/XcZ+7aMaVh5jxn0MDTVBoKnjmVJAI0OWn6nO3oRoW5sDpJJ
 2bovQXGKRBY66G6oiX2xGKtwvYu3sIS/YYEnCEM0zqbVySqzwvysamVHRrj/3PVBldzHptx8R
 NvJNs92BHYx/e68DFXtT93f/3XtXxWeCGtViand3O7W2apl1cB0rqxVsNGb+2onoToa/aZlHp
 rLhNUSlU8TN8b4PSJzkWj4JyoCAi24WvxcMzPR9bI6lCYZZ/ZdV1nfRVEIh2omoY7WMulx58z
 i6ZmVI4USxTv11qSEFnOALQQB18fgV8j5v8rX4QhLkuxK7FcFtT6x2+1pZ9RnQcVrmIqzJmkt
 wc1AJakzF57U6sBrQeFROMLMOAYc7AoKB6xrbEck3OVaNGYp4xh3jdcVbLMSLX6HuhODyGBhP
 IIeO9CYm+1wsUvfrcKDfAgfR0p+Eqq1oro3Tw99J8DUV+HWMMYbVUAF4wa6h+SORb54V2Vh3G
 6ysnGebwirW/Ksa28ubGOVkG4A9PD0HgzBz1SuMNgr4JvY7OYlBGZ5GOERcgTwBK8VwQOtuuj
 Nfo2YK9ssGxmglwiKIvJHdE36onS+6DVEniAyZbCKSAvRYVVHgiMitOsg4alpun2aatmPoCX/
 cBAemT5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 23 Jul 2018, Stefan Beller wrote:

> On Sat, Jul 21, 2018 at 3:05 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When displaying a diff of diffs, it is possible that there is an outer
> > `+` before a context line. That happens when the context changed between
> > old and new commit. When that context line starts with a tab (after the
> > space that marks it as context line), our diff machinery spits out a
> > white-space error (space before tab), but in this case, that is
> > incorrect.
> >
> > Fix this by adding a specific whitespace flag that simply ignores the
> > first space in the output.
> 
> That sounds like a simple (not easy) solution, which sounds acceptable
> to me here.
> 
> I guess you dropped all ideas that I originally proposed for the cleanup
> regarding ws. that is fine, I can roll the cleanup on top of your patches
> here.

Yes, sorry, I got the impression after our chat on IRC that you tried to
address something different from what I needed, anyway?

> > Note: as the original code did not leave any space in the bit mask
> > before the WSEH_* bits, the diff of this commit looks unnecessarily
> > involved: the diff is dominated by making room for one more bit to be
> > used by the whitespace rules.
> 
> It took me some minutes, but I am reasonably convinced this patch
> is correct (and doesn't collide with other series in flight, sb/diff-color-more
> adds another flag to move detection in another bit field at (1<<23))
> 
> Thanks for writing this patch instead of the other, though I'll leave
> it to Junio to weigh in if this approach is the best design.

I am sorry that your time was wasted in addition to mine: I will go with a
simple one-line patch in v5 instead, a single line that simply disables
white-space errors altogether in dual color mode.

Ciao,
Dscho
