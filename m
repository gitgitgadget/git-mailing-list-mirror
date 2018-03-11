Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B821F404
	for <e@80x24.org>; Sun, 11 Mar 2018 12:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeCKMWt (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 08:22:49 -0400
Received: from mout.gmx.net ([212.227.15.19]:56079 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932126AbeCKMWs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Mar 2018 08:22:48 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LdZAI-1eDile3pj8-00ihkB; Sun, 11
 Mar 2018 13:22:41 +0100
Date:   Sun, 11 Mar 2018 13:22:44 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <230856e0-7056-6273-cdd2-2e9969927271@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803111315200.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com> <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
 <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com>
 <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com>
 <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <2749ce78-8917-c821-6116-0c8d67b5e16e@gmail.com> <230856e0-7056-6273-cdd2-2e9969927271@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QiVovH9ElPvRsCkIu4FeodjT54zab4E/KQrpoXb5fdE5V1kZKuA
 MayQVnSIoHwEEAKeZlgEqaWQ8RO0KS7CNQyfCC4jjFpQZ/76SNeUI5ReyO4AYzL+VEvY1jE
 DT69Jqlj+Q0Eq6wqR8uAzBC+ueuFZGLagPJY8r9WbDlgXd6TpyzpoLoVKZh3ld85VU0z/2v
 fMWz3y2amcLSjXAipuCng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bl3yCwbO9XI=:VW51PQ7TocZkR/nZbKerCN
 flTywNFvnfYM7VtXySe0PPePXs9uNJmnUUfgSv2DfviftJjfWqhx0qxaTx7+6UHCJz0KWKmWN
 4CAwESgPGSzMpQfFt6EPcllDuFI637gyEF4rTVDGPFYChKRBpxOZJAXya+viNZRdm4Od4WFF8
 eG7l9wf7xoGtcyu0OdKR0DvDWq1qKOqncqHvbyW6tQ0Tuzzw1VEFT8E91eZ8ztxuYlrub51aU
 0frS4SIvn0k621lj5uMk6wfE6gE0zfYrns90PY2FOFjvsojdRSCRqZbNhUPU1aiubhD1VAXlR
 jCWzcTYxxtgLJe73CoPgeVDxoZAWG01j+EM8B9kiq4ntWFLKYp/HAwcjEN5t8cpbWckDP8Ce/
 SI7Sa/Nr5FbHAwW1zulvIWPbcGkFr2XXX3b3hSib2eu1ZqmvCdc9zlwivYa4hT4L8mB94dnEB
 2wLhWp2F/WtGigwYb+pIU5OFFfzQjVNT0cjsqE5IIFfkY7bbepLuSfIIYbz2ltrY87a4LVy7p
 Vf9o63KxvnRThd59Skbe8dFjefAEGNsCDAFnNL9B/oIdwbLl76d202rp3453+ivl51WyFr0vC
 /4jjPZYDrcleV/96JqovdAVVrYCSivmNnYTgxGRkmpxnUXdMSr9yHMIxbAyhVWrRZiwUjVCJE
 Ofuuq1uLrndJsQEvg/+o+Y/72WQbNBWHia6BCU1r+o/+vuDLrX0E48/VCH7itUsAoKpqldx+W
 VVhkwjUTT3f5wW3tFiIuxvO0xbvpLciYfVTyYRBOOlwKMMG/pBqtgb4220DR+ZpLVobfO7KuN
 EiY7D9k7w3SMDFRbayQs/I7AGLGMbE/5bQdKJWB+6h4Z4xxI9xChkBQQ3bmycP81ucqaEjo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Thu, 8 Mar 2018, Igor Djordjevic wrote:

> On 08/03/2018 16:16, Igor Djordjevic wrote:
> > 
> > > Unless we reimplement the octopus merge (which works quite a bit
> > > differently from the "rebase merge commit" strategy, even if it is
> > > incremental, too), which has its own challenges: if there are merge
> > > conflicts before merging the last MERGE_HEAD, the octopus merge will exit
> > > with status 2, telling you "Should not be doing an octopus.". While we
> > > will want to keep merge conflict markers and continue with the "rebase the
> > > original merge commit" strategy.
> > >
> > > [...]
> > 
> > The thing is, in my opinion, as long as we are _rebasing_, you can`t 
> > pick any merge strategy, as it doesn`t really make much sense. If you 
> > do want a specific strategy, than that`s _recreating_ a merge, and it 
> > goes fine with what you already have for `--recreate-merges`.
> > 
> > On merge rebasing, the underlying strategy we decide to use is just an 
> > implementation detail, picking the one that works best (or the only 
> > one that works, even), user should have nothing to do with it.
> 
> Just to add, if not already assumable, that I think we should stop 
> and let user react on conflicts on each of the "rebase the original 
> commit" strategy steps (rebase first parent, rebase second parent... 
> merge parents).

I am not sure about that. Actually, I am pretty certain that we should
imitate the recursive merge, which "accumulates" merge conflicts and only
presents the final result, possibly with nested merge conflicts.

In practice, we see that rarely, and more often than not, in those cases
the user wants to re-do the merge differently, anyway.

In the scenario we discuss here, I would wager a bet that the user
encountering nested merge conflicts would most likely see that the rebase
tried to rebase a merge, then `git reset --hard` and re-do the merge
manually (i.e. *recreate* rather than *rebase*, most likely with
(non-nested) merge conflicts).

> I guess this stresses not using real "octopus merge" strategy even in 
> case where we`re rebasing octopus merge commit even more (and aligns 
> nicely with what you seem to expect already).

My mistake, I should have pointed you my implementation:

https://github.com/git/git/commit/d41a29ceb61ff445efd0f97a836f381de57c5a41

The full thicket of branches can be found here:

https://github.com/git/git/compare/master...dscho:sequencer-shears

I chose to make this an add-on patch after adding support for octopus
merges because it actually makes it easier to think about "rebase merge
commits" independently of the number of merge parents.

Ciao,
Dscho
