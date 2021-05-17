Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC120C43461
	for <git@archiver.kernel.org>; Mon, 17 May 2021 11:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF51611CA
	for <git@archiver.kernel.org>; Mon, 17 May 2021 11:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhEQLlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 07:41:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56222 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236720AbhEQLlW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 07:41:22 -0400
Received: (qmail 5127 invoked by uid 109); 17 May 2021 11:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 May 2021 11:40:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28461 invoked by uid 111); 17 May 2021 11:40:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 May 2021 07:40:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 May 2021 07:40:04 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: remove unnecessary rm instances
Message-ID: <YKJWFFTUjaQ8Eivm@coredump.intra.peff.net>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
 <20210514115631.503276-4-felipe.contreras@gmail.com>
 <YJ+TQiYVgocUBQRV@coredump.intra.peff.net>
 <609fb8b5bf799_e173a20897@natae.notmuch>
 <YKIu/DUfmU8JbDY2@coredump.intra.peff.net>
 <60a24897afda0_126a0520834@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60a24897afda0_126a0520834@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 17, 2021 at 05:42:31AM -0500, Felipe Contreras wrote:

> > I.e., I was suggesting to get rid of the "rm" call in the hunk I showed
> > above, but leave the "mv" for the follow-on patch.
> 
> Ahh, I see. It's quite a bit more work, but sure, I can do that.

If it's a lot more work, I can live with the split as you have here. I
didn't think it would be a lot, though.

-Peff
