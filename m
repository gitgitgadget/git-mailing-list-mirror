Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A590C7DBC1
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890F224763
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfLMSSc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:18:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:46212 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728626AbfLMSSc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 13:18:32 -0500
Received: (qmail 2899 invoked by uid 109); 13 Dec 2019 18:18:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Dec 2019 18:18:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28895 invoked by uid 111); 13 Dec 2019 18:22:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2019 13:22:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Dec 2019 13:18:30 -0500
From:   Jeff King <peff@peff.net>
To:     Ed Maste <emaste@FreeBSD.org>
Cc:     git@vger.kernel.org, lukasz@niemier.pl
Subject: Re: [PATCH v2] userdiff: remove empty subexpression from elixir regex
Message-ID: <20191213181830.GA122626@coredump.intra.peff.net>
References: <20191213173902.71541-1-emaste@FreeBSD.org>
 <20191213175535.87725-1-emaste@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191213175535.87725-1-emaste@FreeBSD.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 05:55:35PM +0000, Ed Maste wrote:

> The regex failed to compile on FreeBSD.
> 
> Fixes: a807200f67588f6e
> Signed-off-by: Ed Maste <emaste@FreeBSD.org>
> ---
> Add /* -- */ to make things more clear and be consistent with other
> patterns.

Thanks, this looks good to me.

-Peff
