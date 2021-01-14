Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002CC433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6504E2310F
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbhANUMZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:12:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:56436 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbhANUMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:12:25 -0500
Received: (qmail 17786 invoked by uid 109); 14 Jan 2021 20:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Jan 2021 20:11:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17727 invoked by uid 111); 14 Jan 2021 20:11:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Jan 2021 15:11:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Jan 2021 15:11:44 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/3] Refactor writing promisor file
Message-ID: <YAClgD7HNglz2LtV@coredump.intra.peff.net>
References: <20210114155016.3005932-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114155016.3005932-1-chriscool@tuxfamily.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 04:50:13PM +0100, Christian Couder wrote:

> This is a small patch series to refactor the code that actually writes
> a promisor file (<pack-name>.promisor) into a write_promisor_file()
> function, and then to improve it a bit.
> 
> Compared to version 1 of this patch series, the only difference is
> that patch 3/3 has been added to die() in case of error, instead of
> ignoring it, when actually writing the content of the file or closing
> it. Thanks to Peff and Taylor for their suggestions.

These look great to me. Thanks for adding the extra error handling.

-Peff
