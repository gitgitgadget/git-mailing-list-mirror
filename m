Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D5E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 17:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbeHMU36 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 16:29:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:53132 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730439AbeHMU36 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 16:29:58 -0400
Received: (qmail 8874 invoked by uid 109); 13 Aug 2018 17:46:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 17:46:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10468 invoked by uid 111); 13 Aug 2018 17:46:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 13:46:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 13:46:43 -0400
Date:   Mon, 13 Aug 2018 13:46:43 -0400
From:   Jeff King <peff@peff.net>
To:     Samuel Maftoul <samuel.maftoul@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [RFC] implement branch.sort config option
Message-ID: <20180813174643.GA8790@sigill.intra.peff.net>
References: <CAFj+z06S1V3Z7Z0zKPSrpZfWuzku9PTYjG+uu6ig-yCnG4FCLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFj+z06S1V3Z7Z0zKPSrpZfWuzku9PTYjG+uu6ig-yCnG4FCLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 11:56:58AM +0200, Samuel Maftoul wrote:

> Currently, you can:
> 
> git tag --sort=$sorting_key
> 
> You can also do this on branches:
> 
> git branch --sort=$sorting_key
> 
> For tags, you can also configure it with a config key:
> 
> git config tag.sort $sorting_key
> 
> But there is no corresponding config for sorting branches.
> 
> Locally, I have a (pretty simple) patch that implements the
> branch.sort config key.
> Should I contribute that ?

Yes, that seems like a useful feature to me, and as you point out it
makes the overall interface more consistent.

-Peff
