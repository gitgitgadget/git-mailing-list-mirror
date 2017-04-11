Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 471EA209FA
	for <e@80x24.org>; Tue, 11 Apr 2017 19:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbdDKT0h (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 15:26:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:60249 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753122AbdDKT0g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 15:26:36 -0400
Received: (qmail 30993 invoked by uid 109); 11 Apr 2017 19:26:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 19:26:36 +0000
Received: (qmail 6222 invoked by uid 111); 11 Apr 2017 19:26:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 15:26:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 15:26:33 -0400
Date:   Tue, 11 Apr 2017 15:26:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v9 0/3] read-cache: speed up add_index_entry
Message-ID: <20170411192633.kprye72cqy4fggi7@sigill.intra.peff.net>
References: <20170411191702.20134-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411191702.20134-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 07:16:59PM +0000, git@jeffhostetler.com wrote:

> I think this version has addressed everything raise so far,
> so I think I'm ready to let this one rest.  Thanks for all
> the help and feedback.

Yeah, this addresses my nitpicks with the perf stuff. Thanks for
sticking with it.

-Peff
