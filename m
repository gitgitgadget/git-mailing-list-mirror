Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 591AE20798
	for <e@80x24.org>; Sat, 14 Jan 2017 18:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbdANSIW (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 13:08:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:39245 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751380AbdANSIV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 13:08:21 -0500
Received: (qmail 20704 invoked by uid 109); 14 Jan 2017 18:08:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Jan 2017 18:08:21 +0000
Received: (qmail 14401 invoked by uid 111); 14 Jan 2017 18:09:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Jan 2017 13:09:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jan 2017 13:08:18 -0500
Date:   Sat, 14 Jan 2017 13:08:18 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCHv3 2/2] builtin/commit.c: switch to xstrfmt(), instead of
 snprintf,
Message-ID: <20170114180818.wrnltwwlypjmiuh3@sigill.intra.peff.net>
References: <20170113175801.39468-1-gitter.spiros@gmail.com>
 <20170113175801.39468-2-gitter.spiros@gmail.com>
 <3165803b-6073-de97-bf33-71ad21108d6f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3165803b-6073-de97-bf33-71ad21108d6f@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2017 at 05:31:39PM +0100, René Scharfe wrote:

> Perhaps I missed it from the discussion, but why not use strbuf?  It
> would avoid counting the generated string's length.  That's probably
> not going to make a measurable difference performance-wise, but it's
> easy to avoid and doesn't even take up more lines:

It was mentioned in the review of the very first patch, but I think it
just got dropped. I agree the strbuf way is nicer (not because of
efficiency, but because it's simply easier to read and follow).

-Peff
