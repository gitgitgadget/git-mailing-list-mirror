Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A118C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9F264E1B
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 09:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhA3JIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 04:08:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:41428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhA3JHz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 04:07:55 -0500
Received: (qmail 16651 invoked by uid 109); 30 Jan 2021 08:47:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 30 Jan 2021 08:47:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23293 invoked by uid 111); 30 Jan 2021 08:47:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 30 Jan 2021 03:47:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 30 Jan 2021 03:47:38 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 10/10] t5325: check both on-disk and in-memory reverse
 index
Message-ID: <YBUdKgmk2X4wd++h@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <38c8afabf25a7f5e144850938cf00b53e9cf25fd.1611617820.git.me@ttaylorr.com>
 <YBNfZeRiHgQwSqGq@coredump.intra.peff.net>
 <YBNlkvrxvAYrLeMc@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YBNlkvrxvAYrLeMc@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 08:32:02PM -0500, Taylor Blau wrote:

> On Thu, Jan 28, 2021 at 08:05:41PM -0500, Jeff King wrote:
> > Oh, I forgot to mention: if re-rolling, s/fortuan/fortuna/.
> 
> I do like your suggestion quite a lot: it gets rid of some ugliness,
> while making the overall test structure simpler. Here's a replacement
> for the final series.
> 
> Junio: when queuing, please apply this one instead of the original v3
> 10/10.

Thanks, this looks good to me.

-Peff
