Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0833E1FAE2
	for <e@80x24.org>; Mon, 26 Mar 2018 13:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751204AbeCZNHn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:07:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:57321 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeCZNHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:07:42 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRo6b-1f7EIm3yEj-00Sxwe; Mon, 26
 Mar 2018 15:07:34 +0200
Date:   Mon, 26 Mar 2018 15:07:32 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     phillip.wood@dunelm.org.uk, Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803261455130.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <f3872fb9-01bc-b2f1-aee9-cfc0e4db77d6@gmail.com>
 <nycvar.QRO.7.76.6.1803111301340.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <b329bb98-f9d6-3d51-2513-465aad2fa37a@gmail.com> <nycvar.QRO.7.76.6.1803121142550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <243ca23d-77a9-4ae1-a120-de6c6b195cdc@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bJeFw7Bjp2rG3Af2OU6u8kQ71JVNmFBnYTa9JY2z59ZZ8I5HEfz
 +MH0AQsnKsitX3t1HHDeCP5gzlXQqQu4/Atjon8G8fa3VLc8z73TI1g5jWcgNM/A/1XDLv9
 4VkBi+y7UlZKs1k91sl9xstDLzhO/jXxQGoSXkzCgJPakI8spdqURKYyl3PHri8txOAlVsX
 egjkV9aeqt4RKhaVeCB7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mEnjZVzYf4o=:OT0Ozqhx94iToeOGfVLAtf
 t2WnL5qIh9C1bAwxmo2a0hNz1FuL3JOC2+E7JrU9o/DyKnZYHIwtrGqzw4zEuU2vIS/poMnRr
 OwPJ98XFcuqb7DSlwvisKu27OrmFR2xUOhl5EHII/D70/GvDguVvAkRehAfU23QKl+nSHgWYx
 4r0GP1KFOOd0GF7s0NQ75asChlYGVHRlmV6TPYEv9m6/D37jqWJJDy425ghuTG9o9oDF/6iO9
 X7UC5/C1MhTgls+mc8rtmbJqHd78SrnF1sPDPEWx2Bo0dYOL/H5pWfgmVlhY3laHwJoeefe4b
 jTVnaGG+XDKwt/1Yuh8UV9PPUrkFUIyCsRrwtNfTn6TNbamzM040j34wnjTtaon2qU7r99DR0
 x3wZikgtMIloF49Z9o+zWqcwbbSPKlUbqEknH1H5m5pMTLQV82jy6SUEeos8+Yx+F8VSimZO4
 SBtney/qeowboY/a0jz+g0wHrpn0yC3nKkCaa+OinaPju0yLgdtjoZQiDAwL/lTRhEiIIPqu3
 H6yn5L+eUzRD3msDS/GwlZjIOtIsjFgvkLYfZ+xTOqBzyykkvMbOGCH6T90CEHw7sZr02d0cv
 b2iPXK5JaoITReUSWeGrPBHD1MBiThtsoyLD+9Z0+vXBnitlNnrOa0MT34uyoSjnTnpd4fr3l
 f+k+QXyJboyQ1hQUenvAvNVt2g7ARU72FD5T1pv7yG9v3h2xvgrXJNLpup5Fpl+kk44sP7nc7
 5dh0s08yaClhZQdwumE3kwmSd0Z54pgcs+Lxib1k2ZxDGYYOwM609U2/Uygrq/XAH13E3xFa1
 +NaLDiIjWE0KcM8TBw52FXjQnHnw5+l+pGgoxKUa22ZmPf31DPUdFcHRd/ZGGjIGGOrTNRC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Tue, 13 Mar 2018, Igor Djordjevic wrote:

> On 12/03/2018 11:46, Johannes Schindelin wrote:
> > 
> > > Sometimes one just needs to read the manual, and I don`t really
> > > think this is a ton complicated, but just something we didn`t really
> > > have before (real merge rebasing), so it requires a moment to grasp
> > > the concept.
> > 
> > If that were the case, we would not keep getting bug reports about
> > --preserve-merges failing to reorder patches.
> 
> Not sure where that is heading to, but what I`m arguing about is that 
> introducing new commands and concepts (`merge`, and with `-R`) just 
> makes the situation even worse (more stuff to grasp).

The problem with re-using `pick` is that its concept does not apply to
merges. The cherry-pick of a non-merge commit is well-defined: the current
HEAD is implicitly chosen as the cherry-picked commit's (single) parent
commit. There is no ambiguity here.

But for merge commits, we need to specify the parent commits (apart from
the first one) *explicitly*. There was no need for that in the `pick`
command, nor in the concept of a cherry-pick.

> Reusing existing concepts where possible doesn`t have this problem.

Existing concepts are great. As long as they fit the requirements of the
new scenarios. In this case, `pick` does *not* fit the requirement of
"rebase a merge commit".

If you really want to force the `pick` concept onto the use case where you
need to "reapply" merges, then the closest you get really is Sergey's
idea, which I came to reject when considering its practical implications.

Even so, you would have to make the `pick` command more complicated to
support merge commits. And whatever you would do to extend the `pick`
command would *not make any sense* to the current use case of the `pick`
command.

The real problem, of course, is that a non-merge commit, when viewed from
the perspective of the changes it introduced, is a very different beast
than a merge commit: it does not need to reconcile changes, ever, because
there is really only one "patch" to one revision. That is very different
from a merge commit, whose changes can even disagree with one another (and
in fact be resolved with changes disagreeing *yet again*)!

> > > Saying in favor of `--rebase-merges`, you mean as a separate option,
> > > alongside `--recreate-merges` (once that series lands)?
> > 
> > No. I am against yet another option. The only reason I pollute the
> > option name space further with --recreate-merges is that it would be
> > confusing to users if the new mode was called --preserve-merges=v2
> > (but work *totally differently*).
> 
> I see. So I take you`re thinking about renaming `--recreate-merges` to
> `--rebase-merges` instead?

Thinking about it. Nothing will happen before v2.17.0 on that front,
though, because -- unlike you gentle people -- I have to focus on
stabilizing Git's code base now.

> That would seem sensible, too, I think, being the default usage mode in
> the first place. Being able to actually (re)create merges, too, once
> user goes interactive, would be "just" an additional (nice and powerful)
> feature on top of it.

The implementation detail is, of course, that I will introduce this with
the technically-simpler strategy: always recreating merge commits with the
recursive strategy. A follow-up patch series will add support for rebasing
merge commits, and then use it by default.

This latter part will need a lot of experimentation, though. That's why I
want the --recreate-merges patch series cooking in `next` first.

Ciao,
Dscho
