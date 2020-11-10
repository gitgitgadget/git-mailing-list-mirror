Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A580C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2020731
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 19:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbgKJT6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:58:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:53272 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgKJT6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 14:58:42 -0500
Received: (qmail 9002 invoked by uid 109); 10 Nov 2020 19:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 19:58:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4527 invoked by uid 111); 10 Nov 2020 19:58:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 14:58:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 14:58:40 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 08/21] trailer: keep track of conf in trailer_item
Message-ID: <20201110195840.GD1987088@coredump.intra.peff.net>
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201025212652.3003036-9-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025212652.3003036-9-anders@0x63.nu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:26:39PM +0100, Anders Waldenborg wrote:

> Signed-off-by: Anders Waldenborg <anders@0x63.nu>

For refactoring commits like this, it can help to even give one or two
sentences saying why this moves us in a good direction.

Probably it is obvious to you, who wrote the later commits already, but
in isolation it's hard to say if it is good move direction or not. And
maybe it would become apparent by the time I get to the end, but leading
the reviewer along the string of refactorings is a good way to help them
understand the end state, too. :)

-Peff
