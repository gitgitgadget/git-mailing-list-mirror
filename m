Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792931F404
	for <e@80x24.org>; Tue,  6 Mar 2018 18:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeCFSMZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 13:12:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:49491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750817AbeCFSMX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 13:12:23 -0500
Received: from [10.59.3.43] ([77.210.250.197]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNf1y-1em64g45k2-007AjW; Tue, 06
 Mar 2018 19:12:17 +0100
Date:   Tue, 6 Mar 2018 19:12:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate
 solution(RoadClear)
In-Reply-To: <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1803061812090.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <87y3jtqdyg.fsf@javad.com> <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com> <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com> <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com> <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com> <87606hoflx.fsf@javad.com>
 <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com> <87a7vss6ax.fsf@javad.com> <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com> <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org> <1298a701-a860-a675-83d7-72f29e14cd2b@talktalk.net>
 <CA+P7+xpgChuvh_vsPktBkOEhF=MjJh1n_3jD0-n4d67j9kYqzw@mail.gmail.com> <ee809701-a6d8-157d-09cd-cebbf2e949ec@gmail.com> <1580e48a-be44-38dd-79af-8a2a31c5712e@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bp1dUqlY+PGPwj7mQapF9Xrhtbc4lmI3B2+KLV8JRAtxeM7if5w
 ZsUfKOVP4FNTh7vCk3Y7gUJWKvRApcjVbJoHlwIMCgUJUUUqcX0+aDldIbOryadvflmI62Q
 8qwmSWCXzWs9g24VAUj25X8DmdiuxT8E9L0S/re80wlWs17ZMjE2zpgOpud0kDqsuN2F3Dd
 w9ybjQI7a8bzDWzH+2R1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0gCRFjE4wmY=:BsFc/6B4QMgDv1n4aXfsx4
 MRlZnGVTF/M2/kxeCsJ44xxbMwPAygelYbg1PG4MUE7c1Ba4KrZZWX7dE9uyVKP87Jg1mI/sa
 RnbBtj1FSsRCMAxlpF/eytYRQyAI6oQs1QkTuYkY+MqE37P4BVsk843c8YviXsNkhyc9U+aoj
 0S52vfboEVaVjcG/peC2TjEEW/AsYf67JG4X1DrQznWSfsPFwrkLzJ8y7WFO+9Wo40qns2jWO
 Vh2X3Jf13IRlmRG4MuTmmfYV5Z35oO/1T/ZSahIWQ2DyF4X3Iy+x6PTuV8nlwESv1ua8Zejny
 1UI/cjGnNx53CbYn4h/VUeL+2MYzrCfCgctQ44+Pfab9yI/sJ2VaF2I6oUF7UezZGGXs/Ge85
 hYScGiJ8hnl+DWnBYEVrByaK6UdCP3KomdCaRusFNI3u531lxqIZFUetBWVzkoiTXyTnqqLWy
 g0bfUJPTztepRmHtKNJYjxsPZq9gR8DL3h7vHjG61SXFpnvIaNFii2fG5YLrRFhcXuBWhliqj
 dO9amVyW7tIy3XsRe6D9NN3vWsR+Fu39tqtQifBtpmgdOjgRSY2uNv05zsBX3udG3xFGxyAwF
 b3UJTGEnq5yn/4XOEy/yh/jhFlEudbZgC3CoYTDp7EWHxX67Fj1z1OOMfEMtelwia5P/3nnAV
 SueK4QOJLTHbTEjCn3MTJ/1RbNNgqxK7zRAqCW1U3CQdyd3T0ttc3uZftRMk0bWwqtw9DX46o
 l4WV9PCEMtyKsTqh7RmUKINw+pCxF8qXWyjhgRrb4SioB6loPdvq/ndvQ55sYfSH5SJzxPhGg
 GeLayDxk7vTL+Be9zqHXyKY4pB6gKPz/jXrn61DdjvReWNNTkw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip & Buga,

On Tue, 6 Mar 2018, Phillip Wood wrote:

> On 02/03/18 23:33, Igor Djordjevic wrote:
> > 
> > [...]
> > Otherwise, I would be interested to learn how context/semantics 
> > guessing could provide a better default action (without introducing 
> > more complexity for might not be much benefit, if any).
> 
> I don't think its possible to guess the semantics of the original merge
> as users can use custom merge strategies and amend the result. It would
> be possible to detect and unamended '-s ours' merge but special casing
> that may end up causing users more confusion rather than helping them.

FWIW I agree.

My original plan was to always merge recursively and suggest to use `exec`
commands if anything else is needed.

But now with that excellent new idea to perform successive three-way
merges of the original merge commit with the new tips, using the old tips
as merge base, I am considering to change that.

There is a big problem here, though: consistency. See below for more
musings about that.

> > And I guess being consistent is pretty important, too - if you add new
> > content during merge rebase, it should always show up in the merge,
> > period. 
> 
> Yes, that should make it easy for the user to know what to expect from
> rebase.

Indeed. We have seen time and time again that consistent behavior is the
only thing that lets us adhere to the Law of Least Surprise.

And here lies the rub: do we really want to let `merge -C <commit>` behave
completely differently than `merge`? Granted, in one case we provide a
template merge commit, in the other case, we do not. And the idea is
already to behave differently, although that difference only extends to
the commit message so far.

But given the benefit (i.e. that the strategy to transform the original
merge commit into the new merge commit), I am willing to run that risk,
especially since I foresee only few users wanting to create new merge
commits from scratch using the `merge` todo command.

Of course, even then we need to be careful: the user might have
*changed* or *moved* the original `merge` command. For example, if the
merge command read:

	merge -C deadbee cafecafe bedbedbed

and the user switched the order of the merged branches into

	merge -C deadbee bedbedbed cafecafe

we would have to detect the changed order of the arguments so that we
could still find the original branch tips.

But the user might also have changed the branch(es) to merge completely,
in which case we might not even be able to find original branch tips.

My preferred solution would be to let the `merge` command figure out
whether the passed arguments correspond to the rewritten versions of the
original merge parents. And only in that case would we use the fancy
strategy, in all other cases we would fall back to performing a regular
recursive (or octopus) merge.

How does that sound?

It will be slightly inconsistent. But in a defendable way, I think.

Ciao,
Dscho
