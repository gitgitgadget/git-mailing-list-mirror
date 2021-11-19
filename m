Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81259C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608C26142A
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhKSOpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:45:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:34878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234402AbhKSOpI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:45:08 -0500
Received: (qmail 8296 invoked by uid 109); 19 Nov 2021 14:42:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:42:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13095 invoked by uid 111); 19 Nov 2021 14:42:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:42:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:42:05 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] various: remove dead code
Message-ID: <YZe3vU/reCcRGK2j@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 01:46:20PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Remove various bits of dead code. These are unrelated things that I've
> spotted here & there recently. Submitted now to clear out this batch
> of dead code removal before it gets any larger.

These all look fine to me. I gave some light philosophical musings on
the later ones, but I'd be OK to see the code dropped.

-Peff
