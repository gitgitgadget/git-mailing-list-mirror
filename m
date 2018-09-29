Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A5241F453
	for <e@80x24.org>; Sat, 29 Sep 2018 08:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeI2O1q (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:27:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:36168 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727538AbeI2O1q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:27:46 -0400
Received: (qmail 10387 invoked by uid 109); 29 Sep 2018 08:00:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 08:00:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4611 invoked by uid 111); 29 Sep 2018 07:59:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 03:59:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 04:00:16 -0400
Date:   Sat, 29 Sep 2018 04:00:16 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t1400: drop debug `echo` to actually execute `test`
Message-ID: <20180929080016.GH2174@sigill.intra.peff.net>
References: <20180928154359.26919-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180928154359.26919-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 05:43:59PM +0200, Martin Ågren wrote:

> Instead of running `test "foo" = "$(bar)"`, we prefix the whole thing
> with `echo`. Comparing to nearby tests makes it clear that this is just
> debug leftover. This line has actually been modified four times since it
> was introduced in e52290428b (General ref log reading improvements.,
> 2006-05-19) and the `echo` has always survived. Let's finally drop it.

Hmm, yeah. I cannot see how this echo was ever accomplishing anything.

> This script could need some more cleanups. This is just an immediate fix
> so that we actually test what we intend to.

Yeah, this is definitely worth doing now, and not holding hostage to a
bigger cleanup.

> ---
>  t/t1400-update-ref.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

The patch looks good to me. Thanks!

-Peff
