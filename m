Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1E591F453
	for <e@80x24.org>; Thu, 27 Sep 2018 18:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeI1BLJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 21:11:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:33930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728547AbeI1BLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 21:11:09 -0400
Received: (qmail 8064 invoked by uid 109); 27 Sep 2018 18:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 18:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3870 invoked by uid 111); 27 Sep 2018 18:51:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 14:51:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 14:51:28 -0400
Date:   Thu, 27 Sep 2018 14:51:28 -0400
From:   Jeff King <peff@peff.net>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180927185128.GA4612@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
 <CAC053843M-dXgRXziibLET+r+0adNaefnMBjED8bTwXrvvgrzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC053843M-dXgRXziibLET+r+0adNaefnMBjED8bTwXrvvgrzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 11:39:26AM -0700, Nickolai Belakovski wrote:

> Thanks for the feedback Peff. I actually agree with all your points.
> I'd considered an approach like what you proposed, but rejected it for
> the first iteration in an effort to keep scope limited and see what
> kind of feedback I'd get overall (like would people even want this?).
> This is a much better approach, and also gives a path for listing the
> worktree path in the verbose output.

Great. If you go that route, feel free to use whatever bits of my patch
are useful. I tested it only by running "for-each-ref" once, so it might
need some more help. Definitely tests and documentation at the least. :)

-Peff
