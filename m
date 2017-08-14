Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0378320899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbdHNXBL (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:01:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:38704 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752643AbdHNXBL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:01:11 -0400
Received: (qmail 29994 invoked by uid 109); 14 Aug 2017 23:01:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 23:01:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6844 invoked by uid 111); 14 Aug 2017 23:01:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 19:01:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 19:01:08 -0400
Date:   Mon, 14 Aug 2017 19:01:08 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peartben@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 1/2] clang-format: outline the git project's coding
 style
Message-ID: <20170814230108.wucznh66vfblrsys@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814213046.107576-2-bmwill@google.com>
 <20170814224831.qhs7b44bg7v7tryx@sigill.intra.peff.net>
 <20170814225108.qoq6noojqznp4be6@sigill.intra.peff.net>
 <20170814225430.GB95777@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170814225430.GB95777@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 03:54:30PM -0700, Brandon Williams wrote:

> > And removing that gives me a clean output. I have no idea why my clang
> > doesn't like these (but presumably yours does). It's clang-format-5.0 in
> > Debian unstable (and clang-format-3.8, etc).
> 
> Those must be features in version 6 (which is what I seem to have
> installed on my machine).

OK, that makes sense. The most recent one package for Debian unstable is
5.0. AFAICT 5.0 is actually in release freeze for another week or two,
and 6 is just bleeding-edge that moved on after the release freeze a few
weeks ago.

I'm not sure which version it makes sense to target as a minimum, but
probably not 6 yet. :)

-Peff
