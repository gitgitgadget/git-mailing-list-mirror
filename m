Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D24201F600
	for <e@80x24.org>; Sat, 22 Jul 2017 11:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755094AbdGVLo7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jul 2017 07:44:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:51840 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754985AbdGVLo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2017 07:44:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRXSK-1dAi9P2GHQ-00ShzU; Sat, 22
 Jul 2017 13:44:31 +0200
Date:   Sat, 22 Jul 2017 13:44:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Liam Beguin <liambeguin@gmail.com>
Subject: Re: [PATCH v6 00/10] The final building block for a faster rebase
 -i
In-Reply-To: <xmqqfudqkcux.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1707221335150.4271@virtualbox>
References: <cover.1500043436.git.johannes.schindelin@gmx.de> <xmqqfudqkcux.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:wQXZHk3W+iQUb9cbYtbbJ+J00f9Moz6vcRD7rjs5R+iB+fuWEQ6
 qMw3Aj4UpP5SaLZltsjze162Fu48+Wd348eJdesxDQM4sBxrxpMNjhwC4Bj+3/T3tKhYrKD
 ghhGa5I9hVuusQ2PUoXoNobNAXQrmgSK7/iqA0RJMvqNGUSC+M9CuEJgYe1XWYYeQmWpjV6
 Q3BVcPltvmOtBZwSbkSCA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H1d06EqFFmI=:5420+afokIZenxMqYB4HHL
 x3iZPP/xMbDlwM9GQNLiBOXNgdcX39dFaGOU2DgD1jIEAk7bhFP2ZlTiCYhBBKwkSFiVliw85
 RXjNSjLCRHg31pR+Y7jUwGp8nJeN7kOVacvUnNT8PL4N1k6EUDOESIxCkfTRsWb2b+tHCkMI3
 foclwQe04d2JBpzedGRWounZrbkmfz2XnS8IQG9KMV/WgbU2ix6ChC75VQKihYICuTnOaGACj
 9BYIg9RgTaoojxQ2E0tdMEfGsTlO2VcTSISghtoas84hNoCHSzfGxhgguN25m9dt5RmaEdioR
 kyYz79hLo99bOYj+txt2/WdmQvgNVHpBzqu+Lr0ie7GLYwtI3ftqWlbjQmxbQ7Jk6lRt4h8C9
 urPGXRZ01DuoOnDkzCybRlcyAhqh7avFuY1W8+2piPK9aiBkvweMg9QRGzmg2/e8v6reF6rcv
 EkumRF42PEFtebqagANN/uFPFFN3rsDhJdJ2ggl6c9kMj9nk50MaAl39m0ZAzqqJ7Ygl7V1MB
 HDiiNMm7UnCgSYGV6RsSgluo9ssPnsEk5Vm4cAh5mfpsf7hrGfIF9k559peRkKcnEZNVy0ZRm
 SiznSEEhHo7oZHZWq4dW1nkGbBdWpzVCY6Sf9opnYWVvx9RtO5WhQ9SWLKKJKXuDHq23giVNC
 bMemWwP15cexSeFR8YDX51z8FPyNjMiUiiKGM9fspQl2L8o44yUv/UZug+sF1hni1mK7X5jU8
 ePK7MxnDPgh8Ux4+10GmFLFIUqoPJAs5lMQALvRWMTx47Yu9AyngupNa4UQzJC6+mNM3RP2kJ
 OcqjLC+jg3CoKwOU9Vp3tkS3OnU5ZUOjMt4BqW4BWo3z2OMsTY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 20 Jul 2017, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Changes since v5:
> >
> > - replaced a get_sha1() call by a get_oid() call already.
> >
> > - adjusted to hashmap API changes
> 
> Applying this to the tip of 'master' yields exactly the same result
> as merging the previous round js/rebase-i-final to the tip of
> 'master' and then applying merge-fix/js/rebase-i-final to adjust to
> the codebase, so the net effect of this reroll is none.  Which is a
> good sign, as it means there wasn't any rebase mistake and the evil
> merge we've been carrying was a good one.

Good.

> But at the same time, I prefer to avoid rebasing to newer 'master'
> until the codebase starts drifting too far apart, or until a new
> feature release is made out of newer 'master'.  This is primarily
> because I want dates on commits to mean something---namely, "this
> change hasn't seen a need to be updated for 'oops, that was wrong'
> since this date".  This use of commit dates as 'priority date'
> matters much less for a topic not in 'next', but as a general
> principle, my workflow tries to preserve commit dates for all
> topics.

By that token, commit message updates would also be inappropriate, in
particular when they came from somebody else than the patch author ;-P

As to avoiding a rebase: we can add that to the growing list of things on
which we disagree.

If the author dates really meant anything, we would also have to avoid v2,
v3, v4, ... v226 of patch series. So that flies in the face of trying to
keep the meaning of author dates.

In addition, the development flow I prefer is one that is in harmony with
the modern Continuous Integration style, where topic branches are merged
into a single, always-ready-to-release integration branch.

That means that I always work off of `master`, unless there is a good
reason to base off of `next` or even `pu`. That's to avoid merge
conflicts, to see what really gets applied.

I am *especially* adamant about rebasing to a newer upstream commit when
there are merge conflicts.

Such as is the case here.

> For the above reason, I may hold onto this patch series in my inbox
> without actually updating js/rebase-i-final topic until the current
> cycle is over; please do not mistake it as this new reroll being
> ignored.

You do as you want, of course. But please note that I will not rebase my
topic branches to an ancient revision, especially if that would cause merge
conflicts with the current `master`.

And if there should be another iteration of this wallflower patch series,
I will rebase it to the then-current `master` again [*1*].

Ciao,
Dscho

Footnote *1*: in general, I try to abide by the wishes of maintainers when
contributing code, unless those wishes are contrary to what I consider
correct software development. Like, when in Rome, I will do as the Romans
do. Except when I see them looting a parking meter.
