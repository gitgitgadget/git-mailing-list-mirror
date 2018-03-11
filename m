Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EB571F404
	for <e@80x24.org>; Sun, 11 Mar 2018 15:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932169AbeCKPkw (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 11:40:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:43015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932107AbeCKPku (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 11:40:50 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MaqeA-1fFK1j0Ds2-00KTb9; Sun, 11
 Mar 2018 16:40:41 +0100
Date:   Sun, 11 Mar 2018 16:40:45 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution
 (Road Clear)
In-Reply-To: <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com> <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87vae8yq15.fsf@javad.com> <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gHcegkYn6UbrEVHkxgM2PFzpmOvvdhUU3qiChJHOM8e7w7lNfdT
 PRhWJbF5TBotHuvSfPROS+4UtzlVC61fLGSxmQ6fNqp5HdMjl+XlqAzMBUlPYCx5IRf2tlx
 pq3QWqSWOaY1UMR7sZ5bqWrr99U5yCHsXFIHX0SgvtaHUVWPUCIhAUwS3EJMHdz9F7gJE/M
 qVV72psq7mIjKgQ89s/Jg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C243tb738lA=:3fpsLG0Bdj92Af3uSxVGsX
 JJEKxv0Ho/sziHHRNC/7n4vK8cl6HBdPdDFJ5MdML8oI095yx/cqCKsZ5v+WfKAqpwNMel/VI
 549Y+clsPG79BdgkYAW0eljBSTw1I9kytZULbaWH/v046ep05nIkwPhp9YKCE842b3s8ilyvj
 jbt/MiYm2zY1mKUUBCzBUfBc7OkSSps5fbCkXgvjMc9YsKmwZjAdReE/0ENCz9DNDH22vJ56N
 7D6mUwdSYAjb6pXAYAtk7eLwTF7E+ZZ05wrq6VMs3rofYGf1ElcG2jlmgQ1HrQJJAkJEhCxnN
 2VcbX4sHYSP3JA2UNtIvLs0CiXryqlvluTOgVU2WKnTpGX8BVoiZaKXyJyuTuTf186SjduiRG
 cG6doxea9Y2wZ0eZL56jlIYTJswbLSFPPeMlVgXEaTDve+M8bC2altIkJE/ilrcP7qkruVGZp
 n8GlOESLY/+G3XG875YPF3o/ckMYH2RyMGT5309XR32+einvbARerx2xIzzVGeWzqr5OlRcJs
 oAJ68TBvPl+U9DPH7qVY++GOuZ1SBLp/kd5svouH9ji78smEWyVPZQdrG2eiWAljwrXpPMq7r
 bmeF2sdxhTgYUwLDUZaUMMtfGRbUmkRfhN3irMy1TmklLly9/RldAMWHHIn208v0oeFFdjhWj
 RPAtY6DkRJ3jSUkobL/HydE/L639M+pB3ql7ZUek8T5cuZ2uQDfKvCI1PU0hGadWzVFKmcX1I
 7zM3j7Dp2gQFX44XlNUP4YSRiwdPG56XDX53Te6ZhB+UnajZ/FiKdWw5QvP+MX9payeQK7Zhv
 ibq2UFr8/KCxEhNhbLmFqcyXFpvBDczGRcauFiKEZvtjjj3i/yZwquwCkz326d+adkBJXOH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Thu, 8 Mar 2018, Igor Djordjevic wrote:

> On 07/03/2018 15:08, Johannes Schindelin wrote:
> > 
> > > > Didn't we settle on Phillip's "perform successive three-way merges
> > > > between the original merge commit and the new tips with the old tips
> > > > as base" strategy?
> > >
> > > It seems you did, dunno exactly why.
> > 
> > That is not true. You make it sound like I was the only one who liked
> > this, and not Phillip and Buga, too.
> 
> For myself, I do actually favor Sergey`s approach in general, but 
> _implemented_ through what Phillip described (or a mixture of both, to 
> be precise). But, let me explain... :)

So as you explained later in this sub-thread, Sergey's approach is
essentially the same as Phillip's.

I still do not understand Sergey's approach on a fundamental level. I
mean, I can follow his instructions how to implement his algorithm, but it
is as if I had a blindfold on and somebody guided me through a maze: I
understand *what* I am supposed to do, but I have no clue *why*.

And admittedly, I got very frustrated when a document was thrown my way
that is too long to read in one sitting, and all of my attempts at getting
clear and comprehensible answers to specific questions were met with "go
and read that document, I am sure you will understand then".

For something as fundamental to my daily workflow as an interactive rebase
(*especially* when trying to maintain the branch topology), this is no
good at all.

Since you already confirmed that there is essentially no difference
between the two approaches, I will simply go with the one I understand, in
particular I understand *why* it works.

But let's read on, maybe I will change my mind based on your explanations
(which do answer my questions, thank you so much for that)...

> > > The main problem with this decision is that we still don't see how
> > > and when to stop for user amendment using this method. OTOH, the
> > > original has this issue carefully discussed.
> > 
> > Why would we want to stop, unless there are merge conflicts?
> 
> Because we can reliably know that something "unusual" happened - and by
> that I don`t necessarily mean "wrong", but just might be worth user
> inspection.

We have a similar conundrum in recursive merges. Remember how multiple
merge bases are merged recursively? There can be merge conflicts, too, in
*any* of the individual merges involved, and indeed, there are (under
relatively rare circumstances).

Since we already faced that problem, and we already answered it by
presenting possibly nested merge conflicts, I am in strong favor of
keeping our new scenario consistent: present possibly-nested merge
conflicts.

As far as I understand, one of the arguments in favor of the current
approach was: there is no good way to tell the user where they are, and
how to continue from there. So better just to continue and present the
user with the entire set of conflicts, and have an obvious way out.

> For example, situation like this (M is made on A3 with `-s ours`, 
> obsoleting Bx commits):
> 
> (1) ---X8--X9 (master)
>        |\
>        | A1---A2---A3
>        |             \
>        |              M (topic)
>        |             /
>        \-B1---B2---B3
> 
> ... where we want to rebase M onto X9 is what I would call "usual 
> stuff", but this situation (M is still made on A3 with `-s ours`, 
> obsoleting Bx commits, but note cherry-picked B2'):
> 
> (2) ---X8--B2'--X9 (master)
>        |\
>        | A1---A2---A3
>        |             \
>        |              M (topic)
>        |             /
>        \-B1---B2---B3
> 
> ... where we still want to rebase M onto X9 is what we might consider 
> "unusual", because we noticed that something that shouldn`t be part 
> of the rebased merge commit (due to previous `-s ours`) actually got 
> in there (due to later cherry-pick), and just wanting the user to 
> check and confirm.

We already have those scenarios when performing a regular interactive
rebase, where a patch was already applied upstream. In the normal case,
the user is not even shown B2, thanks to the --cherry-pick option used in
generating the todo list.

Granted, in some cases --cherry-pick does not detect that, and then we
generate a todo list including B2, and when that patch is applied, the
interactive rebase stops, saying that there are no changes to be
committed.

And this behavior is exactly the same with --recreate-merges!

So I do not think that it would make sense to bother the user *again* when
rebasing the merge commit.

If there are merge conflicts, yes, we will have to. If there are none
(even if your U1' != U2'), it would be outright annoying to stop.

> > > "rebase sides of the merge commit and then three-way merge them back
> > > using original merge commit as base"
> > 
> > And that is also wrong, as I had proved already! Only Buga's addition
> > made it robust against dropping/modifying commits, and that addition
> > also makes it more complicated.
> 
> No, this is actually right, that sentence nicely describing _how_ it 
> works.

Does it? Because that's exactly backwards from how Phillip's approach
works: it certainly does not use the original merge commit as base. It
uses the non-rebased merge parent as base, one at a time.

Now I am curious...

> That addition of mine was just including the correct merge base (being
> the original merge commit that we are "rebasing"), and that`s what
> Sergey is talking about.

Okay, render me still unconvinced that Sergey's approach is actually
correct.

> > > > - it is *very easy* to reason about, once it is pointed out that
> > > > rebases and merges result in the same trees.
> > >
> > > The original is as easy to reason about, if not easier, especially as
> > > recursive merge strategy is not being used there in new ways.
> > 
> > So do it. I still have to hear a single-sentence, clear and obvious
> > explanation why it works.

So the closest I got was the description with the *original merge commit*
as merge base, which I disagree with. It does not make sense to me.

Consecutive three-way merges between the original merge commit and the
merge parents (with the *original merge parents* as merge base,
respectively), still makes the most sense to me: it is a merge between the
amendmends to the merge commit and the changes introduced by rebasing the
merge parents.

I am now getting the sense as if Sergey's approach (with your, let's say,
"fix") is trying to apply too much, and by using the original merge commit
as merge base then tries to undo part of that.

> > > I honestly don't see any advantages of Phillip's method over the
> > > original, except personal preferences. At the same time, I have no
> > > objection of using it either, provided consistency check problem is
> > > solved there as well.
> > 
> > Okay, let me reiterate then, because I do not want this point to be
> > missed:
> > 
> > Phillip's method is essentially merging the new tips into the original
> > merge, pretending that the new tips were not rebased but merged into
> > upstream.
> > 
> > So it exploits the duality of the rebase and merge operation, which both
> > result in identical trees (potentially after resolving merge conflicts).
> > 
> > I cannot think of any such interpretation for your proposal augmented by
> > Buga's fix-ups. And I haven't heard any such interpretation from your
> > side, either.
> 
> Ok here it goes (I might be still wrong, but please bare with me).
> 
> What Sergey originally described also uses the "duality of the rebase 
> and merge operation", too ;) Just in a bit different way (and might 
> be a more straightforward one?).

I will be the judge whether it looks more straight-forward to me. :-)

> Here`s a starting point, two commits A and B, merged into M:
> 
> (3) ---A
>         \
>          M
>         /
>     ---B
> 
> 
> According the "patch theory"[1] (which might not be too popular 
> around here, but should serve the purpose for what I`m trying to 
> explain),

I think that the patch theory is not usually quoted here because

1) originally, Darcs had this snake oil way of (over-)selling its theory
   as having "roots in quantum mechanics" [*1*] at the time Git took off,
   and

2) it does not really have a good concept of rebasing, even if it should
   be theoretically possible to integrate that into the "theory of
   patches".

> each merge commit can be "transformed" to two non-merge commits, one on
> top of each of the merge parents, where new commit brings its original
> merge parent commit tree to the state of the merge commit tree:
> 
> (4) ---A---U1
> 
> 
> 
>     ---B---U2

You get the same result if you stick to regular graph theory, of course.
All you need to do is to interpret the directed vertices between nodes as
a patch & parent relationship. Simple.

> Now, we have two new commits, U1 and U2, each having the same tree as 
> previous merge commit M, but representing changes in regards to 
> specific parents - and this is essentially what Sergey`s original 
> approach was using (whether he knew it, or not).
> 
> When it comes to rebasing, it`s pretty simple, too. As this:
> 
> (5) ---X1---o---o---o---o---o---X2 (master)
>        |\
>        | A1---A2---A3
>        |             \
>        |              M
>        |             /
>        \-B1---B2---B3
> 
> ... actually equals this:
> 
> (6) ---X1---o---o---o---o---o---X2 (master)
>        |\
>        | A1---A2---A3---U1
>        |
>        |
>        |
>        \-B1---B2---B3---U2
> 
> ... where trees of M, U1 and U2 are same,

Okay, so you basically duplicated the merge commit and dropped its
semantics as a merge commit. That is a very big difference to Phillip's
approach already.

It opens the door to ambiguities, as we will see later.

> and we can use the regular rebase semantics and rebase it to this:
> 
> (7) ---X1---o---o---o---o---o---X2 (master)
>                                 |\
>                                 | A1'--A2'--A3'--U1'
>                                 |
>                                 |
>                                 |
>                                 \-B1'--B2'--B3'--U2'
> 
> ... which is essentially this again:
> 
> (8) ---X1---o---o---o---o---o---X2 (master)
>                                 |\
>                                 | A1'--A2'--A3'
>                                 |            \
>                                 |             M'
>                                 |            /
>                                 \-B1'--B2'--B3'
> 
> ... where it is still true that trees of U1', U2' and M' are still 
> the same. So we managed to rebase a merge commit without ever doing a 
> merge :) (note that, practically, we _can_ finally even merge U1' and 
> U2' to produce M', it shouldn`t really matter as all the trees are 
> the same, so merge will be a no-op)

U1' and U2' do not have the same tree, though *especially* when the user
did not edit the todo list to insert/modify/drop/reorder commits.

This violation of expectations is of course caused by "duplicating the
merge commit" into U1 and U2.

But let's continue.

> But, as we saw (what you`ve explained), this doesn`t really work in 
> case one of the sides of the merge gets "disbalanced" (so to say), 
> like dropping a commit (which could also happen non-interactively, 
> where a commit has been cherry-picked to a different branch, but
> previously obsoleted by `-s ours` merge).

Precisely. A *very* important counter-argument to this approach so far.

> As observed, dropped commit could still wrongly get into final merge 
> commit tree (or cherry-picked commit wrongly not get there), due to 
> the nature of those rebased U1 and U2 temporary commits to hold all 
> the differences in regards to their specific merge commit parent.

The reason for this, of course, is that either U1's or U2's diff will show
those differences, *and we still try to rebase them even if the user
already dropped them*.

But let's continue.

> A natural improvement to original idea which Sergey eventually came 
> up with after my findings (which you now ended up calling a hack, even, 
> but I would respectfully disagree), is to use original merge commit M 
> as a merge base for final merge of U1' and U2' - and here is why it 
> works, too, and why I wouldn`t consider it a hack, but a proper (and 
> a solid) solution.
> 
> Merge commit M is what we are rebasing, so we should have a way to 
> somehow learn from it, alongside U1 and U2 temporary commits - and 
> that is what using original merge commit M as a base does for us. It 
> helps us spot any "disbalances" that happened in comparison to original 
> merge parent trees, which is exactly what we`re interested in.

... except that it gets the direction wrong. Rather than trying to *avoid*
rebasing possibly dropped changes, it tries to kind of "undo" them by
using a merge base that does not really make sense (unless you think of it
as a "revert").

It would make sense if M could interpreted as a branch point. But it
cannot, as we specifically did *not* continue to develop the merge parents
from that merge commit.

Instead, what we did was to branch off of the original branch point X1.

Reframing the rebase of a sub-branch (X1..A3) as merge with upstream,
however, we can interpret M and A3' as revisions we want to merge, with A3
as the merge base.

(You can think of it in terms of the "theory of patches" thusly: if X1..A3
is represented by patch K, X1..X2 by patch L, and X2..A3' by K', then what
we want to merge into M is K^(-1).L.K', which is precisely what A3..A3'
translates to.)

You can also think of it as diverging changes going from A3: one direction
was to merge (resulting in the commit M), the other direction was to
rebase onto X2 (resulting in A3'), and a 3-way merge M <- A3 -> A3' will
reconcile those changes (and you will want to repeat with B3/B3', too).

Let's put that into the context of your example: instead of introducing U1
and U2, we introduce V1 and V2 right away, as temporary *merge* commits,
where the tree of V1 is identical to the one of A3', and the tree of V2
to that of B3'.

 ---X1---o---o---o---o---o---X2 (master)
    |                        |\
    |                        | A1'--A2'--A3'--V1
    |\                       |               /
    | -A1---A2---A3----------+---------------
    |              \         |
    |               M        \-B1'--B2'--B3'--V2
    |              /                         /
     \-B1---B2---B3--------------------------

Note: the *really* important difference is that these temporary commits
are based on the *rebased* history rather than the *unrebased* history.

Second note: this is very related to Git for Windows' original strategy of
coping with the non-fast-forwarding nature of rebases: after rebasing the
Windows-specific patches on top of core Git, we merged (with `-s ours`)
the unrebased history. This 1) makes it fast-forwardable, and 2) still
rebases the patches [*2*].

Third note: my favorite mental model is still the duality of rebasing and
merging, in which case V1 and V2 would not have A3' and B3' as first
parents, but X2.

Phillip's strategy is to merge M with V1 and V2.

This translates to "merge the amendments of the merge commit M with the
changes introduced by rebasing its merge parents".

The really cute part about this is that (in contrast to using U1' and
U2'), we do not merge the amendments of the merge commit multiple times,
but exactly once. And therefore, we do not need to "undo" them by using
the original merge commit as merge base, either (which would introduce
many more opportunities for merge conflicts to creep in, oftentimes
unnecessary conflicts to begin with).

> In ideal case (as per "patch theory"[1]), final merge of rebased U1' 
> and U2' with original merge commit M as a base would be rather simple, 
> too (not to say pointless again), as both U1' and U2' would have same 
> changes in comparison to M, namely all the changes from commit we are 
> rebasing from (X1 above) to commit we are rebasing to (X2 above).
> 
> But in a more complex case like this:
> 
> (9) ---X1---B2'---o---o---o---o---X2 (master)
>                                   |\
>                                   | A12--A2'---B3'
>                                   |             \
>                                   |              M'
>                                   |             /
>                                   \-B1'--B3'---B4
> 
> ..., being what we are ultimately interested in, it helps us notice 
> all kind of changes on our rebased merge parent branches, and act 
> accordingly (as shown by my previously posted test script[2]).

To use the "theory of patches" to explain why Phillip's approach is so
much more appealing: in Sergey's approach, we will rebase U1 (which is
"sort of" B1.B2.B3 in the "theory of patches"). If the cherry-pick of B2'
caused merge conflicts that had to be resolved, then these merge conflicts
will have to be resolved *again* when rebasing U1 (because B2 is *part of*
U1). And of course they will have to be resolved *again* when merging U1'
with U2'.

In short: Phillip's approach is a short-cut that avoids unnecessary merge
conflicts because it avoids rebasing changes that would need to be undone
right away anyway.

> All this said (and hoping anyone is still reading this), to shed some 
> light on what I meant by "favoring Sergey`s approach in general, but 
> _implemented_ through what Phillip described".
> 
> I think we should use temporary commits U1 and U2, being a sound 
> approach backed up by the "patch theory"[1], as it helps us notice 
> any "disbalances" of the rebased merge commit parents trees (so we 
> can stop for user inspection), finally merging them with original 
> merge commit as a base, in order to spot additional changes on trees 
> of the merge commit parents we are rebasing.

In Phillip's approach, we do not need to rebase the amendments of the
merge commit M twice (or even more times, for octopus merges). Therefore,
there is no opportunity for these imbalances.

> But, the merging steps themselves, backed up by a need to stop for 
> conflict resolution as soon as one happens, should be performed 
> _iteratively_, like Phillip showed us... I would think :)

From a user interface perspective, this is a bad idea: you would now have
to communicate to the user *where* in the process they are.

And for that you would have to explain that process to them. Including
"theory of patches" and all.

Taking me as a prime example, you now know how tedious and impractical
that would be.

> And, for example, that would do wonders when we introduce completely 
> new branch during an interactive rebase, too, for example:
> 
> (10) ---X1---B2'---o---o---o---o---X2 (master)
>         |\                        /|\
>         | A1---A2---A3---U1       || A12--A2'---B3'---U1'
>         |             \           ||             \
>         |              M          ||              M'
>         |             /           ||             /|
>         \-B1---B2---B3---U2       |\---B3'---B4-/-|---U2'
>                                   |               |
>                                   \-----B1'-------/
> 
> 
> In this situation, we would merge all temporary Ux commits using 
> original merge M as a merge base, and then merge _that_ resulting 
> tree with B1' (being a newly introduced merge commit parent), using 
> whatever merge base is most appropriate between the two (in this 
> case, X2).

The semantics of octopus merges are very different from regular recursive
merges. I am not sure that we want to go there in this discussion...

If, on the other hand, you do not try to turn M from a regular 2-parent
merge commit into an octopus merge during an interactive rebase, but
instead split the B branch into two branches *before* merging the result
into the rebased merge commit, we are in the same square as
reordering/dropping/inserting/modifying patches: to neither of the
presented strategies would it matter what kind of branch topology the
merge parents have.

For the record: I am still not convinced that Phillip's and Sergey's
approach are equivalent, even in terms of the "theory of patches". But if
they are, then Phillip's version is a shorter version that avoids applying
changes just to revert them right away. And in a setting where each patch
can cause merge conflicts (as the interactive rebase is), the less changes
you have to apply, the better.

Ciao,
Dscho

> [1] https://en.wikibooks.org/wiki/Understanding_Darcs/Patch_theory

Footnote *1*: https://web.archive.org/web/20050511033324/http://darcs.net/
And it must be said: the "theory of patches" are not rooted in quantum
mechanics. They might be inspired by Darc's inventor being more familiar
with it than with fundamental algebra, for sure. The "theory of patches"
is nothing else than an algebra on graph vertices, though.

Footnote *2*: We called this strategy the rebasing merge. We replaced it
by the opposite strategy ("merging rebase", i.e. starting with the `git
merge -s ours <unrebased>` and *then* applying the rebased patches)
because the latter makes it really obvious where the Windows-specific
patches *start*.

Of course, you could draw the diagram very easily also using the merging
rebase, the conclusion would still be the same.
