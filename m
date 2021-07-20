Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE360C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BB56113B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 20:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGTTXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 15:23:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:55304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhGTTXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 15:23:05 -0400
Received: (qmail 4769 invoked by uid 109); 20 Jul 2021 20:03:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 20 Jul 2021 20:03:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26753 invoked by uid 111); 20 Jul 2021 20:03:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 20 Jul 2021 16:03:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 20 Jul 2021 16:03:41 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] doc/git-config: explain --file instead of referring
 to GIT_CONFIG
Message-ID: <YPcsHdTY0tIa4+xo@coredump.intra.peff.net>
References: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
 <YO9ZGTX9f1fOpTkh@coredump.intra.peff.net>
 <CAN0heSoz8KmmtX8LVcY2wBM6Fm4TAYwDmQGPE8wpdZTmWRVzWA@mail.gmail.com>
 <YPcrslQNmqvlBYpX@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPcrslQNmqvlBYpX@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 20, 2021 at 04:01:55PM -0400, Jeff King wrote:

> I double-checked the rest of the series for other spelling errors but
> didn't see any. This is marked for merging to next, but hasn't made it
> yet. So if you get this in time, Junio, can you please squash this into
> the first patch?

I should say: the first patch of jk/config-env-doc to hopefully make it
easier. :)

-Peff
