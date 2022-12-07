Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9263C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 13:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLGNAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 08:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLGNAV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 08:00:21 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50063FAFB
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 05:00:20 -0800 (PST)
Received: (qmail 19275 invoked by uid 109); 7 Dec 2022 13:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 13:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1080 invoked by uid 111); 7 Dec 2022 13:00:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 08:00:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 08:00:18 -0500
From:   Jeff King <peff@peff.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid redefining system function names
Message-ID: <Y5COYn+/DGsb+Az2@coredump.intra.peff.net>
References: <20221125092339.29433-1-bagasdotme@gmail.com>
 <Y4RAr04vS/TOM5uh@coredump.intra.peff.net>
 <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>
 <Y4nN2h4FIYGNjCSI@debian.me>
 <Y4ncAhIqHkckMljb@coredump.intra.peff.net>
 <Y4sCfRdWAzjqw7cq@debian.me>
 <Y5BP95xjaA/9C70Q@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5BP95xjaA/9C70Q@debian.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 07, 2022 at 03:33:59PM +0700, Bagas Sanjaya wrote:

> Is your patch ready for v2.39?

It won't be in v2.39.0, as it came in during the release freeze, and
isn't fixing a regression during this cycle. Both patches are in 'next',
though, and will likely be part of the next maint release (2.39.1).

-Peff
