Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D329C1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 12:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeCZMou (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 08:44:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:60137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeCZMot (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 08:44:49 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAUpK-1epwp90uDa-00Bbxe; Mon, 26
 Mar 2018 14:44:41 +0200
Date:   Mon, 26 Mar 2018 14:44:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <874lllh09b.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803261405170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com> <4918cc79-79ba-5dd2-ea84-dc47db47d835@gmail.com> <b11785bd-5c96-43c1-95d8-b28eccfd13c8@gmail.com> <d29d3c0e-6473-0461-c8ea-02975ce4de14@gmail.com> <nycvar.QRO.7.76.6.1803111644380.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <6362804d-e204-a9e0-9ff0-51d8497ce921@gmail.com> <nycvar.QRO.7.76.6.1803121056400.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <874lllh09b.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0S8iJJMvXV66KTzbtYwxqbtvqktcI5HCfLZlqmbq1kbEOX0+U7L
 mgdOCPffIJdK+/faejD9KTBeEwIxEN8tlIt2qbXsHO4jhjEoy2dU6n0ZsR8vy8xg9DGs5vY
 mtPxXHp09TEyqe6czzbT1cbLSJk7LzE1BS2HLr6985DBDMBfZ47sWLPmR7mo/SC22aEcK8i
 4xcPAFde3+lY6rs4N1OJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mgKgBqKldAU=:Pi9TW5tv/QSjHQ5zA65wkO
 5MA1HiDKmrcif8g8yQtsYZ7b9bxJjzVnIJOSX3QMB5AOsrF+0SByliTKAydgw8CZpQw2udvwx
 ZPIZtBPnPAflc3mTmNbeF7s5Yx8owuax4Wilta2EKubblWH6ycZ9RLxXguHhZVrB3IZygvNZS
 yI8JHXWEVqxDmzcmiJkPW+OQfIh9ryjTIie/vnlA8t7onMmMuRCXGs3jZDoXNLTjwJSl3OxZV
 4p/JoPhBWB+cNYZ2ZfGyLkbobJXKCmZWHTXaFGOhueGrcPAo37HcHsI4H88gYxuud9Uok1Jcy
 xKe1siFqUjCgIXaUBl+cevH7IxthCMcWYYz8dmXRlUpa5PlBh2NyAgUPRnMI1pKOmW80Y/2sf
 LmMwNQQdYxmSkgsQxskgZq5s1Q/W8GEXSN7L9Etz8oTIhXS7RQoFYtKdHyL8kg459e1zdm/Ik
 CeDqzXXwGHBGG6j65xjfEfYFojZYE3XD3Q6ItyTsWbCw1rEhCYkTY+1dlT2iHr6vA8ouFvAyB
 CFvwfzEk80kEhuvQd0g4wrW8ii7HL89M70b+4l+D+OL1UAkL6hT+YcutrWma1bNayv+NURa79
 aQ/T3mb3EHzBMRZ2fO92xaWTP+goZCw2MSFNjD6cE4wjCmN1T9t/1XQ6zO3Jj3JY5N7Ro7kPX
 6YrXlesFDtmdnxPQBBZmgaCe5zLzAZ0WyZqw/bmET1T8tvLIyDAzoadCCUABXgNgINJfYa0mZ
 ST2KwLPMoujuNuphFIbcrLowI1Jg4Dz50zfVSlslPeDEB8jkdwIEcxC2AQtlKXSAh2eY17fqJ
 CyB9oiVTcdnM6OOm1M9tQth4oqDhKk7ig/TdWVwHmG8yqrkiBk31/jWDLN+SxXwATaNrpj5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, 12 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > [...]
> >
> > Where "easy" meant that I had to spend 1h still to figure out why
> > using the unrebased merge parents as merge bases.
> 
> That's because you try to figure out something that is not there in the
> [RFC v2]. I suggest to forget everything you've already imagined and
> just read the [RFC v2] proposal afresh. It should take about 10 minutes
> or less to get it. Really.
> 
> > The same amount of time did not allow me to wrap my head around
> > Sergey's verbose explanations.
> 
> Honestly, I don't believe it, sorry, but I'm willing to explain anything
> you wish to be explained in _[RFC v2]_.

No, really. If you cannot bring yourself to believe my words, then I hate
to break it to you: I am not lying.

As to "I'm willing to explain anything you wish to be explained in RFC
v2": I was asking, and asking, and asking again, for a simple summary of
the idea behind your proposal. Nothing. That was the answer.

I had to figure it out myself: the idea is to *create* fake commits,
non-merge ones, for every single merge commit parent. Those fake commits
combine the changes of *all* merge commit parents *but one*. And then
those commits are rebased, individually, with tons of opportunities for
merge conflicts. Repeated ones. And then that result is merged.

Except that there is something more convoluted going on because of that
dumb, annoying requirement that this also has to work interactively. Where
somebody like myself might have done something really annoying such as
dropping commits, or even amending them with changes that had not been in
the previous version of the merge commit parents.

So then, after doing a ton of work to rebase the original merge commit's
changes, we perform three-way merges with the already-rebased parents (or
actually, the new tips, because as I pointed out, the parent commit may
have been dropped or reordered) to *undo* those painfully rebased changes.

No matter how much you are married to RFC v2: it *does* do unnecessary
work, it *does* result in a *lot* more opportunity for merge conflicts,
and as a bonus: it even introduces the opportunity to come up with
two versions of the rebased merge commit that disagree with one another.

> > But I'll take your word for it that the strategies are equivalent, and
> > go with the one that has both a simpler explanation (in my mind, at
> > least), and an more robust implementation.
> 
> It's up to you, and it'd still be much better than what we have now, but
> you will need to face the (I think unfortunate) consequences I just
> summarized elsewhere in the thread.

No, it was not up to me. It was up to you to convince me (or for that
matter, anybody else on the Git mailing list), that your approaches are
essentially the same.

But they are not, as your RFC v2 includes a detour of unnecessary work.
Even if the end result is theoretically the same, *practically* your
approach forces a lot of work on the user, work that is often just thrown
away!

Let's take a concrete example. Like, an example that really came up. On
the Git mailing list. A tangible example that shapes my experience, and
more importantly: other Git users' experience as well.

I introduced a change to the funny construct `void *data = data;` that was
meant to fool GCC versions that could not figure out that data would not
be used uninitialized. While that shut up GCC, it upset other compilers
that now said that this new construct does not make sense. My approach was
to introduce the macro `FAKE_INIT(type, name, value)` which would be
expanded to `type name = name;` for GCC, and to `type name = (type)value`
for all other compilers.

This was a change I wanted to cook in Git for Windows for a couple of
iterations until I am sure it works as expected, also on non-Windows
platforms, and with other compilers than MSVC, GCC and Clang.

Recently Ramsay Jones spent the time to research this issue a lot deeper
than it was done before, and found out *which* GCC versions are affected,
and introduced a patch series that fixes this problem for real, *undoing*
the `void *data = data;` mess.

Obviously, this fix conflicts with my work-around.

Okay, good, so what would happen, hypothetically, if the Git garden shears
I use (and which you probably still haven't studied, even if I pointed you
to it several times, but expecting me to read RFC v2 at the same time
instead of answering my questions about it) were adjusted to use RFC v2 to
rebase merges?

To answer that, I first have to tell you that Git for Windows' branch
thicket consists of roughly 70 topic branches that are partially
criss-cross-merged. There are roughly 40 merge commits (44 if I counted
correctly) on the commit graph between HEAD and that work-around that
conflicts with Ramsay's fix.

So the first thing that would happen when rebasing the branch thicket is
this: I would encounter the merge conflict when my workaround is
cherry-picked, realize that my work-around is no longer necessary, and
call `git rebase --skip` and that's that.

The Git garden shears currently do not even try to rebase merge commits,
so that really would be that. I might encounter unrelated conflicts, but
nothing about the `void *data = data;` issue again.

With Phillip's approach, the same is true, as the 40+ merge commits would
be rebased with my work-around being undone by the first three-way merge,
the second three-way merge being unaffected (and no further 3-way merge
necessary because I do not do octopus merges in Git for Windows branch
thicket) and that's that.

(There is a chance, of course, that I misunderstood, or that I missed
something. The proof lies in the pudding. Somebody will have to try this,
and this somebody is probably me.)

With your RFC v2 approach, however, the original tips of all of those 40+
merges would be "cherry-picked" (via those intermediate fake commits).
Conflicting every single time. And of course the subsequent three-way
merge to undo the changes (because I dropped the change via `git rebase
--skip`) would conflict *again*.

That's an awful lot of merge conflicts. One might be tempted to suggest
complexifying the entire procedure by requiring `rerere`, and my initial
answer would be that this still conflicts when the context lines of the
merge conflict changed, but the truth is: this level of complexity, this
amount of merge conflicts, is not even necessary, as seen by looking at
Phillip's strategy.

This is what I referred to as "unecessary work". And to me, as a power
(read: frequent) user of the closest thing we have to --recreate-merges in
the wild, it is not funny. Not funny at all.

BTW this is the level of detail I would have wished your answers to my
repeated questions for clarification of your RFC v2 to be. And that is
what I expect in response to my valid questions in the future.

Ciao,
Johannes
