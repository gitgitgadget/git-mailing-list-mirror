Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2066020970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753385AbdDKULr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:11:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:60311 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752984AbdDKULq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:11:46 -0400
Received: (qmail 2236 invoked by uid 109); 11 Apr 2017 20:11:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 20:11:44 +0000
Received: (qmail 6815 invoked by uid 111); 11 Apr 2017 20:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 16:12:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 16:11:41 -0400
Date:   Tue, 11 Apr 2017 16:11:41 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 0/2] string-list: use ALLOC_GROW macro when reallocing
Message-ID: <20170411201141.dfe4l2rn2oqxqvap@sigill.intra.peff.net>
References: <20170411200802.31638-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411200802.31638-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 08:08:00PM +0000, git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Version 4 greatly simplifies the p0005 perf test. It now uses an existing
> repo -- either real-world or artificial from t/perf/repos/many-files.sh.
> 
> Jeff Hostetler (2):
>   string-list: use ALLOC_GROW macro when reallocing string_list
>   p0005-status: time status on very large repo

Looks fine, though we may want to re-order when applying to introduce
p0005 before we show its output in the commit message of the other.
commit.

-Peff
