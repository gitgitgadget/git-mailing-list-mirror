Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A75361F404
	for <e@80x24.org>; Sat, 25 Aug 2018 08:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeHYMBx (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 08:01:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:55810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726412AbeHYMBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 08:01:53 -0400
Received: (qmail 5895 invoked by uid 109); 25 Aug 2018 08:23:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Aug 2018 08:23:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2600 invoked by uid 111); 25 Aug 2018 08:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 25 Aug 2018 04:23:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2018 04:23:39 -0400
Date:   Sat, 25 Aug 2018 04:23:39 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 9/9] show_dirstat: simplify same-content check
Message-ID: <20180825082339.GB1672@sigill.intra.peff.net>
References: <20180825080031.GA32139@sigill.intra.peff.net>
 <20180825081731.GI737@sigill.intra.peff.net>
 <CAPig+cTBEWxJsqtAQW0=1-mPZMk4FPXuK0Zj2hdrFzrbjry3-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTBEWxJsqtAQW0=1-mPZMk4FPXuK0Zj2hdrFzrbjry3-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 25, 2018 at 04:20:33AM -0400, Eric Sunshine wrote:

> On Sat, Aug 25, 2018 at 4:17 AM Jeff King <peff@peff.net> wrote:
> > We two nested conditionals to store a content_changed
> 
> grammo...

Heh. Edited in my MUA while proof-reading, of course. ;)

It should be "We use two...".

-Peff
