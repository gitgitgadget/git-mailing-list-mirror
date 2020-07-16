Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B554C433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E362E20760
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 10:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGPKnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:43:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:58918 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPKnB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 06:43:01 -0400
Received: (qmail 22507 invoked by uid 109); 16 Jul 2020 10:43:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 10:43:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22724 invoked by uid 111); 16 Jul 2020 10:43:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 06:43:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 06:43:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 0/4] deterministic commit timestamps in tests
Message-ID: <20200716104300.GB376357@coredump.intra.peff.net>
References: <20200709203336.GA2748777@coredump.intra.peff.net>
 <xmqqa707rpuu.fsf@gitster.c.googlers.com>
 <20200714123142.GA2587001@coredump.intra.peff.net>
 <20200714123334.GB2587001@coredump.intra.peff.net>
 <20200714214728.GA21660@dcvr>
 <20200715074250.GB3249056@coredump.intra.peff.net>
 <xmqqa700ltn2.fsf@gitster.c.googlers.com>
 <xmqqwo34keej.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo34keej.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 08:04:52AM -0700, Junio C Hamano wrote:

> Before I forget, here is what could be applied on top of the "fix
> the starting timestamp for the world" step as a "further polishing
> on top of the completed series".
> 
> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Wed, 15 Jul 2020 03:42:50 -0400
> Subject: [PATCH] t9100: stop depending on commit timestamps

Thanks, this looks good and sets up to merge it post-v2.28.

-Peff
