Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 993C41FF6D
	for <e@80x24.org>; Sun, 27 Nov 2016 16:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbcK0Q4D (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 11:56:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:47591 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbcK0Q4C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 11:56:02 -0500
Received: (qmail 32663 invoked by uid 109); 27 Nov 2016 16:56:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 16:56:01 +0000
Received: (qmail 29311 invoked by uid 111); 27 Nov 2016 16:56:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 27 Nov 2016 11:56:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Nov 2016 11:55:59 -0500
Date:   Sun, 27 Nov 2016 11:55:59 -0500
From:   Jeff King <peff@peff.net>
To:     Dun Peal <dunpealer@gmail.com>
Cc:     Git ML <git@vger.kernel.org>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
Message-ID: <20161127165559.j5okxyztwescheug@sigill.intra.peff.net>
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
 <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
 <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2016 at 08:46:40AM -0500, Dun Peal wrote:

> Ignoring a non-zero exit code from the merge tool, and assuming a
> successful merge in that case, seems like the wrong default behavior
> to me.

Yeah, I'm inclined to agree. But like I said, I'm not too familiar with
this area, so maybe there are subtle things I'm missing.

> Finally, if you're not using mergetools, how do you resolve conflicts?

I just edit the conflicted sections in vim. I do use git-jump (see
contrib/git-jump), but that's just to get to them quickly.

-Peff
