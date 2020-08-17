Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B29C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13ACF2072D
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgHQVhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:37:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:33624 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgHQVhv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:37:51 -0400
Received: (qmail 6783 invoked by uid 109); 17 Aug 2020 21:37:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:37:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22539 invoked by uid 111); 17 Aug 2020 21:37:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:37:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:37:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] msvc: copy the correct `.pdb` files in the Makefile
 target `install`
Message-ID: <20200817213750.GA1854930@coredump.intra.peff.net>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>
 <120d2bb3e461717e5248bb4c97feab86d4e45c9d.1597655273.git.gitgitgadget@gmail.com>
 <20200817092431.GA1259595@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008170750090.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2008170750090.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 07:51:17AM +0200, Johannes Schindelin wrote:

> > The rest of the series looks like a good direction to me, but is outside
> > the scope of my series. I'd be happy to pick this first patch up for a
> > re-roll of mine (which would require tweaking the rest of the patches on
> > top to stop removing things from the .pdb list). Or we could just leave
> > this as a separate topic and deal with the merge conflict (which would
> > obviously resolve in favor of yours).
> 
> Please feel totally free to cherry-pick my 1/3 as your 1/5 (but please do
> fix up the author email address, if you don't mind).
> 
> I have no problem with my patch series depending on yours, to make merging
> easier.

It doesn't look like that series otherwise needs a re-roll, so if it's
OK with you, let's just have yours come on top (or independent, as the
conflict is pretty easy).

-Peff
