Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9350C1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 13:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeC0Nfs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 09:35:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:44381 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752279AbeC0Nfq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 09:35:46 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MO7ee-1exXVn0NNc-005XVN; Tue, 27
 Mar 2018 15:35:39 +0200
Date:   Tue, 27 Mar 2018 15:35:38 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Sergey Organov <sorganov@gmail.com>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <87muyugl60.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803271456050.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net>
 <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com> <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com> <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87h8plh2qd.fsf@javad.com> <39327070-f13a-f7e5-6c8c-cd204530f051@gmail.com> <nycvar.QRO.7.76.6.1803261351070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87muyugl60.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uGNzZoTv3bMIvs1UPcGVlBUu3kAcOLZYnSeBSXRvPqt+4lGSQIf
 lxd2tqypbTzu3rLLVghtZhN2q/TeBr4QiAf4rNk0pe8LDxp4bdwBv62e1bi2tDML2UP8CqQ
 glCJqSWfWQsXeSwNcD3L3d1xxjDBsru4JdCR1phOCkxFpXCPa0sTNuj1Ezpps4TkXIFlXfr
 6TJC4XCl9Vg47dIOfcBMA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CUlDooBxYtA=:accdMi4GrNsDb36RVLXzbR
 qr4R7yLUdWowhq627mkbp4Lt2xOytumOyCOzWOW1XF4BY53+3+XnKSgpGoZWp9Q8GGxYkdNyk
 Uo38lYJvQYcSDVRLurqIg0ZAd5i4Nuw/8V4oWA72i2F8722FSuRGd7I0sRda4UqWwbN/bJHfZ
 0mjs4uJuoXjvwAjwKScUE4M5sibPKHjQYfsz0T7RKXyhPs7f2I3159bb/teFx0mLpS+g8RHmn
 nC4rQJ99H+IvC0L/dPTmHIWR14/A7H1evdVhPo6eJBrQ7A8T/RZkysWPZ4gitcaQokSND+PV1
 EtI7M2ei/IVhPDmMEjBWq1EFKUpSAALtrNyJfmU4ZE/FFjcpNu7BNW3k2cFc5wC2O+S2uTYAp
 m9WyKnWMal972X7oXJkY8V4w7B9KlT08JG0D1v8Lav5lD9mwkfVsfUNMpmc5SdCcXRq+PEDei
 99TvClvsanW7PynY3MyCqpi9VhXkxSGAq+shhG2xwKdc8kW/8RRAcusxdOJFig6JP0W277KCx
 Uwla46J/2zbVN/MPMXlxl+OaXm6yI1RtGjw+AvCLuxunDGTQjySmNkW+LPvuFjd9A0mwY4Mnq
 Bh8RnK9zvD0VZus4/EDIQ0R4cT1sdELVNO0HjKTPoy9WnzPA7lEHV0BPuIvTD7YCN7PLcE/tD
 4wae97sCcZeBVbrYkO51tW4ACcZItk0Llpfe0ja0RlF+kHmRRy1hUn+fW9kTTbT6MCkMcWjyj
 hrpjLDKo8n+QN4e6oTWpbOaC97/KOOdlpENjRbzAY63Q5J9aYuMlgdzp6G3948+xUPPNwJoed
 MhUbwMVIMgn4CPDpyyR84LKQ0TTbvqkHDx2c2OOAvCs4h/4E5yk2Wf8ogaMT9YDLlgVvIlk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 27 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > On Tue, 13 Mar 2018, Igor Djordjevic wrote:
> >
> >> On 12/03/2018 13:56, Sergey Organov wrote:
> >> > 
> >> > > > I agree with both of you that `pick <merge-commit>` is inflexible
> >> > > > (not to say just plain wrong), but I never thought about it like
> >> > > > that.
> >> > > >
> >> > > > If we are to extract further mentioned explicit old:new merge
> >> > > > parameter mapping to a separate discussion point, what we`re
> >> > > > eventually left with is just replacing this:
> >> > > >
> >> > > > 	merge -R -C <original--merge-commit> <merge-head>
> >> > > >
> >> > > > ... with this:
> >> > > >
> >> > > > 	pick <original--merge-commit> <merge-head>
> >> > >
> >> > > I see where you are coming from.
> >> > >
> >> > > I also see where users will be coming from. Reading a todo list in
> >> > > the editor is as much documentation as it is a "program to execute".
> >> > > And I am afraid that reading a command without even mentioning the
> >> > > term "merge" once is pretty misleading in this setting.
> >> > >
> >> > > And even from the theoretical point of view: cherry-picking
> >> > > non-merge commits is *so much different* from "rebasing merge
> >> > > commits" as discussed here, so much so that using the same command
> >> > > would be even more misleading.
> >> > 
> >> > This last statement is plain wrong when applied to the method in the
> >> > [RFC] you are replying to.
> >
> > That is only because the RFC seems to go out of its way to break down a
> > single merge commit into as many commits as there are merge commit
> > parents.
> 
> Complex entity is being split for ease of reasoning. People tend to use
> this often.

Sure. Divide and conquer. Not duplicate and complicate, though.

> > This is a pretty convoluted way to think about it: if you have three
> > parent commits, for example, that way of thinking would introduce three
> > intermediate commits, one with the changes of parent 2 & 3 combined, one
> > with the changes of parent 1 & 3 combined, and one with the changes of
> > parent 1 & 2 combined.
> 
> No.

Sorry. This is unacceptable. If you disagree, sure, you are free to do
that. If you want to contribute to a fruitful discussion, just saying "No"
without explaining why you *think* that my statement is wrong is just...
unconstructive.

> > To rebase those commits, you essentially have to rebase *every
> > parent's changes twice*.
> 
> No.

Same here.

> > It gets worse with merge commits that have 4 parents. In that case, you
> > have to rebase every parent's changes *three times*.
> 
> Sorry, the [RFC] has nothing of the above. Once again, it's still just
> as simple is: rebase every side of the merge then merge the results
> using the original merge commit as a merge base.
> 
> And if you can't or don't want to grok the explanation in the RFC, just
> forget the explanation, no problem.

Your RFC talks about U1 and U2, for the two merge parents.

Obviously this strategy can be generalized to n parents. I thought you had
thought of that and simply did not bother to talk about it.

Sorry, my mistake. I should not assume so much.

> > And so on.
> >
> >> > Using the method in [RFC], "cherry-pick non-merge" is nothing more or
> >> > less than reduced version of generic "cherry-pick merge", exactly as
> >> > it should be.
> >
> > I really get the impression that you reject Phillip's proposal on the
> > ground of not being yours. In other words, the purpose of this here
> > argument is to praise one proposal because of its heritage, rather than
> > trying to come up with the best solution.
> 
> No. As the discussion evolved, I inclined to conclusion that modified
> Phillip's algorithm is actually better suited for the implementation
> [1].

Again a link.

If that's what you are looking for, I will throw a hundred links your way
and see how constructive a discussion you find that.

> > On that basis, I will go with the proposal that is clearly the simplest
> > and does the job and gets away with avoiding unnecessary work.
> 
> These algorithms are actually the same one, as has already been shown
> elsewhere in the discussion.

I disproved that already. My example showed that instead of reconciling
the diverging changes starting from the original merge parents, RFC v2
tries to rebase those parents first, and then use the original merge
commit as base of "diverging changes" that never started from that
original merge commit.

Essentially, where Phillip's strategy imitates a cherry-pick's 3-way
merge, your strategy tries to rebase the merge tips independently from the
user (who already rebased them, thank you very much), and then runs a
*revert*: while a cherry-pick uses the picked commit's parent as merge
base, a revert uses the to-be-reverted commit itself as merge base.

In short: Phillip's strategy is only equivalent to yours if you ignore the
fact that you perform unnecessary work only to undo it in the end.

> Asymmetric incremental nature of the Phillip's one is apparently better
> suited for naturally asymmetrical way Git already handles merging. FYI,
> here is the latest proposal that came out of discussion [1]:

And another link.

> git-rebase-first-parent --onto A' M
> tree_U1'=$(git write-tree)
> git merge-recursive B -- $tree_U1' B'
> tree=$(git write-tree)
> M'=$(git log --pretty=%B -1 M | git commit-tree -pA' -pB')
> [ $conflicted_last_merge = "yes" ] ||
>   trees-match $tree_U1' $tree || 
>   stop-for-user-amendment

And a bunch of commands from which the reader is expected to deduce the
idea.

> >> > Or, in other words, "cherry-pick merge" is generalization of
> >> > "cherry-pick non-merge" to multiple parents.
> >> 
> >> I think Sergey does have a point here, his approach showing it.
> >
> > His approach is showing that he wants to shoehorn the "rebase a merge
> > commit" idea into a form where you can cherry-pick *something*.
> >
> > It does not have to make sense. And to me, it really does not.
> 
> Except that Phillip's one does exactly this as well, only in incremental
> manner, as shown in [1].

And yet another link.

> >> Phillip`s simplification might be further from it, though, but we`re 
> >> talking implementation again - important mental model should just be 
> >> "rebasing a commit" (merge or non-merge), how we`re doing it is 
> >> irrelevant for the user, the point (goal) is the same.
> >
> > Except that Phillip's simplification is not a simplification. It comes
> > from a different point of view: trying to reconcile the diverging
> > changes.
> 
> They are essentially the same as one easily converts to another and back
> [1].

Repeating this does not make it more true.

With your method, this branch structure:

- A - B
    \   \
      C - D

would be rebased by first cherry-picking B, then C, then doing it *again*
because you need to construct U1 (which is kind of C) and U2 (which is
kind of B) and rebase those, and if the user resolved merge conflicts
while rebasing B, those merge conflicts will have to be resolved *again*
when rebasing U2, and if the user dropped part of B, U2 will still have to
rebase them, and the final merge with the original D as merge base will
have to undo those changes.

Your strategy involves *a lot* more work, and *a lot* more opportunities
for merge conflicts, and it also allows for giving incongruent answers
to the question "what should the tree of the rebased merge commit look
like?".

> They will only bring different user experience in case of conflicts.

Oh yes, they do. The amount, to begin with.

> > Phillip's is a true generalization of the "rebase vs merge" story: it is
> > no longer about merging, or about rebasing, but about reconciling
> > divergent commit histories, with whatever tool is appropriate.
> 
> Whatever. They are essentially the same thing. The only difference is
> incremental vs parallel [1].

You know, if you promise to answer whatever questions I have, just simply
stop throwing around links. Answer my questions. To the point. Not
deflecting. This is getting ridiculous.

> [1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com/

I will allow myself the joke and answer the concerns you had in this mail
thusly:

https://public-inbox.org/git/nycvar.QRO.7.76.6.1803261405170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/

So that you cannot miss it: there is a really good, real-world example
showing why Phillip's strategy is so much more practical than yours,
proving that they are not equivalent (except in a very narrow, purely
theoretical sense that ignores the possibility of merge conflicts). Look
for "concrete example" in that mail.

Another most important thing from that mail is really, really important.
So I will stress it instead of expecting you to pick up on it, by
repeating it here:

	BTW this is the level of detail I would have wished your answers
	to my repeated questions for clarification of your RFC v2 to be.
	And that is what I expect in response to my valid questions in the
	future.

Instead, you chose to fling a link in my direction again.

And yes, I read your mail, and no, it does not clarify anything, or even
addresses my objections.

If you contest my understanding of your strategy (where I say that U1 is
essentially the changes of the *other* merged branch), you will have to do
a much better job at explaining yourself. "No" is definitely not adequate.

And don't promise to answer my questions if you plan only on throwing a
link at me. That is no good.

So to repeat my point (that you contested without any argument, by a rude
and totally unmeritedly terse "No"):

> > To rebase those commits, you essentially have to rebase *every
> > parent's changes twice*.
> 
> No.

In the parlance of your RFC v2, where you start with this history (which I
translated into the left-to-right notation that is used in pretty much all
of Git's own documentation about interactive rebases, which you apparently
either did not read, or chose *not* to imitate, creating yet another
unnecessary diversion):

- B1
     \
- B2 - M

You now insert U1 and U2 with trees identical to M:

- B1 - U1
          \
- B2 - U2 - M

So U1 is essentially B2 cherry-picked on top of B1, and U2 is essentially
B1 cherry-picked on top of B2.

These U1/U2 commits are now to be cherry-picked on top of the rebased B1'
and B2'. I spare you more diagrams, you get the idea.

Now, the changes in U1/U2 *are* the changes of the merge parents, that's
how they were constructed.

Since they repeat what B1 and B2 are about, and since B1'/B2' means they
are rebased, and since U1'/U2' are *also* rebased, but independently...

	...  you essentially have to rebase *every parent's changes twice*.

The answer "No" to this is... astonishing.

Ciao,
Johannes
