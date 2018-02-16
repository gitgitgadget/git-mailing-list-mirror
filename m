Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C121F404
	for <e@80x24.org>; Fri, 16 Feb 2018 18:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752429AbeBPSf1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 13:35:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:55354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752231AbeBPSf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:35:26 -0500
Received: (qmail 15354 invoked by uid 109); 16 Feb 2018 18:35:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Feb 2018 18:35:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20735 invoked by uid 111); 16 Feb 2018 18:36:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Feb 2018 13:36:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2018 13:35:23 -0500
Date:   Fri, 16 Feb 2018 13:35:23 -0500
From:   Jeff King <peff@peff.net>
To:     Genki Sky <sky@genki.is>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: unset XDG_CACHE_HOME
Message-ID: <20180216183523.GA22021@sigill.intra.peff.net>
References: <6f102a37a06940f6feeeb0c8807ac98a850b7a3b.1518748907.git.sky@genki.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f102a37a06940f6feeeb0c8807ac98a850b7a3b.1518748907.git.sky@genki.is>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 09:46:04PM -0500, Genki Sky wrote:

> git respects XDG_CACHE_HOME for the credential cache. So, we should
> unset XDG_CACHE_HOME for the test environment, lest a user's custom one
> cause failure in the test.
> 
> For example, t/t0301-credential-cache.sh expects a default directory
> to be used if it hasn't explicitly set XDG_CACHE_HOME.

Yep, this makes perfect sense. I can't believe it took almost a year for
somebody to trigger this. I guess most people don't set XDG_CACHE_HOME.

Thanks.

-Peff
