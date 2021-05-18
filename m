Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856A2C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA0160FE8
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhERGbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:31:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:57374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234413AbhERGbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:31:17 -0400
Received: (qmail 10598 invoked by uid 109); 18 May 2021 06:30:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 06:30:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5135 invoked by uid 111); 18 May 2021 06:30:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 02:30:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 02:29:59 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] setup: split "extensions found" messages into singular
 and plural
Message-ID: <YKNe50TDMftkadYI@coredump.intra.peff.net>
References: <20210518061917.57556-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210518061917.57556-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 12:19:17AM -0600, Alex Henrie wrote:

> It's easier to translate this way.

Makes sense.

I don't know about "easier to translate", since there are twice as many
strings now. But certainly what the user sees will be more grammatically
correct. :)

-Peff
