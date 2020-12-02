Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AC3C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA1121D7E
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgLBBzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:55:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:48204 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbgLBBzj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 20:55:39 -0500
Received: (qmail 29777 invoked by uid 109); 2 Dec 2020 01:54:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 01:54:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2785 invoked by uid 111); 2 Dec 2020 01:54:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 20:54:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 20:54:57 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, Arnout Engelen <arnout@bzzt.net>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: make HTML manual reproducible
Message-ID: <X8bz8c9enMl8Wqbe@coredump.intra.peff.net>
References: <20201201095037.20715-1-arnout@bzzt.net>
 <20201201154115.GP748@pobox.com>
 <CAN0heSpzA2ecKkjz0kMD8k66x8tDipKs93OHQ0+2efQyrS9_=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpzA2ecKkjz0kMD8k66x8tDipKs93OHQ0+2efQyrS9_=A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 08:18:45PM +0100, Martin Ågren wrote:

> Seems to me like we can go with a change like this. If you're on a
> pre-1.77.1 system and want user-manual.html, but don't want to update
> your tool chain, you should still be able to clone the "htmldocs" repo.
> I'm not sure exactly where the cut-off point is, but I think moving up
> to mid-2012 should be ok.

Yeah, I think this is the key thing. We can afford to be a bit more
aggressive with the doc toolchain requirements in general because
there's an easy fallback.

(Though I think even without that, it sounds like this version is pretty
safe, and the proposed change would not even break the old versions, but
keep them with the same behavior).

The overall proposal sounds like a good idea to me, as long as the
review comments I saw elsewhere.

-Peff
