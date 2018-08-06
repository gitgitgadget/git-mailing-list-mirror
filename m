Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A569E208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 12:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeHFPBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 11:01:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:39031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeHFPBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 11:01:10 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lqhaw-1gQxsq47ZS-00eO2W; Mon, 06
 Aug 2018 14:52:07 +0200
Date:   Mon, 6 Aug 2018 14:52:06 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] line-log: adjust start/end of ranges individually
In-Reply-To: <CAPig+cRWcFVbA76_HT2iVD16bsUmbWdCgk_07rmiGneM5czdOQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808061232120.71@tvgsbejvaqbjf.bet>
References: <pull.15.git.gitgitgadget@gmail.com> <7f92d92154143127734a638e41e064adce46a2e2.1533421100.git.gitgitgadget@gmail.com> <CAPig+cRWcFVbA76_HT2iVD16bsUmbWdCgk_07rmiGneM5czdOQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bG2pjSeedGXVYmDEYShk6cuHzaw1gvweQ81X59M9GRIqY/ZOzE8
 yD+9z5YuXQAkNdGNFH3T2xNKJwQQFW6k6EFyzWGvNxBts12vv5DP+WV6HL8YkQEd959iq5V
 D0TeH6hECLbrHDvp9N8Jz65H2oYWWkn9IYx7Sb8j3FZet4pNkpLclZnGVvx4DnfJZhu57rm
 8ynXc1avfFtLvSqaEus8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ib1eRYkJyu8=:Bp9hCAZ/1YraZSbeO/QBJ3
 bB5EM08I/5MYnv0Pqhq/+tY45/xhbEerKXMlCAnTA8VbGMSWBxqFI574CrG+TxX60uJsvELci
 0ZroZ9j2enWeCMOTS4adY4Xjr+kqG/gE9UbgwZsDfPm172GMnRSWI2ikFhG/OPrFkTEMSHsSJ
 doBs92kH2Kbg3OUsq3geBHqTVP2w63SuczmYyoyStLqTbMCE9o9k3lkwCyB78ggCr+xXJ0seR
 Y+aVc3I1p73N4AwsUeGHt/jMLVqNxF/rolqoSqR1+6a8B+1/xQ0ka4QGJqAwcNmmcTw71cPd0
 PWJzBb7el5m3sNx99Me+i1pvdwgikgYb0sEcRnPhKZKhumibo+rEkOKfrV7sCZtfwMsa4uPxb
 FA7P8IgMvQtvxqBROWG6gP3U9XvBy4El2pCsnGs8mUWCIwLRv9DYaD9z3oFaBb46S4t0w7+0e
 MeWf4QNToIF8FgYVwSkZx97oHYoIQnMD1wOTwkwOLyOQJ7JtLmf0iTVJA2TADmi2J4hmjbf5f
 igFnOGPFgM7dzwmNHkzeujp26kB+swa9TOcpGiDEtslPJzLhfeQZFuyFPR5iMi7EFNZGcv7TJ
 PyLDbi8OlZu3UxCV/jZusd7FWYUGJc0MNMxqoPGByrYwR5RrrR2kBfdJwfSojTf2VmUdzrrpc
 WDNMlTK3Hd0iShXbo/2XeYfx5rPgCFCj+r8ybdtOCXD0ZkzfeHH5x+HtBKOJpatb1KHpHOVKp
 rx2Y6Z4Pe1qzfYTEY5JYGGtKgeiQAYPbsl5AkVxKcpZZZ+Tm/PI1+z6fe20m6mYPv9RSo4+/R
 LOv+rwO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Sun, 5 Aug 2018, Eric Sunshine wrote:

> On Sat, Aug 4, 2018 at 6:18 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When traversing commits and adjusting the ranges, things can get really
> > tricky. For example, when the line range of interest encloses several
> > hunks of a commit, the line range can actually shrink.
> >
> > Currently, range_set_shift_diff() does not anticipate that scenario and
> > blindly adjusts start and end by the same offset ("shift" the range).
> > [...]
> > Let's fix this by adjusting the start and the end offsets individually.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/line-log.c b/line-log.c
> > @@ -438,7 +438,13 @@ static void range_set_shift_diff(struct range_set *out,
> >                                 - (target[j].end-target[j].start);
> >                         j++;
> >                 }
> > -               range_set_append(out, src[i].start+offset, src[i].end+offset);
> > +               start_offset = offset;
> > +               while (j < diff->target.nr && src[i].end > target[j].end) {
> > +                       offset += (parent[j].end-parent[j].start)
> > +                               - (target[j].end-target[j].start);
> > +                       j++;
> > +               }
> > +               range_set_append(out, src[i].start+start_offset, src[i].end+offset);
> 
> I'm still trying to wrap my head around the original code, so I'm not
> even at the point of being able to say if this fix is correct. What
> happens if the "start_offset" loop consumes all of 'j' before it even
> gets to the new loop?

First of all, it is not really the `start_offset` loop, but more like the
"end_offset loop": we are still adjusting `offset`, and that is what we
use to adjust the end of the current line range, while we take pains to
keep the offset that needs to be used for the start of said line range.

> Why does the new loop use '>' whereas the existing uses '>='?

As a mathematician, I usually think of intervals as inclusive only on one
end. So I intuitively use the non-inclusive comparison on the other end.

In this instance, the first loop tries to make sure that the offset to be
used for the start offset has taken into account all of the relevant diff
hunks (meaning: the diff hunks whose target lines start before src[i],
i.e. the current line range to adjust).

The second loop, however, tries to make sure that the offset to adjust the
*end* of the current line range.

Hence what I wrote.

But now that I think about it again, I am no longer sure that the first
loop (the one I did not change) is sound, to begin with. Let's imagine a
very simple case, where we try to adjust a start line, say, 100, and the
diff has a hunk with header `@@ -90,20 +90,40 @@`. So the start line lies
somewhere around a quarter into the post-image.

The current line-log code adjusts this by a very crude method: since the
line number lies between the post-image's start, it is adjusted by adding
the length of the pre-image and subtracting the length of the post image,
i.e. 20 - 40. The result is that we pretend that it came from line number
80, which is squarely outside the pre-image range.

That method of adjustment is appropriate for lines *outside* the
post-image range, of course. If we had looked at line 140 (which is 10
lines after the post-image), then it would be totally correct to say that
it came from line 120.

But that method is pretty obviously broken for any line that lies *within*
a post-image.

So I think the entire loop is in dear need of adjustment.

The question is: how should it be adjusted? The safest way would be to
adjust start and end of the line range differently, where start is pulled
back to the pre-image's start (in the above example, 90), and end is
pushed up to the pre-image's end (in the above example, 110).

Of course, this has a slightly unintuitive consequence: imagine that some
commit made a block of, say, 20 lines a conditional one. Like,

	/* Some comment */
	do_something = 1;
	...
	print_it();
	...

could have become

	if (!dry_run) {
		/* Some comment */
		do_something = 1;
		...
		print_it();
		...
	}

If you use my proposed method to adjust the line ranges to figure out the
history of that `print_it()` line, this commit would blow up the line
range to the entire conditional block, which is probably not what you
wanted.

I don't really see a better way, though.

> Having said that, a much easier fix is to use range_set_append_unsafe()
> here, and then at the bottom of the loop, invoke
> 'sort_and_merge_range_set(out)' to restore range-set invariants and
> ensure that neighboring ranges are coalesced. Not only does that resolve
> the crash and other weird behavior, but it means you don't have to add a
> special-case to range_set_append(), thus the fix becomes simpler
> overall.

That would only paper over the bug, as the line range is adjusted
incorrectly. It really is.

When looking at a line range, say, 90--110, and traversing a commit that
added 5 lines from line 100-105, then the end and the start of that line
range really need to be adjusted independently. In this example, the start
would not even budge, but the end would need to be adjusted to 105.

The current code would adjust neither because the start of the line range
is outside of the post-image range.

No amount of restoring invariants can make up for that incorrect
adjustment.

> Aside from simplicity, I think the suggested use of
> range_set_append_unsafe() and sort_and_merge_range_set() _is_ the
> correct fix anyhow because this code isn't taking care to ensure that
> the range, after applying 'offset', doesn't abut or overlap with an
> earlier range, and sort_and_merge_range_set() is meant to be used
> exactly in cases like this when invariants may be broken.
> 
> So, while the suggested fix is simpler and "better" and fixes the
> crash, that doesn't necessarily mean that the values computed here are
> actually correct. As noted, I'm still trying to grok the computation
> of these values, but that's a separate issue from the crash itself.

I think sort_and_merge_range_set() is fine for "Postelizing user input"
(Postel's law: be stringent in your output and lenient in your input,
something we should also heed in general, not only in our code).

But I don't think our code should need it. If the line ranges need to
resort to re-sorting (pun intended), that smells a lot like a bug.

And the only way those ranges could be merged is when they start to touch
(like in the test case I provided, when the lines 1, 2, 3 and the lines 4,
5, become a single line range because a, b and then c, are removed from
the original 1, 2, 3, a, b, c, 4, 5). And my suggested fix makes that
change quite elegantly, while appending line ranges (which will work
correctly if done in the correct order, which should always be the case
because both our line ranges as well as the diff hunks are ordered).

What do you think about my proposed change to adjust start and end?

Ciao,
Dscho
