Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A76201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 20:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbdBYUu5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:50:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:34184 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751899AbdBYUu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:50:56 -0500
Received: (qmail 5411 invoked by uid 109); 25 Feb 2017 20:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 20:50:55 +0000
Received: (qmail 22919 invoked by uid 111); 25 Feb 2017 20:51:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 15:51:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 15:50:53 -0500
Date:   Sat, 25 Feb 2017 15:50:53 -0500
From:   Jeff King <peff@peff.net>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-clone --config order & fetching extra refs during initial
 clone
Message-ID: <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Re-sending, as I used an old address for Gábor on the original]

On Sat, Feb 25, 2017 at 07:12:38PM +0000, Robin H. Johnson wrote:

> TL;DR: git-clone ignores any fetch specs passed via --config.

I agree that this is a bug. There's some previous discussion and an RFC
patch from lat March (author cc'd):

  http://public-inbox.org/git/1457313062-10073-1-git-send-email-szeder@ira.uka.de/

That discussion veered off into alternatives, but I think the v2 posted
in that thread is taking a sane approach.

-Peff
