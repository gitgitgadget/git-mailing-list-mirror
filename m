Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CD0C49360
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE69611CE
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 04:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNEq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 00:46:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54128 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhFNEq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 00:46:58 -0400
Received: (qmail 32406 invoked by uid 109); 14 Jun 2021 04:44:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 14 Jun 2021 04:44:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29981 invoked by uid 111); 14 Jun 2021 04:44:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Jun 2021 00:44:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Jun 2021 00:44:53 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] xdiff: implement a zealous diff3
Message-ID: <YMbexfeUG78yBix4@coredump.intra.peff.net>
References: <20210613143155.836591-1-felipe.contreras@gmail.com>
 <YMYnVWSEgxvKRU9j@coredump.intra.peff.net>
 <60c647c1d9b5c_41f452089@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60c647c1d9b5c_41f452089@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 01:00:33PM -0500, Felipe Contreras wrote:

> > > I'm re-sending this patch from 2013 because I do think it provides value
> > > and we might want to make it the default.
> > 
> > I take it you didn't investigate the segfault I mentioned.
> 
> I don't know how I was supposed to investigate the few segfaults you
> mentioned. All you said is that you never tracked the bug.

My point is that if you are going to repost a patch that has known
problems, it is worth saying so to give reviewers and the maintainer a
realistic idea of how stable it is.

I also didn't have a reproduction recipe. I found the commit I sent by
just re-running every merge in git.git in a loop.

It sounds like you have a smaller reproduction and maybe a fix, which is
good.

-Peff
