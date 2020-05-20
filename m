Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51696C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372F6207E8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgETVYq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 17:24:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:52484 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgETVYq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 17:24:46 -0400
Received: (qmail 9035 invoked by uid 109); 20 May 2020 21:24:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 May 2020 21:24:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18461 invoked by uid 111); 20 May 2020 21:24:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 May 2020 17:24:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 May 2020 17:24:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: Re* [ANNOUNCE] Git v2.27.0-rc1
Message-ID: <20200520212444.GA590699@coredump.intra.peff.net>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 01:31:30PM -0700, Junio C Hamano wrote:

> The promotion in Git 2.26 was buried in the "performance &
> implementation details" section and not in the backward
> compatibility section, so it feels a bit funny to highlight the
> reversion.  In any case, here is what I prepared (but not committed
> yet)

Hmm, yeah, that does make it feel funny. I'd argue that it probably
would have been worth promoting a bit more in v2.26, but it is obviously
too late now.

> -- >8 --
> Subject: [PATCH] RelNotes: advertise the demotion of protocol v2

What you have here looks fine, but I'd be OK if we just left it as-is,
too, given the v2.26 mention.

-Peff
