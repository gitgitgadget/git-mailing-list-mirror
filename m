Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C107DC433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 807BD60295
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 15:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhCOPcr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 11:32:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:36296 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231860AbhCOPc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 11:32:27 -0400
Received: (qmail 14416 invoked by uid 109); 15 Mar 2021 15:32:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Mar 2021 15:32:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15461 invoked by uid 111); 15 Mar 2021 15:32:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Mar 2021 11:32:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Mar 2021 11:32:26 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Ren=C3=A9_Scharfe=2E?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] vcs-svn: remove header files as well
Message-ID: <YE9+CvIs7PxX4Y8i@coredump.intra.peff.net>
References: <b937922d-8b56-c333-3f76-6e17a28210e3@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b937922d-8b56-c333-3f76-6e17a28210e3@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 14, 2021 at 03:37:39PM +0100, René Scharfe. wrote:

> fc47391e24 (drop vcs-svn experiment, 2020-08-13) removed most vcs-svn
> files.  Drop the remaining header files as well, as they are no longer
> used.

Oops, I don't know how I managed to miss these in my initial commit. It
definitely was not intentional. :)

They were present in the initial patch in 2018:

  https://lore.kernel.org/git/20180817190310.GA5360@sigill.intra.peff.net/

but when I later posted it as part of a series in 2020:

  https://lore.kernel.org/git/20200813150017.GE891370@coredump.intra.peff.net/

they were gone. I guess I must have made some mistake in rebasing it
forward over time. I'm not sure how, though.

Anyway, this is clearly the right thing to do. Thanks for noticing.

-Peff
