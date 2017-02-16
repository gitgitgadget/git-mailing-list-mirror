Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCA071FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbdBPR1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:27:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:56523 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932193AbdBPR1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:27:35 -0500
Received: (qmail 8468 invoked by uid 109); 16 Feb 2017 17:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 17:27:35 +0000
Received: (qmail 25117 invoked by uid 111); 16 Feb 2017 17:27:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 12:27:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 12:27:33 -0500
Date:   Thu, 16 Feb 2017 12:27:33 -0500
From:   Jeff King <peff@peff.net>
To:     Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix l10n
Message-ID: <20170216172732.jmn7kju76i2suhev@sigill.intra.peff.net>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 02:28:26PM +0300, Maxim Moseychuk wrote:

> In some places static size buffers can't store formatted string.
> If it be happen then git die.
> 
> Maxim Moseychuk (3):
>   add git_psprintf helper function
>   bisect_next_all: convert xsnprintf to git_psprintf
>   stop_progress_msg: convert xsnprintf to git_psprintf

Thanks for providing a series (and I think this is your first series, so
welcome!).

The overall goal looks good, and I dropped a few comments in reply to
the individual patches.

-Peff
