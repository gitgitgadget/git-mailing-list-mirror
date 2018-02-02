Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF011F576
	for <e@80x24.org>; Fri,  2 Feb 2018 06:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750871AbeBBGvu (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 01:51:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:37998 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750773AbeBBGvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 01:51:49 -0500
Received: (qmail 4265 invoked by uid 109); 2 Feb 2018 06:51:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Feb 2018 06:51:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16512 invoked by uid 111); 2 Feb 2018 06:52:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Feb 2018 01:52:29 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Feb 2018 01:51:47 -0500
Date:   Fri, 2 Feb 2018 01:51:47 -0500
From:   Jeff King <peff@peff.net>
To:     timothee.cour2@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: how to ignore whitespace changes with --color-moved (git diff
 move detection)?
Message-ID: <20180202065146.GA16533@sigill.intra.peff.net>
References: <CANri+EwfsgS-s0TeeX0E6XoCnmCeq=CB0UDQ9=gjSXbe8C_5GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANri+EwfsgS-s0TeeX0E6XoCnmCeq=CB0UDQ9=gjSXbe8C_5GQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 01, 2018 at 06:13:52PM -0800, Timothee Cour wrote:

> this PR from october 2017 was discussing a patch that'd introduce
> `--color-moved-[no-]ignore-space-change`
> https://public-inbox.org/git/20171025224620.27657-3-sbeller@google.com/
> 
> however not sure what happened since then as I can't find in `git help
> diff` options even after `brew install --HEAD git`
> 
> it's a really useful feature as it's a common use case (ppl move
> blocks and reformat in same PR)

I think you can still do "--color-moved -w" to ignore whitespace. It's
just that the defaults did not end up getting flipped.

-Peff
