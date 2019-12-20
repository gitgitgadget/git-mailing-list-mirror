Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D556FC43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92D7206A5
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLTU7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 15:59:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:51440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726525AbfLTU7t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 15:59:49 -0500
Received: (qmail 3265 invoked by uid 109); 20 Dec 2019 20:59:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Dec 2019 20:59:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15291 invoked by uid 111); 20 Dec 2019 21:04:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Dec 2019 16:04:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Dec 2019 15:59:47 -0500
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luis Marsano <luis.marsano@gmail.com>,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [RESEND PATCH 0/2] contrib/credential/netrc: Makefile + script
 cleanup
Message-ID: <20191220205947.GA2752079@coredump.intra.peff.net>
References: <cover.1576531851.git.liu.denton@gmail.com>
 <cover.1576867467.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1576867467.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 10:44:59AM -0800, Denton Liu wrote:

> I recently switched my workflow to use this credential helper and I
> noticed a couple of problems:
> 
> 1. The interpreter path was hardcoded to #!/usr/bin/perl
> 
> 2. The script refuses to run outside of a Git repository
> 
> This patch series should fix these problems.

Since this is just a re-send, I'll re-send my:

  Reviewed-by: Jeff King <peff@peff.net>

:)

-Peff
