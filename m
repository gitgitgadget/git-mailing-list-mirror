Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BFA1F42D
	for <e@80x24.org>; Mon, 26 Mar 2018 09:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbeCZJSs (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 05:18:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:42992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750955AbeCZJSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 05:18:47 -0400
Received: (qmail 10884 invoked by uid 109); 26 Mar 2018 09:18:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 09:18:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17839 invoked by uid 111); 26 Mar 2018 09:19:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 05:19:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 05:18:45 -0400
Date:   Mon, 26 Mar 2018 05:18:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v2 0/4] Teach `--default` to `git-config(1)`
Message-ID: <20180326091845.GE18714@sigill.intra.peff.net>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <20180324005556.8145-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180324005556.8145-1-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 08:55:52PM -0400, Taylor Blau wrote:

> Attached is 'v2' of my patch series to add a `--default` option to `git config`.

Thanks, this is looking much better. I did come up with a few
suggestions/fixes. Some minor which would make v3 easy, and some that
would require expanding the series quite a bit. I'm not sure if those
bigger ones are worth doing or not. :)

> Thank you again for all of your feedback, and my apologies that it has taken me
> so long to respond. I was out of the office last week, and have been quite busy
> since catching up on Git LFS-related issues.

No problem. Open source moves at the pace of patch submissions.

-Peff
