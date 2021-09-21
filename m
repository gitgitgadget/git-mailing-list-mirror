Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71089C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56B8F61245
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhIUDcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:32:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:51396 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhIUDRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:17:17 -0400
Received: (qmail 3232 invoked by uid 109); 21 Sep 2021 03:15:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:15:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27289 invoked by uid 111); 21 Sep 2021 03:15:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:15:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:15:47 -0400
From:   Jeff King <peff@peff.net>
To:     Hamza Mahfooz <someguy@effective-light.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] pretty: colorize pattern matches in commit
 messages
Message-ID: <YUlOY1IDBL8iAZRm@coredump.intra.peff.net>
References: <20210921003050.641393-1-someguy@effective-light.com>
 <20210921003050.641393-2-someguy@effective-light.com>
 <YUk0OEXg36QXrkDm@coredump.intra.peff.net>
 <YUk3zwuse56v76ze@coredump.intra.peff.net>
 <MBJRZQ.9003XUH26Y7G2@effective-light.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MBJRZQ.9003XUH26Y7G2@effective-light.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 10:38:10PM -0400, Hamza Mahfooz wrote:

> 
> On Mon, Sep 20 2021 at 09:39:27 PM -0400, Jeff King <peff@peff.net> wrote:
> > Here are two patches I prepared on top of your series to show what's
> > possible, though I think we should do one of:
> > 
> >   - put them at the front of your series (with the appropriate
> >     adjustments) as preparatory cleanup
> > 
> >   - keep them separate. You can put a comment above the cast to mention
> >     what's going on and why it's OK for now, and then later when they're
> >     both merged, we can remove that cast.
> 
> Option 1 is preferable from my perspective, in that case.

OK. The patches I showed were the minimum to get your series working,
but there's actually a bit more cleanup we can do. I'll post a new
series in a moment, and then you can build on top of that.

-Peff
