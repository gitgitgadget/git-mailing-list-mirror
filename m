Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6E3C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D873060C3F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhHLU0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 16:26:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:45882 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhHLU0O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 16:26:14 -0400
Received: (qmail 24794 invoked by uid 109); 12 Aug 2021 20:25:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Aug 2021 20:25:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25359 invoked by uid 111); 12 Aug 2021 20:25:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Aug 2021 16:25:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Aug 2021 16:25:47 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 16/25] t5310: move some tests to lib-bitmap.sh
Message-ID: <YRWDyyhJAot8hxTD@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1627420428.git.me@ttaylorr.com>
 <168b7b0976c7d3ab2082843b7c322252eed11a3f.1627420428.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <168b7b0976c7d3ab2082843b7c322252eed11a3f.1627420428.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 27, 2021 at 05:20:04PM -0400, Taylor Blau wrote:

> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> index fe3f98be24..ecb5d0e05d 100644
> --- a/t/lib-bitmap.sh
> +++ b/t/lib-bitmap.sh
> @@ -1,3 +1,6 @@
> +# Helpers for scripts testing bitamp functionality; see t5310 for
> +# example usage.

Bitamp. :) Not worth a re-roll on its own, but I think we'll want one
more round to fix the close_object_store() stuff earlier in the series.

The rest of the patch looks good.

-Peff
