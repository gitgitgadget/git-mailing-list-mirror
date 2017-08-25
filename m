Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2BB208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 14:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932901AbdHYODb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 10:03:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:49036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S933028AbdHYODa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 10:03:30 -0400
Received: (qmail 22417 invoked by uid 109); 25 Aug 2017 14:03:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 14:03:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18540 invoked by uid 111); 25 Aug 2017 14:03:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Aug 2017 10:03:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Aug 2017 07:03:27 -0700
Date:   Fri, 25 Aug 2017 07:03:27 -0700
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sha1-lookup: remove sha1_entry_pos() from header file
Message-ID: <20170825140326.lkjqkdevaaelwyyg@sigill.intra.peff.net>
References: <20170825073613.13853-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825073613.13853-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 09:36:13AM +0200, Christian Couder wrote:

> Since f1068efefe (sha1_file: drop experimental GIT_USE_LOOKUP search, 2017-08-09)
> the definition of sha1_entry_pos() has been removed from "sha1-lookup.c", so
> there is no need anymore for its declaration in "sha1-lookup.h".

Doh, thanks for catching.

Patch is obviously good.

-Peff
