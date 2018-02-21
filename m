Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86EE11F404
	for <e@80x24.org>; Wed, 21 Feb 2018 23:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUXeg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 18:34:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:60162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750752AbeBUXef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 18:34:35 -0500
Received: (qmail 21840 invoked by uid 109); 21 Feb 2018 23:34:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Feb 2018 23:34:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29234 invoked by uid 111); 21 Feb 2018 23:35:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Feb 2018 18:35:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Feb 2018 18:34:33 -0500
Date:   Wed, 21 Feb 2018 18:34:33 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit: drop uses of get_cached_commit_buffer()
Message-ID: <20180221233433.GA29992@sigill.intra.peff.net>
References: <20180221185204.GA8476@sigill.intra.peff.net>
 <1519240631-221761-1-git-send-email-dstolee@microsoft.com>
 <07690508-e6c6-5b3b-6c03-5ad83c9c3501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <07690508-e6c6-5b3b-6c03-5ad83c9c3501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 21, 2018 at 02:19:17PM -0500, Derrick Stolee wrote:

> > These behaviors are undocumented, untested, and unlikely to be
> > expected by users or other software attempting to parse this output.
> > 
> > Helped-by: Jeff King <peff@peff.net>
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> 
> This would be a good time to allow multiple authors, or to just change the
> author, since this is exactly the diff you (Peff) provided in an earlier
> email. The commit message hopefully summarizes our discussion, but I welcome
> edits.

The point is moot if we take the revision I just sent (though in
retrospect I really ought to have put in a Reported-by: for you there).

But some communities are settling on Co-authored-by as a trailer for
this case. And GitHub has started parsing and showing that along with
author information:

  https://github.com/blog/2496-commit-together-with-co-authors

-Peff
