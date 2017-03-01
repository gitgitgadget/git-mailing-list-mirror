Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02712023D
	for <e@80x24.org>; Wed,  1 Mar 2017 19:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752975AbdCATOg (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 14:14:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:36554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752492AbdCATOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 14:14:33 -0500
Received: (qmail 5582 invoked by uid 109); 1 Mar 2017 19:07:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 19:07:13 +0000
Received: (qmail 6914 invoked by uid 111); 1 Mar 2017 19:07:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 14:07:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 14:07:11 -0500
Date:   Wed, 1 Mar 2017 14:07:11 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170301190711.nwlretmy6w675jvp@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 04:30:26PM -0800, Linus Torvalds wrote:

> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 28 Feb 2017 16:12:32 -0800
> Subject: [PATCH] Put sha1dc on a diet
> 
> This removes the unnecessary parts of the sha1dc code, shrinking things from
> [...]

So obviously the smaller object size is nice, and the diffstat is
certainly satisfying. My only qualm would be whether this conflicts with
the optimizations that Dan is working on (probably not conceptually, but
textually).

-Peff
