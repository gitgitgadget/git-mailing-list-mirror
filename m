Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331071F424
	for <e@80x24.org>; Tue, 24 Apr 2018 14:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbeDXOsS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 10:48:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:35105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750736AbeDXOsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 10:48:16 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEWxh-1fCyEk34sj-00FmS3; Tue, 24
 Apr 2018 16:48:11 +0200
Date:   Tue, 24 Apr 2018 16:48:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Dan Jacques <dnj@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
In-Reply-To: <xmqqa7tt72c9.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804241646400.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <cover.1524309209.git.johannes.schindelin@gmx.de> <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com> <xmqqvach74qe.fsf@gitster-ct.c.googlers.com> <xmqqa7tt72c9.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nWPp0Mv9djBYB3YjHTjGyhsdz1uXTmOAEnY5+SVWvd7EvJD+aJW
 1IbBh1OiD1gC0rMVlrJngJfwEsS07XY/bW7YIBef9NESlnLbFIiydzUZ+DktYfZsKZzqSVE
 SRKGMkfegBCiki0itE/4fGJFM58kJeBpLxE7kNuW4GIXGpIRw+GdbeJbWdvruGujIUvmKRQ
 QGL5k0RzeB3qNW23kjsiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jPCctXTPkoc=:QDlm6m67eJYqu+Ni3uEh8w
 G9OwaJo3Rhc4PyXUIofBtsCUnDtEtye6Dt/+Hnlr3FDhYjKsRK7xmeb2179/iil5Gncp4MuHK
 A71z9mTt57Xzdys+svQzwqCkLHEW9nEq8h6A0QfSxzpqmh+j0qTvAIzXgAV4XlOMtnaz/pVos
 mBBssPukPDp8hqkCrFNDrAuu8gT/EzbvDPi0lDjMhTipKIobdVHYPePfbcBq/cm90+YJijnTO
 mRSzn2ehEwNwautYhvbo38w1dggH8rsV/zbH/cFSDTwnBJRX08VVYfr8ycNkoN4H2BvP3lEmo
 0n+snvrO5pyzZHj0rifcBaY6+VBdyfxwuB+C9b6cd/try71oN66DyWsBpUD0s1WuJ+xJ3LU7E
 YyMLTXmakL1NKmhsrrC+OOsoFykBI9dTfjLsNq1+ShXzMZ1f7R8EvTW3qCcJFxUc1+bkcylsJ
 3Ji3HZgG+KPbZgmCcZ6sNS3/xmu3s3NYJ9h2jtfsL6OP0Yr41lAGsGs0zkamYK1M17XhBl0Ye
 Drdt1cOwzKv0JOOngXHq2QE7wLIPhxWMvMkdhlhZ2sdgHSGLaMLJj8A4IEP/qmOMokXnLekvU
 wNHnkkma/smNYaDegHTZPVFdi2iYpskD+qXh/hbOVrTyFYXX1XuigcgrFOY2/YeeYFhFViIQt
 8TO0cAQ0UxwjNqP6b18zsno/RAzTd7NDykl7zZaF7OxYdpNuFg9ffRd9zQ9Bp5oNYtKEJXucK
 wnv4gRLHR9ljo+CerDTCx8FOiPcSl2qOvr4Uwqu782wAQPRydelRfjYID7a1gDM857VENTIy6
 xVx6s6uBT+uJrkCyN+cOrO1E15uNfGmBHa0JJfCn2JRHiLV5Jw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 24 Apr 2018, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>> base-commit: b46fe60e1d7235603a29499822493bd3791195da
> >>
> >> Basing your work on the tip of 'next' is good for discussion, but
> >> not readily usable for final application.  Let me see if I can
> >> untangle the dependents to come up with a reasonable base.
> >
> > I'll queue this on top of a merge of 'dj/runtime-prefix' into 'master'.
> > Merging the resulting topic into 'next' and applying these patches
> > directly on top of 'next' result in identical trees, of course ;-)
> 
> Actually, these trivially rebase on top of dj/runtime-prefix, so
> I'll queue them like so without taking it hostage to other things in
> 'master'.  We'd want to keep these mergeable to any integration
> branch that dj/runtime-prefix would be merged to, so that is the
> most logical organization, I would think, even though I do not
> immediately see the reason why we would want to merge
> dj/runtime-prefix to 'maint' and lower right now.
> 
> Thanks.

Thank you, and sorry for the trouble. I am just too used to a Continuous
Integration setting with exactly one integration branch.

I will make an effort in the future to figure out the best base branch for
patches that do not apply cleanly on `master` but require more stuff from
`next`/`pu`.

Ciao,
Dscho
