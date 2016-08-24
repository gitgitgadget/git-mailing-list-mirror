Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2CC81F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbcHXNFm (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 09:05:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:56615 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754189AbcHXNFl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 09:05:41 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTBLi-1bktpe38kw-00S6iO; Wed, 24 Aug 2016 15:04:56
 +0200
Date:   Wed, 24 Aug 2016 15:04:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        git@vger.kernel.org, Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <B21604E7033C458EAC5EA0651CFEA8E9@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1608241459360.4924@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com> <B21604E7033C458EAC5EA0651CFEA8E9@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UZBd/UhqEMIQw85/d4lXm37VOJZjJXOEslm6WexjSTx7YGoNQyr
 l2GKzKsSEIz6AynjXxdd+1yA4j7fgIZyI+PTDihnoFxrEU3o2mMrsZ8NEhX4dggCFW26aF7
 h4ue2ZBMyYIDqDf1CxHpiAtbNvpwj1MLQZBKkK/cbuIqecozj/4ZBgNTyk8cK52DjNrHZyO
 ud3M7hh6aFIrMk9NBgzdg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B2msUtLUBCk=:Q0HQjbgDtnmWFcsWOBxidC
 8eFIAa8APOzCXHkOrjsKcx0qEBI0wDL20cWLFUi/UZPrlPxWYYpc0T+kq/QfSXdVsoebezoSj
 k+3RVm31+vopWb59MRsoPGaYb1KLDfiPaqgBI9DambVIVNWaXbPftKOJhrjSGrK88yMH0pNml
 ky4RHarBJVpJosLJmyJPODw2vPA+SDlmY44ZFhEHpcIBAZu11CPvGGQ2mH5XbgrcWLjhav47V
 uL3mPLGEkvm4r6w4ffLArf4ICEzJKYCCuZk6Ka0LnG++ciJDz1sOZT9U5szB+AQgonwqxDeIz
 SLDpbm1m3BX4BI7AerYxE3kM22T/o8kJD2JAk6ctFQTTsFbWjhKN4JGZ+tM+iqEDiTnSSXByc
 X+VQ2ZMWGc69VxAY3+4qfnvBLizyrGsVVZZ7hU/IzfDiikI+9fNwtqUL99Qk6b0G/sPVLhzNZ
 rYyubaGX2U+uM8/Y76I0usk7N5MJngmVmhJmrXBHOltWrFA3PB1lSuE8B8Kudm9JGp08UdkI7
 CbxTeh/M/aAKWVL1BIQgN7XShehoq9XB2JLY+HTCy0FMvhr4yATAHRdoxT+vXpT4rfygaba3c
 u+yJ6WV6ttc1w/3ySxc57T7hBaNN5AOaOB0XHKL7jTbsnvSJvwrwbVxC0c86rZpxy4qMtAk4J
 sp8mS34wGPJdtbxsQPQt3FQiKk2HJgLKto/VYbve+Y1e2N9CPxWNxKZyMrxRSD301D7WOeYY0
 drPTQl1jzbrEQ/R1JlwxohZNbcg2UDCANicFn6enlePb6sm3e60lICEHqEn3iG0FdC8OikNoR
 bAqB241
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Mon, 22 Aug 2016, Philip Oakley wrote:

> From: "Duy Nguyen" <pclouds@gmail.com>
> > On Mon, Aug 22, 2016 at 8:06 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > My point stands. We are way more uninviting to contributors than
> > > necessary. And a huge part of the problem is that we require contributors
> > > to send their patches inlined into whitespace-preserving mails.
> >
> > We probably can settle this in the next git survey with a new
> > question: what's stopping you from contributing to git?
> > -- 
> One has to be careful that some of this is preaching to the choir.

Exactly.

> I do note that dscho's patches now have the extra footer (below the three
> dashes) e.g.
> 
> Published-As: https://github.com/dscho/git/releases/tag/cat-file-filters-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git cat-file-filters-v1
> 
> If say I used that, and sent my patch series via Outlook Express (<sigh>),
> with it's white space damage, would those footers help once the content has
> been reviewed (rather than white spacing style) in the applying the patch?

I considered recommending this as some way to improve the review process.
The problem, of course, is that it is very easy to craft an email with an
innocuous patch and then push some malicious patch to the linked
repository.

Now, with somebody like me who would lose a lot when destroying trust, it
is highly unlikely. But it is possible that in between the hundreds of
sincere contributors a bad apple tries to sneak in bad stuff.

Therefore, if we were to support a Git-driven contribution process that
*also* sends mail, that mail needs to be generated by a trusted source, to
ensure that the content of the mail is identical to the original Git
commits.

Ciao,
Dscho
