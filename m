Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69970C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52DD120702
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgGAPDP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:03:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:47266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731710AbgGAPDP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 11:03:15 -0400
Received: (qmail 24388 invoked by uid 109); 1 Jul 2020 15:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2020 15:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5687 invoked by uid 111); 1 Jul 2020 15:03:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2020 11:03:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Jul 2020 11:03:13 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] cat-file: add missing [=<format>] to usage/synopsis
Message-ID: <20200701150313.GA6726@coredump.intra.peff.net>
References: <20200701101618.28761-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200701101618.28761-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 01, 2020 at 12:16:18PM +0200, Christian Couder wrote:

> When displaying cat-file usage, the fact that a <format> can
> be specified is only visible when lookling at the --batch and
> --batch-check options which are shown like this:
> 
>     --batch[=<format>]    show info and content of objects fed from the standard input
>     --batch-check[=<format>]
>                           show info about objects fed from the standard input
> 
> It seems more coherent and improves discovery to also show it
> on the usage line.
> 
> In the documentation the DESCRIPTION tells us that "The output
> format can be overridden using the optional <format> argument",
> but we can't see the <format> argument in the SYNOPSIS above
> the description which is confusing.

Thanks, this makes sense and the patch looks good to me (it does make
the line very long, but the one above is much longer anyway).

-Peff
