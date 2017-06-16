Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D708C1FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 12:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbdFPMQq (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:16:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:41470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbdFPMQp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:16:45 -0400
Received: (qmail 15583 invoked by uid 109); 16 Jun 2017 12:16:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 12:16:45 +0000
Received: (qmail 4353 invoked by uid 111); 16 Jun 2017 12:16:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 08:16:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 08:16:43 -0400
Date:   Fri, 16 Jun 2017 08:16:43 -0400
From:   Jeff King <peff@peff.net>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, houstonfortney@gmail.com,
        kostix+git@007spb.ru, sxlijin@gmail.com
Subject: Re: [PATCH 0/3] add stash count information to git-status command
Message-ID: <20170616121642.jqsua5sw2u2iccdf@sigill.intra.peff.net>
References: <20170616043050.29192-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616043050.29192-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 12:30:47AM -0400, Liam Beguin wrote:

> As discussed here [*1*], this allows `git status` to show the number of
> entries currently stashed away.
> 
> I also tried to update the related parts of the documentation to use
> 'stash entry' instead of 'stash' as we agreed that it was a bit better.
> I don't mind dropping the documentation update and using something like
> "You have %d stash/stashes" in the status message if it makes the change
> "too big".

I like the overall direction (including the documentation update). I
noted a few minor problems in the various patches, though.

-Peff
