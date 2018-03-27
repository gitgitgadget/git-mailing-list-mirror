Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0141F404
	for <e@80x24.org>; Tue, 27 Mar 2018 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752619AbeC0Nt2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 09:49:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:42853 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbeC0Nt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 09:49:27 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQMBU-1f8Tw303p6-00TpaQ; Tue, 27
 Mar 2018 15:49:19 +0200
Date:   Tue, 27 Mar 2018 15:49:17 +0200 (DST)
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
In-Reply-To: <87woxyf4lk.fsf@javad.com>
Message-ID: <nycvar.QRO.7.76.6.1803271536020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
 <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net>
 <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com> <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com> <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com> <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87woxyf4lk.fsf@javad.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9Kz108PRr3Dp9ljO07hpXVzvYpd57emqvxyu4IBcPN7Ib0xDupP
 65XvnosbsS8TkRphNG2S5WkpntgzrVTx6LZFAfRsCgGrjcYIrIgK6Mu+zwgbFWYVSIwlQWV
 XCXbQSzBPZdsTGUEu6HraKSRWYjmNqhVVVnlE414Ss5caEeV3Z+rk1BnYK5v2xfDnG4SA42
 0acbjT+x9veNFDxSWYjXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3gS9yvokIUA=:TVDO/Tu1AmC37i5BXoWYNy
 B89bolcMTOH8BQHFhV+nFwergba4+O9PFxChMHB9ZK7/JvnF8nPdxDqXRoGOQ+A82DRSElxXk
 tMXNe+fsd3VcBWbM0pBcQxzM3GxiD3jEP19hpRvVlP5Su1CL0sM7nkc79PWOMvjwmL9cq7CC2
 wJy+HQvOMJ1rK2KAofRQCbXb7xz95edkTKoV95SOj4nR511BSLW+F5caDS6VX0EDvm/ssiW9C
 NctqfIQBxImuBhnJ2IJFjaRxIvA6E0IFmmm1+wINOWTR0t0dDj/BmdEfMCQgmX77ejAqGXhD2
 h2YSOlRNSrsjGknXCzwIMdyOYZL3YXo8MNHp2n4obYVhqQ7TP5tzYd18DkNsBb9ilCmfyzE+0
 3unDt2jnGw8IkivWYph7EApp4BuiG9iSfMQPqERdeceV/b6OI4TC3U1kBd5y9PemBl2Mf3FTD
 NZ8nuk0juGxQ4mg3BwwmG6/lLplHbu3ZsB2UOG3W2nXyup9csORcIuzEhz4weJVj0cOjcwpA+
 4+jSa7QVnAkRajcVSw7qjhwmTtCAkwryHtlnDk16ZejQNqWeKfXwIa8v749vW1137DxSHBZty
 Eb5A4CjjOrazorQFcE/mouNgMHDCOWmo4iHWlPlxrsS5gZPvf8Pt7g0o8V8hR973SvDqrjLm/
 MtpuxPbSXHY2LYogW+Irb5G1QZ3xvj+Pdbyq/5Zlcyf3ckCGHqsZTSA3UeX7RPEbxO2FL6BDr
 uZ5PJijQJ0NV7gyG3uKr4A588igJwZl7JjoyKAgzSL/fDsirV/1i/Ij0w8abxwFrmNfM4bnX6
 yQ0Z9QD2J4Lp8hEiMTTBrXH66wUtEGTm2NKXYeHWFMZF6qhYXD+aBsKf8OOkvbDFAzFCUg4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Tue, 27 Mar 2018, Sergey Organov wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 13 Mar 2018, Igor Djordjevic wrote:
> >
> >> On 12/03/2018 11:46, Johannes Schindelin wrote:
> >> > 
> >> > > Sometimes one just needs to read the manual, and I don`t really
> >> > > think this is a ton complicated, but just something we didn`t
> >> > > really have before (real merge rebasing), so it requires a moment
> >> > > to grasp the concept.
> >> > 
> >> > If that were the case, we would not keep getting bug reports about
> >> > --preserve-merges failing to reorder patches.
> >> 
> >> Not sure where that is heading to, but what I`m arguing about is that
> >> introducing new commands and concepts (`merge`, and with `-R`) just
> >> makes the situation even worse (more stuff to grasp).
> >
> > The problem with re-using `pick` is that its concept does not apply to
> > merges. The cherry-pick of a non-merge commit is well-defined: the
> > current HEAD is implicitly chosen as the cherry-picked commit's
> > (single) parent commit. There is no ambiguity here.
> >
> > But for merge commits, we need to specify the parent commits (apart
> > from the first one) *explicitly*. There was no need for that in the
> > `pick` command, nor in the concept of a cherry-pick.
> >
> >> Reusing existing concepts where possible doesn`t have this problem.
> >
> > Existing concepts are great. As long as they fit the requirements of
> > the new scenarios. In this case, `pick` does *not* fit the requirement
> > of "rebase a merge commit".
> 
> It does, provided you use suitable syntax.

You know what `pick` would also do, provided you use suitable syntax? Pick
your nose.

Don't blame me for this ridiculous turn the discussion took.

Of course, using the suitable syntax you can do anything. Unless there is
*already* a syntax and you cannot break it for backwards-compatibility
reasons, as is the case here.

But I'll stop here. Even my account how there are conceptual differences
between the changes in merge vs non-merge commits (the non-merge commit
*introduces* changes, the merge commit *reconciles existing* changes)
seems to fly by without convincing you.

I use rebase every day. I use the Git garden shears every week. If you do
not trust my experience with these things, nothing will convince you. You
are just stuck with your pre-existing opinion.

> > If you really want to force the `pick` concept onto the use case where
> > you need to "reapply" merges, then the closest you get really is
> > Sergey's idea, which I came to reject when considering its practical
> > implications.
> 
> Which one, and what are the implications that are bad, I wonder?

The strategy described in RFC v2, which does too much work, forces the
user to potentially address the same merge conflicts multiple times, and
worst of all: risks merge conflicts with changes the user *already*
dropped.

> > Even so, you would have to make the `pick` command more complicated to
> > support merge commits. And whatever you would do to extend the `pick`
> > command would *not make any sense* to the current use case of the `pick`
> > command.
> 
> It would rather make a lot of sense. Please don't use 'merge' to pick
> commits, merge ones or not!

It would rather make a lot of sense. If you completely ignored everything
I said about preserve-merges. If you ignored what I said about problems
moving regular `pick` lines across merge commits. If you ignored all the
experience I have with Git garden shears and that I tried really patiently
for an impatient man to impart on you.

> > The real problem, of course, is that a non-merge commit, when viewed
> > from the perspective of the changes it introduced, is a very different
> > beast than a merge commit: it does not need to reconcile changes,
> > ever, because there is really only one "patch" to one revision. That
> > is very different from a merge commit, whose changes can even disagree
> > with one another (and in fact be resolved with changes disagreeing
> > *yet again*)!
> 
> You'd still 'pick' it though, not 'merge'. You don't merge "merge
> commit", it makes no sense. It only makes perfect sense when you get rid
> of original "merge commit" and re-merge from scratch, as you were doing
> till now.

No, you merge "merge head". And you use "merge commit"'s commit message.
*That* makes sense.

Picking a merge commit? Not so. What do you merge? The original merge
commit's second parent? Or a rebased version thereof? What if that commit
has been `pick`ed *twice*?

No, you can repeat it all you want, it still does not make sense. Now that
I think of the possiblity of picking the original parents multiple times,
it does not even make theoretical sense.

> > The implementation detail is, of course, that I will introduce this with
> > the technically-simpler strategy: always recreating merge commits with the
> > recursive strategy. A follow-up patch series will add support for rebasing
> > merge commits, and then use it by default.
> 
> Switching to use it by default would be backward incompatible again? Yet
> another option to obsolete? Sigh. 

Oh wow.

Backwards compatibility of a feature that existed only as a topic branch
in `next` before being worked on more? Any other splendid ideas?

And what's that about another option to obsolete? Who said that I would
obsolete any newly-introduced option?

I would introduce either --recreate-merges or --rebase-merges, and then
just stick with it.

I guess it is my turn to sigh.

Ciao,
Johannes
