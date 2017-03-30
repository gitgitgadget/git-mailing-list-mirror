Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E34320966
	for <e@80x24.org>; Thu, 30 Mar 2017 20:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbdC3UjV (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 16:39:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:54407 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754435AbdC3UjU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 16:39:20 -0400
Received: (qmail 28851 invoked by uid 109); 30 Mar 2017 20:39:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 20:39:18 +0000
Received: (qmail 2506 invoked by uid 111); 30 Mar 2017 20:39:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 16:39:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 16:39:16 -0400
Date:   Thu, 30 Mar 2017 16:39:16 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/2] read-cache: call verify_hdr() in a background
 thread
Message-ID: <20170330203916.ckp62syupioo3hxc@sigill.intra.peff.net>
References: <20170328190732.59486-1-git@jeffhostetler.com>
 <20170328191628.dprziuhpv7khvocu@sigill.intra.peff.net>
 <35f220df-aa63-b80f-8970-429850202cdd@jeffhostetler.com>
 <20170328195605.xy4pnhy74s6wgwps@sigill.intra.peff.net>
 <20170330200648.GH27158@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170330200648.GH27158@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 09:06:48PM +0100, Thomas Gummerer wrote:

> > Yeah, I think that would be fine. You _could_ write a t/perf test and
> > then use your 400MB monstrosity as GIT_PERF_LARGE_REPO. But given that
> > most people don't have such a thing, there's not much value over you
> > just showing off the perf improvement in the commit message.
> 
> Sorry if this was already discussed, but we already do have a perf
> test for the index (p0002), and a corresponding helper program which
> just does read_cache() and discard_cache().  Maybe we could re-use
> that and add a second test running the same using the new config?

Oh, indeed. Yes, I would think the results of p0002 would probably show
off Jeff's improvements.

-Peff
