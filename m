Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693E8202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 04:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750778AbdIWEhE (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 00:37:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:47792 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750707AbdIWEhE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 00:37:04 -0400
Received: (qmail 23868 invoked by uid 109); 23 Sep 2017 04:37:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 04:37:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10890 invoked by uid 111); 23 Sep 2017 04:37:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 00:37:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 00:37:01 -0400
Date:   Sat, 23 Sep 2017 00:37:01 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
Message-ID: <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1506120291.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 01:34:48AM +0200, Martin Ågren wrote:

> Martin Ågren (6):
>   builtin/commit: fix memory leak in `prepare_index()`
>   commit: fix memory leak in `reduce_heads()`
>   leak_pending: use `object_array_clear()`, not `free()`
>   object_array: use `object_array_clear()`, not `free()`
>   object_array: add and use `object_array_pop()`
>   pack-bitmap[-write]: use `object_array_clear()`, don't leak

All six look good to me. Thanks again for poking into this. I'm afraid
to ask how far we have left to go on running the test suite all the way
through with leak-checking turned on. :)

-Peff
