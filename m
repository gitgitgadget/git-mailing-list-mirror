Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B882C201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753080AbdEODIg (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:08:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:51652 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbdEODIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:08:35 -0400
Received: (qmail 17983 invoked by uid 109); 15 May 2017 03:08:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 03:08:35 +0000
Received: (qmail 12668 invoked by uid 111); 15 May 2017 03:09:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 14 May 2017 23:09:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 May 2017 23:08:33 -0400
Date:   Sun, 14 May 2017 23:08:33 -0400
From:   Jeff King <peff@peff.net>
To:     Brian Malehorn <bmalehorn@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] interpret-trailers: obey scissors lines
Message-ID: <20170515030833.i4g2e6mx3bjrha3u@sigill.intra.peff.net>
References: <20170514035652.rn5npxxflku6s5k4@sigill.intra.peff.net>
 <20170514083349.24979-1-bmalehorn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170514083349.24979-1-bmalehorn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 14, 2017 at 01:33:48AM -0700, Brian Malehorn wrote:

> > And two, we usually indent the contents to the same level as the outer
> > cat/EOF pair
> 
> Fixed.
> 
> I was indenting the same as the other tests in that file. But if the way
> you described is the preferred way, then sure.

Doh. I didn't notice that. That file _is_ unlike the rest of the code
base, but it's generally OK to match the style of surrounding code.

-Peff
