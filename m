Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195E520401
	for <e@80x24.org>; Sat, 24 Jun 2017 12:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFXMpZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 08:45:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:51822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750817AbdFXMpY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 08:45:24 -0400
Received: (qmail 2544 invoked by uid 109); 24 Jun 2017 12:45:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 12:45:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23639 invoked by uid 111); 24 Jun 2017 12:45:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 08:45:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 08:45:22 -0400
Date:   Sat, 24 Jun 2017 08:45:22 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
Message-ID: <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com>
 <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 06:03:13PM -0700, Jonathan Tan wrote:

> Subject: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
> Improve sha1_object_info_extended() by supporting additional flags. This
> allows has_sha1_file_with_flags() to be modified to use
> sha1_object_info_extended() in a subsequent patch.

A minor nit, but try to avoid vague words like "improve" in your subject
lines. Something like:

  sha1_file: teach sha1_object_info_extended more flags

That's not too specific either, but I think in --oneline output it gives
you a much better clue about what part of the function it touches.

> ---
>  cache.h     |  4 ++++
>  sha1_file.c | 43 ++++++++++++++++++++++++-------------------
>  2 files changed, 28 insertions(+), 19 deletions(-)

The patch itself looks good.

-Peff
