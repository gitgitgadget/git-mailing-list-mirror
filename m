Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9181F597
	for <e@80x24.org>; Tue, 24 Jul 2018 21:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbeGXW3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 18:29:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:58358 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388471AbeGXW3u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 18:29:50 -0400
Received: (qmail 1600 invoked by uid 109); 24 Jul 2018 21:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 21:21:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1431 invoked by uid 111); 24 Jul 2018 21:21:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 17:21:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 17:21:26 -0400
Date:   Tue, 24 Jul 2018 17:21:26 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180724212126.GB17803@sigill.intra.peff.net>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724151336.GA1957@duynguyen.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724151336.GA1957@duynguyen.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 05:13:36PM +0200, Duy Nguyen wrote:

> I guess you have the starting points you need after Jeff's and Junio's
> explanation (and it would be great if cache-tree could actually be for
> for this two-way merge). But to make it easier for new people in
> future, maybe we should add this?
> 
> This is basically a ripoff of Junio's explanation with starting points
> (write-tree and index-format.txt). I wanted to incorporate some pieces
> from Jeff's too but I think Junio's already covered it well.
> 
> -- 8< --
> Subject: [PATCH] cache-tree.h: more description of what it is and what's it used for

There is some discussion of this extension in
Documentation/technical/index-format.txt. But it's mostly the mechanical
bits, not how or why you would use it.

I like the idea of putting this explanation into the repo, though a lot
of it is pretty specific to "diff-index --cached", which could
potentially grow stale.

-Peff
