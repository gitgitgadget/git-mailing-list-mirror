Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351D91FAE3
	for <e@80x24.org>; Thu,  8 Mar 2018 07:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935043AbeCHHBk (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 02:01:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:40339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751741AbeCHHBV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 02:01:21 -0500
Received: from [192.168.1.64] ([88.26.243.156]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MK0ur-1evCSj0Ja1-001Q5O; Thu, 08
 Mar 2018 08:01:13 +0100
Date:   Thu, 8 Mar 2018 08:01:08 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <87vae7ykys.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803080746460.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87vae7ykys.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:g+V5dw9GTJ3r1m9NrLZN01vgyDSYglzZsqOsDo4onpn4mkNX+mV
 kqCzgDn/LwPuksfcBbhD+H9eTIm67oa+xLxMWx5uBeb27yFRKvkU+jilpxxzMo5DyPXtzPa
 SeWotlr3e2uC/VJu5V1RV0qaWO2et/P3WXasjenoUQggITsEu5yJ9uH7T02PKIMdlmkaciQ
 fg/mAA0IEanpBwFE+gR5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CFpWzeNUFJ4=:2t52P+6uOwGPHVQ4E83mk8
 XkefBjLwtKsbdojmh+N6p/bfqjzu9c70c3ZKxUZcKVRcWKhn91yGS2Tze98/ZiCCaX5F/D47e
 kzbUfuXQqxIP8pM8ejkcUY6TPjyhs9CxPXpro9MdAbIai2Q+u/7pe7J6waQbXlKRiCWBgLV1n
 u7BmQmFcjLFt6KcNTd3xLfu+LfcRmMGv6J6ELBugwhIdiHifB0n/x+7QIrQKofggoF/jotdVq
 8bI3wIRiMhAkHTt9fxIS7gJ9FAoKDbFl5W4wDSenZ21uos2iEhV8HhwAEIrU8eDBf175SVMHQ
 lM9i1WW03uinhYYTaabacPTLECDjcgr8BatwmbmEQt/AS4VIyJyfH2+J2gBNX+303lTDIjVla
 0uqaIYL4t9L/RIYYjmVTI/Un/qrb/1GwlhAVEH3avI1lb1nuQOCH+vsw1cpARvMM7KZXnaQcS
 Qaj1yJl5NRbF+Tc7BxRG/kIm3LaJYtdIb33uvwjMfCWsaNU2S+CLc3H2TuBp/5eFgRKrBCI0i
 u0uyL2trGfa4Uj/bUxaIRKBYHMjEc54I0mm0XNcLp0qzOkX6FCAj6hFGFderGwBnZKP3Nh/3m
 xlzvqYoGHgZa2pMCWfz2e11GVGfjIbb9+qZbo1osQlN236vOvUAsa3JdB4ilYyJlZrS2Awo5T
 Q9+gR4PBUOUXCURdC9cBHFn6r5QBuIHw3HoXrBc847u9cVztdhFZc9fseLtdatYEVXRxIOWz6
 quE987Pj7mBdx2zAUQIE79B1P1+NgB06g3biABYBQ1M9ZKJ9A2jsOmgRegfV8KoWMDs7lHAyt
 BfqnXa9oMqAk2NGw1yiVALZA2sOrvCqliIEsYed1ELiRe/ZL44=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Wed, 7 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > On Wed, 7 Mar 2018, Sergey Organov wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > On Tue, 6 Mar 2018, Sergey Organov wrote:
> >> >
> >> >> This is v2 of my "Rebasing merges" proposal.
> >> >
> >> > Didn't we settle on Phillip's "perform successive three-way merges
> >> > between the original merge commit and the new tips with the old
> >> > tips as base" strategy?
> >> 
> >> It seems you did, dunno exactly why.
> >
> > That is not true. You make it sound like I was the only one who liked
> > this, and not Phillip and Buga, too.
> >
> > Are you interested in the best solution, or in your solution :-)
> 
> I'm interested in any that works, and only you say that those suggested
> by Phillip is somehow superior. I still believe it's mine that superior,
> even if slightly.

That is misrepresenting what happened.

First, you came up with a strategy. I pointed out shortcomings that
implied that we cannot use it unchanged. Then, Buga fixed your strategy by
using additional steps (making the process more complicated than before,
still without a simple-enough explanation for my liking, fixing the
shortcomings). Then, Phillip presented a super-simple strategy and Buga
confirmed that it also fixes the shortcomings I pointed out.

I am very excited that we finally found something that works *and* is easy
to reason about.

Let's focus on that strategy rather than going back to the strategy which
has known flaws and only an unsatisfyingly complex explanation.

> >> The main problem with this decision is that we still don't see how
> >> and when to stop for user amendment using this method. OTOH, the
> >> original has this issue carefully discussed.
> >
> > Why would we want to stop, unless there are merge conflicts?
> 
> There is somewhat lengthy discussion about it that you probably missed.
> Not to repeat it, just see how 'rerere' works when it fires during
> rebase, even with no conflicts.

I did not miss that discussion. My question was a follow-up: Why would we
want to stop, unless there are merge conflicts?

> >> > It has the following advantages:
> >> >
> >> > - it is *very simple* to describe
> >> 
> >> The original is as simple if not simpler:
> >> 
> >> "rebase sides of the merge commit and then three-way merge them back
> >> using original merge commit as base"
> >
> > And that is also wrong, as I had proved already! Only Buga's addition made
> > it robust against dropping/modifying commits, and that addition also makes
> > it more complicated.
> 
> No. Get your facts straight. The [RFC v2] already fixed that original
> mistake. Could you please finally read it?

I do not see Buga's additions, and it is still a lengthy document that is
hard to understand.

Phillip's alternative, in contrast, fit in at most two 80x25 pages and was
intuitive (at least after seeing that the tree resulting from a merge is
identical to the tree resulting from a rebase, once all merge conflicts
are handled appropriately).

> > And it still has no satisfactory simple explanation why it works.
> 
> It has. It's there in the [RFC v2]. You seem to be the only one who
> doesn't get it. I suppose you just didn't bother to read.

I tried to read it, and got lost in all those figures that really do not
do anything to make this strategy obvious to me.

Granted, I now know *how* it works.

I gave up understanding *why* it is supposed to work.

With Phillip's mail, it only took me 5 minutes to get a rudimentary
understanding why it works.

> >> No problems with octopuses, and no virtual merge bases of recursive
> >> merges to reason about.
> >
> > But those are no problems for Phillip's strategy, either!
> 
> I thought it was you who started to discuss virtual merge bases and
> related problems, as well as how it's difficult to support octopus
> merges, but it's fine with me if there are none of these problems.

Yes, I started explaining virtual merge bases, and how they are used in
the recursive merge. Because I was asked how the recursive merge works,
and I happen to know how it works very intimately.

> > So your point is...?
> 
> Still the same -- use what's better, the [RFC v2].

I strongly disagree that your approach is superior. It is more complex,
and still has no simple answer to the question "why is this supposed to do
what I want it to do?"

It does a lot of criss-crossing, and when I see that, I immediately
suspect that it would lose information e.g. when commits were amended
during the rebase. There are just way too many paths for obsolete changes
to creep in again.

> >> > - it is *very easy* to reason about, once it is pointed out that
> >> > rebases and merges result in the same trees.
> >> 
> >> The original is as easy to reason about, if not easier, especially as
> >> recursive merge strategy is not being used there in new ways.
> >
> > So do it. I still have to hear a single-sentence, clear and obvious
> > explanation why it works.

Please.

> > And please do not describe why your original version works, because it
> > does not work.
> 
> Original [RFC] didn't work because of rather simple mistake that I've
> already admitted and fixed. [RFC v2] has got the fix. Read [RFC v2] and
> get your facts straight.

I don't care how many mistakes you made, and where the original ideas had
to be enhanced. I am only interested in the outcome.

We already have a nice, simple outcome, and to be quite honest: I find
this discussion here a bit pointless. Why would I abandon a simple
strategy that obviously works for a complex strategy where it still is not
obvious under what circumstances it works, and why?

> > Describe why the one amended with Buga's hack works.
> 
> It doesn't matter as these hacks are not needed anymore.

So maybe you want to also describe the "interdiff", and not expect anybody
to read two lengthy documents and figure out where the changes are.

> >> I honestly don't see any advantages of Phillip's method over the
> >> original, except personal preferences. At the same time, I have no
> >> objection of using it either, provided consistency check problem is
> >> solved there as well.
> >
> > Okay, let me reiterate then, because I do not want this point to be
> > missed:
> >
> > Phillip's method is essentially merging the new tips into the original
> > merge, pretending that the new tips were not rebased but merged into
> > upstream.
> >
> > So it exploits the duality of the rebase and merge operation, which both
> > result in identical trees (potentially after resolving merge
> > conflicts).
> >
> > I cannot think of any such interpretation for your proposal augmented by
> > Buga's fix-ups. And I haven't heard any such interpretation from your
> > side, either.
> 
> No fix-ups or augmentations are needed. It was a mistake that has been
> fixed in [RFC v2]. You've missed essential part of the discussion.
> 
> Read the [RFC v2], please:

Okay, I am done here. If all my questions and all my concerns are answered
with the suggestion to spend an hour pouring over a lengthy description of
your strategy that is so much more complex than my preferred alternative,
asking me to figure out from that long document what the answers to my
questions are, then I respectfully decline. I do have other things to care
about, too, and I will *not* spend an hour trying to figure out answers
only because you refuse to give them directly.

Ciao,
Johannes
