Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A8741F453
	for <e@80x24.org>; Fri, 28 Sep 2018 04:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeI1LUw (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 07:20:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:34768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726271AbeI1LUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 07:20:52 -0400
Received: (qmail 30237 invoked by uid 109); 28 Sep 2018 04:59:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 04:59:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9941 invoked by uid 111); 28 Sep 2018 04:58:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Sep 2018 00:58:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2018 00:58:58 -0400
Date:   Fri, 28 Sep 2018 00:58:58 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com
Subject: Re: [PATCH v3 1/4] transport: drop refnames from
 for_each_alternate_ref
Message-ID: <20180928045858.GA25850@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <037273dab0f861e5f10241de1e32cddaabeab0cc.1538108385.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <037273dab0f861e5f10241de1e32cddaabeab0cc.1538108385.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Jeff King <me@ttaylorr.com>

Pretty sure that isn't right. :)

The preferred way to send a patch with a different author is to have
actual email be "From:" you, but then include a:

  From: Jeff King <peff@peff.net>

as the first line of the body (which git-am will then pick up).
git-send-email will do this for you automatically. Other scripts (like
say, if you're sending the output of format-patch into mutt) used to
have to implement it themselves, but these days we have "format-patch
--from", which should directly output what you want.

> ---
>  builtin/receive-pack.c | 3 +--
>  fetch-pack.c           | 3 +--
>  transport.c            | 6 +++---
>  transport.h            | 2 +-
>  4 files changed, 6 insertions(+), 8 deletions(-)

The patch itself is flawless, of course. ;)

-Peff
