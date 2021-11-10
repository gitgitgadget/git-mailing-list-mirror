Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA7FC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB7C6109F
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 08:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhKJIZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:25:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:56434 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhKJIZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 03:25:47 -0500
Received: (qmail 27249 invoked by uid 109); 10 Nov 2021 08:22:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Nov 2021 08:22:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10998 invoked by uid 111); 10 Nov 2021 08:23:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Nov 2021 03:23:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Nov 2021 03:22:59 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YYuBY3jIjqrMxNPJ@coredump.intra.peff.net>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <20211110063547.xcpjjzoobha3eeff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211110063547.xcpjjzoobha3eeff@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 10, 2021 at 07:35:47AM +0100, Johannes Altmanninger wrote:

> > Fixes since v2.33
> > -----------------
> > 
> >  * Doc update plus improved error reporting.
> 
> This should be something like
> 
>  * Warn when iconv(3) fails to reencode log messages.

Yes, though note that we ended up reverting the warning. So probably it
could be removed from the release notes entirely.

-Peff
