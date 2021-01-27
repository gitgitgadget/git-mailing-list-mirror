Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C5C433E0
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A207961601
	for <git@archiver.kernel.org>; Wed, 27 Jan 2021 23:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhA0XmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:42:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235669AbhA0XkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jan 2021 18:40:02 -0500
Received: (qmail 7566 invoked by uid 109); 27 Jan 2021 23:39:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Jan 2021 23:39:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21483 invoked by uid 111); 27 Jan 2021 23:39:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Jan 2021 18:39:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Jan 2021 18:39:20 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 2/2] rev-list: add --disk-usage option for calculating
 disk usage
Message-ID: <YBH5qFon3qP2vnuZ@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YBHmY7vNxu2hqOa/@coredump.intra.peff.net>
 <CAPig+cQTV6ACiOj+GKoBwj15TZBr5craVPT6dYzzSDfrX9a3YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQTV6ACiOj+GKoBwj15TZBr5craVPT6dYzzSDfrX9a3YA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 27, 2021 at 06:07:57PM -0500, Eric Sunshine wrote:

> This example shows the computed size (1455691059)...
> [...]
> ...however, this example does not (but all the others do). Simple
> copy/paste error?

Yep, thanks for catching. (Of course I have since repacked my linux.git,
so now it produces a different answer! It does match the current value
of the other techniques, though).

> Not worth a re-roll, of course.

Agreed, but it looks like there are a few other minor bits, so I'll
definitely fix it up at the same time. I'll give a little more time
before re-rolling in case there are any other comments.

-Peff
