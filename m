Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1002027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751291AbdFBUPg (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:15:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:34067 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751147AbdFBUPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:15:35 -0400
Received: (qmail 30494 invoked by uid 109); 2 Jun 2017 20:15:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 20:15:35 +0000
Received: (qmail 31100 invoked by uid 111); 2 Jun 2017 20:16:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Jun 2017 16:16:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jun 2017 16:15:33 -0400
Date:   Fri, 2 Jun 2017 16:15:33 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision.c: use skip_prefix() in
 handle_revision_opt()
Message-ID: <20170602201533.bw4cmsqsygfdif2o@sigill.intra.peff.net>
References: <20170602191010.16834-1-szeder.dev@gmail.com>
 <20170602191010.16834-3-szeder.dev@gmail.com>
 <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170602201143.6avkhp224no3dukb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 02, 2017 at 04:11:43PM -0400, Jeff King wrote:

>   if (match_opt(arg, "--early-output"), &optarg)) {
> 	int count = optarg ? atoi(optarg) : 100;
> 	...
>   }
> 
> which is a little nicer and could maybe help other options (I didn't see
> any, though).

I take it back. This would help --show-linear-break that your patch also
touches. And maybe --pretty, too.

-Peff
