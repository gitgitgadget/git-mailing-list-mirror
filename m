Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64DDD1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 12:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeCZMDd (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 08:03:33 -0400
Received: from mout.gmx.net ([212.227.17.20]:45109 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751335AbeCZMDa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 08:03:30 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdnN3-1fClbK0YJx-00PesB; Mon, 26
 Mar 2018 14:03:23 +0200
Date:   Mon, 26 Mar 2018 14:03:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>, phillip.wood@dunelm.org.uk,
        Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <39327070-f13a-f7e5-6c8c-cd204530f051@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803261351070.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net> <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com>
 <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net> <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <754e2735-1288-9a8d-c8bd-ab39cf733812@gmail.com> <nycvar.QRO.7.76.6.1803070810550.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <c5a5c2cc-6a11-440f-5b9b-964ae1ca07dd@talktalk.net> <483674f8-4097-a374-c8f3-cf56cbb92042@talktalk.net> <29bc6661-1d78-8f89-194e-1dcc9d88c34e@gmail.com> <nycvar.QRO.7.76.6.1803111256410.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <f4e6237a-84dc-1aa8-150d-041806e2416e@gmail.com> <nycvar.QRO.7.76.6.1803121122390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <87h8plh2qd.fsf@javad.com> <39327070-f13a-f7e5-6c8c-cd204530f051@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:K2cBZWSCCIT0rmobyOPUStK3+V+Yzh/EkahRb2ngcXbO8pqN7JZ
 L7rbqAWOY5z5tjrHQJGc8TDCr5dsQ3ScBzVJtTVG73X0AV55xhvsQ9cUtIf6EhUHSvcOGAD
 ErMd4+WlRnIy6wKaaux2nTSu1jeuI2dBXgjNhEVbJykG8v5aLiXzWLrG33byqBCZIzh5jll
 lzcfTeYJtgPloQP6I3QUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rNKgyuJoo/8=:bCEdt4/gDrBNvACyWlNF+i
 YfE4UYn0ke1UBMF8RGjhhhFqlAAc1g7zLOt0nsfCQHb9eHe2KJs0PIlH3GIcLYUdSn0Aruuys
 agly+hwekG5Ey/bGYg+NiUVc3AHx8jaQ+YafDakUQk/sAotMooJ85NvUfUutiMME9i/Y28V5p
 OcrCfRdxB/j/STf5BWhVGOySAPbobO5q2WvKZqYrzi7TD9GweDVrDgn38eNhtmBuQXVeuAN92
 nqezpzFOh8w/zZhzhkrD9SUFmHIi4MDwFKTP8RIBG/KHLVfp7A1M4s3GC2bOLpdS0uQ3lMGzA
 6pQoSU6D4jK05XlpexyDHYX1+rvpnVpSIggzhafc4T5eDQ299tY0K1RpyzRd96I0EkPsHKkd4
 zPEebPICRQDC0On7vNl2gngPv666qwsS4UGQq9GSMkHpGFPYg7yNcG17Rtgyoxtp+KuxJ4v7P
 Tbvr+Hx2q9yNgMxBFVCQy8a0nQyHCkPFI8HLt/CFHsPbKjdBeUSaLmlcs873w1eh4QrJ3J/cZ
 b4gGn/MlIMnbewxiFusY30NimvaEonIiLzMOGG7o7EFjpZLG5nwcNA/xOamXZ9Mfd0tdPvIUP
 PPo9z/wI5Na39iuGSdwelMubh7qngXB+870SR+KSE6yt1VQ52bLrdpPvenQ5KrwPCVJdmMBYM
 xlnJlTwuFZFUVrlYsdMxYRoRIXf9xS8WtLzi6nL3bBRLJly/9k7hMVTDgYzLN7J02D7wKI7C4
 VKwNxMRAkwtjcxrRo1wfXPOL/+frxxe/D/JKIdnjUGhATJE40jTWCQLYa36EQs1DK4ingaV9/
 D0BQ1DxnfXYYUTeBpa12HbeeUf88OG9RaRmtrUFO1lWKlfd1xsqZ+70Ah6hklJFBmzaMCfR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Buga,

On Tue, 13 Mar 2018, Igor Djordjevic wrote:

> On 12/03/2018 13:56, Sergey Organov wrote:
> > 
> > > > I agree with both of you that `pick <merge-commit>` is inflexible
> > > > (not to say just plain wrong), but I never thought about it like
> > > > that.
> > > >
> > > > If we are to extract further mentioned explicit old:new merge
> > > > parameter mapping to a separate discussion point, what we`re
> > > > eventually left with is just replacing this:
> > > >
> > > > 	merge -R -C <original--merge-commit> <merge-head>
> > > >
> > > > ... with this:
> > > >
> > > > 	pick <original--merge-commit> <merge-head>
> > >
> > > I see where you are coming from.
> > >
> > > I also see where users will be coming from. Reading a todo list in
> > > the editor is as much documentation as it is a "program to execute".
> > > And I am afraid that reading a command without even mentioning the
> > > term "merge" once is pretty misleading in this setting.
> > >
> > > And even from the theoretical point of view: cherry-picking
> > > non-merge commits is *so much different* from "rebasing merge
> > > commits" as discussed here, so much so that using the same command
> > > would be even more misleading.
> > 
> > This last statement is plain wrong when applied to the method in the
> > [RFC] you are replying to.

That is only because the RFC seems to go out of its way to break down a
single merge commit into as many commits as there are merge commit
parents.

This is a pretty convoluted way to think about it: if you have three
parent commits, for example, that way of thinking would introduce three
intermediate commits, one with the changes of parent 2 & 3 combined, one
with the changes of parent 1 & 3 combined, and one with the changes of
parent 1 & 2 combined.

To rebase those commits, you essentially have to rebase *every parent's
changes twice*.

It gets worse with merge commits that have 4 parents. In that case, you
have to rebase every parent's changes *three times*.

And so on.

> > Using the method in [RFC], "cherry-pick non-merge" is nothing more or
> > less than reduced version of generic "cherry-pick merge", exactly as
> > it should be.

I really get the impression that you reject Phillip's proposal on the
ground of not being yours. In other words, the purpose of this here
argument is to praise one proposal because of its heritage, rather than
trying to come up with the best solution.

On that basis, I will go with the proposal that is clearly the simplest
and does the job and gets away with avoiding unnecessary work.

> > Or, in other words, "cherry-pick merge" is generalization of
> > "cherry-pick non-merge" to multiple parents.
> 
> I think Sergey does have a point here, his approach showing it.

His approach is showing that he wants to shoehorn the "rebase a merge
commit" idea into a form where you can cherry-pick *something*.

It does not have to make sense. And to me, it really does not.

> Phillip`s simplification might be further from it, though, but we`re 
> talking implementation again - important mental model should just be 
> "rebasing a commit" (merge or non-merge), how we`re doing it is 
> irrelevant for the user, the point (goal) is the same.

Except that Phillip's simplification is not a simplification. It comes
from a different point of view: trying to reconcile the diverging changes.

Phillip's is a true generalization of the "rebase vs merge" story: it is
no longer about merging, or about rebasing, but about reconciling
divergent commit histories, with whatever tool is appropriate.

Ciao,
Dscho
