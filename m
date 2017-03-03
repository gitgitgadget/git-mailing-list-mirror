Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD5A2023D
	for <e@80x24.org>; Fri,  3 Mar 2017 09:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdCCJRa (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 04:17:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:37817 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751083AbdCCJR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 04:17:29 -0500
Received: (qmail 1153 invoked by uid 109); 3 Mar 2017 04:46:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 04:46:33 +0000
Received: (qmail 24684 invoked by uid 111); 3 Mar 2017 04:46:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Mar 2017 23:46:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Mar 2017 23:46:30 -0500
Date:   Thu, 2 Mar 2017 23:46:30 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 5/9] Make read_early_config() reusable
Message-ID: <20170303044630.tfogzhzbokuoiwh6@sigill.intra.peff.net>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
 <cover.1488506615.git.johannes.schindelin@gmx.de>
 <64135c6df520c1ca6a6e667855ac03c14d2dd153.1488506615.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64135c6df520c1ca6a6e667855ac03c14d2dd153.1488506615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 03:04:20AM +0100, Johannes Schindelin wrote:

> The pager configuration needs to be read early, possibly before
> discovering any .git/ directory.
> 
> Let's not hide this function in pager.c, but make it available to other
> callers.
> [...]
> +	 * Note that this is a really dirty hack that does the wrong thing in
> +	 * many cases. The crux of the problem is that we cannot run

Makes sense. I'll assume the words "dirty hack" disappear from this
now-public function as you fix it up in a future patch. :)

-Peff
