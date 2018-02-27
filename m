Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D62811F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751722AbeB0VrP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:47:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:39452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751643AbeB0VrP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:47:15 -0500
Received: (qmail 8435 invoked by uid 109); 27 Feb 2018 21:47:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 21:47:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27642 invoked by uid 111); 27 Feb 2018 21:48:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 16:48:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 16:47:13 -0500
Date:   Tue, 27 Feb 2018 16:47:13 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] roll back locks in various code paths
Message-ID: <20180227214712.GD6899@sigill.intra.peff.net>
References: <cover.1519763396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519763396.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 10:30:08PM +0100, Martin Ågren wrote:

> Patches 2-4 are the actual fixes where I teach some functions to always
> roll back the lock they're holding. Notably, these are all in "libgit".
> 
> Patch 1 is a "while at it" to use locks on the stack instead of having
> them be static. Patch 5 removes code to roll back locks which are
> already rolled back.

These all look good to me. Happy to see us dropping the "static" from
more lockfiles, too.

-Peff
