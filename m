Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EAB209FD
	for <e@80x24.org>; Thu, 25 May 2017 18:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1036370AbdEYSal (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 14:30:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:58011 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033504AbdEYSal (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 14:30:41 -0400
Received: (qmail 21188 invoked by uid 109); 25 May 2017 18:30:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 18:30:40 +0000
Received: (qmail 22018 invoked by uid 111); 25 May 2017 18:31:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 May 2017 14:31:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 May 2017 14:30:38 -0400
Date:   Thu, 25 May 2017 14:30:38 -0400
From:   Jeff King <peff@peff.net>
To:     Adrian Forbes <forbesa06@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation issue: git-stash examples
Message-ID: <20170525183037.tu7vaja25b7vgjfe@sigill.intra.peff.net>
References: <CAOJu4w-4eCkt9Co19BmyTQ7NF+rf23LU8ANCTCcmPP84efdjeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOJu4w-4eCkt9Co19BmyTQ7NF+rf23LU8ANCTCcmPP84efdjeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 25, 2017 at 09:52:42PM +1200, Adrian Forbes wrote:

> Some of the example commands in git-stash documentation should be
> written as comments rather than actual commands:
> https://cloud.githubusercontent.com/assets/24915363/26444394/5cf6a754-4190-11e7-845e-135288c8916e.png
> 
> For example, `$ edit emergency fix` should be `# ... edit emergency
> fix ...` like the other comments in the section.
> 
> It could be misleading for novices.

Yeah, I think that's a good idea. Do you want to try your hand at a
patch?

-Peff
