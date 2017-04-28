Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665521FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424644AbdD1H7g (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 03:59:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:41523 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424611AbdD1H7f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 03:59:35 -0400
Received: (qmail 1804 invoked by uid 109); 28 Apr 2017 07:59:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 07:59:34 +0000
Received: (qmail 17337 invoked by uid 111); 28 Apr 2017 08:00:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 04:00:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 03:59:32 -0400
Date:   Fri, 28 Apr 2017 03:59:32 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] Make the indent heuristic part of diff's basic
 configuration.
Message-ID: <20170428075932.vnngf3pbl4oh2fta@sigill.intra.peff.net>
References: <20170427205037.1787-1-marcnarc@xiplink.com>
 <20170427205037.1787-2-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427205037.1787-2-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 04:50:36PM -0400, Marc Branchaud wrote:

> Subject: [PATCH 1/2] Make the indent heuristic part of diff's basic configuration.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>

This needs to be explained better. Why were the options originally in
UI config, and why is it OK to move them to the basic config?

I think the argument is along the lines of "scripts shouldn't care
because the result is syntactically identical, and we reserve the right
to find any valid diff".

Also, our subject lines usually do not start with a capital, nor end
with a period. We usually try to specify the subsystem with a colon.
Like:

  diff: move indent heuristic to "basic" config

or similar.

-Peff
