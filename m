Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB0E1F424
	for <e@80x24.org>; Wed, 28 Mar 2018 08:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeC1Iso (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 04:48:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:45716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752447AbeC1Ism (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 04:48:42 -0400
Received: (qmail 11165 invoked by uid 109); 28 Mar 2018 08:48:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 08:48:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6040 invoked by uid 111); 28 Mar 2018 08:49:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 04:49:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 04:48:39 -0400
Date:   Wed, 28 Mar 2018 04:48:39 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] shortlog: do not accept revisions when run outside
 repo
Message-ID: <20180328084839.GA31002@sigill.intra.peff.net>
References: <cover.1520680894.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1520680894.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 10, 2018 at 12:52:09PM +0100, Martin Ågren wrote:

> Someone trying this out might notice that `man git-shortlog` renders
> "\--" as "\--", which is not wanted. (Also visible on git-scm.com...)
> There is quite some history around such double-slashes and compatibility
> with AsciiDoc-versions, so I'd rather not do a "while at it" there.
> Regardless of the destiny of patch 1/3, I will follow up later to
> address various forms of "\--" throughout the tree.

I didn't see any follow-up here, but in case you were delaying because
the history search seemed boring: dropping the backslash is the right
thing to do.  See the discussion in 1c262bb7b2 (doc: convert \--option
to --option, 2015-05-13).

-Peff
