Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F9520C32
	for <e@80x24.org>; Fri,  8 Dec 2017 08:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbdLHIOA (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 03:14:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:51820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752640AbdLHIN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 03:13:58 -0500
Received: (qmail 27484 invoked by uid 109); 8 Dec 2017 08:13:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Dec 2017 08:13:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29999 invoked by uid 111); 8 Dec 2017 08:14:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 08 Dec 2017 03:14:20 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Dec 2017 03:13:56 -0500
Date:   Fri, 8 Dec 2017 03:13:56 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs/pretty-formats: mention commas in %(trailers) syntax
Message-ID: <20171208081356.GA24991@sigill.intra.peff.net>
References: <20171208051636.GA24693@sigill.intra.peff.net>
 <CAPig+cTdFSZziq9Mi7HHa+UcG3V9AwvWy1EpFoCLfT_9Fi+eKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTdFSZziq9Mi7HHa+UcG3V9AwvWy1EpFoCLfT_9Fi+eKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 08, 2017 at 03:10:34AM -0500, Eric Sunshine wrote:

> On Fri, Dec 8, 2017 at 12:16 AM, Jeff King <peff@peff.net> wrote:
> > Commit 84ff053d47 (pretty.c: delimit "%(trailers)" arguments
> > with ",", 2017-10-01) switched the syntax of the trailers
> > placeholder, but forgot to update the documentation in
> > pretty-formats.txt.
> >
> > There's need to mention the old syntax; it was never in a
> 
> I suppose you mean: s/need/no need/

Yes, indeed. Thanks.

-Peff
