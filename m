Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59032C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 20:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLNUnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLNUnh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 15:43:37 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5C4EB3
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 12:43:36 -0800 (PST)
Received: (qmail 28251 invoked by uid 109); 14 Dec 2022 20:43:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Dec 2022 20:43:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22669 invoked by uid 111); 14 Dec 2022 20:43:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Dec 2022 15:43:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Dec 2022 15:43:35 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 0/4] Don't lazy-fetch commits when parsing them
Message-ID: <Y5o1d6f2cepf7Vp6@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1671045259.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1671045259.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 11:17:39AM -0800, Jonathan Tan wrote:

> Thanks everyone once again and sorry for the churn. Hopefully I got it
> right this time.
> 
> open_loose_object() is documented to return the path of the object
> we found, so I think we already have that covered (if we detect that
> an object is corrupt, it follows that we would already have found the
> object in the first place).

This version looks good to me. Thanks for your persistence. :) I think
the end result is very nicely done.

-Peff
