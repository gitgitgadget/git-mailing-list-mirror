Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E6820970
	for <e@80x24.org>; Sat,  8 Apr 2017 22:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdDHWDx (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 18:03:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:58676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbdDHWDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 18:03:52 -0400
Received: (qmail 25273 invoked by uid 109); 8 Apr 2017 22:03:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 22:03:50 +0000
Received: (qmail 14855 invoked by uid 111); 8 Apr 2017 22:04:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 18:04:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 18:03:47 -0400
Date:   Sat, 8 Apr 2017 18:03:47 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        git <git@vger.kernel.org>
Subject: Re: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
Message-ID: <20170408220347.jcyatwegrjsxjeqo@sigill.intra.peff.net>
References: <20170408093133.acilrs5lc3kxzpmu@sigill.intra.peff.net>
 <1n469ch.1maczdmz3p8f2M%lists@haller-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1n469ch.1maczdmz3p8f2M%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 08, 2017 at 05:03:06PM +0200, Stefan Haller wrote:

> Jeff King <peff@peff.net> wrote:
> 
> > I think Matt's point is just that the default, to use origin/branch, is
> > unsafe. It's convenient when you don't have extra fetches, but that
> > convenience may not be worth the potential surprise.
> 
> I don't think "surprise" is the right word here. The point of
> --force-with-lease is to provide a guarantee, so if you can't trust the
> guarantee, it makes the feature rather pointless.

You can trust it under a certain set of conditions. If you break those
conditions, it doesn't work. So that's why I said "surprise": most users
aren't going to be aware of those conditions.

But I also used the word "unsafe". That, or "dangerous", is certainly
accurate. And I don't at all disagree that the situation should be
improved.

-Peff
