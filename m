Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 087222098B
	for <e@80x24.org>; Tue, 18 Oct 2016 11:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759965AbcJRLBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 07:01:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:58789 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759923AbcJRLBf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 07:01:35 -0400
Received: (qmail 17692 invoked by uid 109); 18 Oct 2016 11:01:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Oct 2016 11:01:34 +0000
Received: (qmail 4456 invoked by uid 111); 18 Oct 2016 11:01:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 18 Oct 2016 07:01:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Oct 2016 07:01:32 -0400
Date:   Tue, 18 Oct 2016 07:01:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, strk@kbt.io
Subject: Re: [PATCH 0/4] diff.wsErrorHighlight configuration variable
Message-ID: <20161018110132.ehomp2rolb5q2npl@sigill.intra.peff.net>
References: <xmqqk2douhe0.fsf@gitster.mtv.corp.google.com>
 <20161004225449.6759-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004225449.6759-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 03:54:45PM -0700, Junio C Hamano wrote:

> "git diff" and its family of commands have "--ws-error-highlight"
> option to allow whitespace breakages on old and context lines
> painted in color.diff.whitespace color, instead of the usual "we
> paint breakages only on new lines", but there wasn't a configuration
> variable that corresponds to it.
> 
> This would be a lot closer to a series that could be acceptable,
> compared to the previous "it should look like this" patch.
> 
> Junio C Hamano (4):
>   t4015: split out the "setup" part of ws-error-highlight test
>   diff.c: refactor parse_ws_error_highlight()
>   diff.c: move ws-error-highlight parsing helpers up
>   diff: introduce diff.wsErrorHighlight option

This topic got stuck in my dreaded "to review" pile and I forgot about
it. I see you've already marked it for merging to master, but FWIW, I
read it over and did not see any problems.

-Peff
