Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5A3CE7A88
	for <git@archiver.kernel.org>; Sat, 23 Sep 2023 07:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjIWHJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Sep 2023 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIWHJL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2023 03:09:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F11C199
        for <git@vger.kernel.org>; Sat, 23 Sep 2023 00:09:05 -0700 (PDT)
Received: (qmail 9652 invoked by uid 109); 23 Sep 2023 07:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 23 Sep 2023 07:09:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24993 invoked by uid 111); 23 Sep 2023 07:09:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 23 Sep 2023 03:09:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 23 Sep 2023 03:09:03 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] .github/workflows: add coverity action
Message-ID: <20230923070903.GD1471672@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
 <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
 <d29b5fd3-3b44-89ca-62b4-cf93b23031fd@gmx.de>
 <20230923062137.GB1469962@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923062137.GB1469962@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2023 at 02:21:37AM -0400, Jeff King wrote:

> I'll take a look at the patches you posted.

OK, I just read over them. I do think the result is not much more
complicated than using the vapier Action, and it fits our multi-platform
needs a bit better.

I had a few small comments about curl usage, but it mostly looks like a
good direction to me.

-Peff
