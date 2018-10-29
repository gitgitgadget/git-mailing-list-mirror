Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35B511F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ2XG5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 19:06:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:58962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726007AbeJ2XG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 19:06:57 -0400
Received: (qmail 20161 invoked by uid 109); 29 Oct 2018 14:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 29 Oct 2018 14:18:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17883 invoked by uid 111); 29 Oct 2018 14:17:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 29 Oct 2018 10:17:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Oct 2018 10:18:05 -0400
Date:   Mon, 29 Oct 2018 10:18:05 -0400
From:   Jeff King <peff@peff.net>
To:     Gray King <grayking.w@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Lost changes after merge
Message-ID: <20181029141804.GC17668@sigill.intra.peff.net>
References: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP1N1j7P83XVPx6dDGMSeRbwjdixAdBNZab=TP94=9LSfmsrRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 09:49:20AM +0100, Gray King wrote:

> Hello,
> 
>   I have a very strange issue described below:
> 
> * Here is the tree before I merge via `git log --format="%h %p %d" -n
> 20 --all --graph`:
> 
> https://upaste.de/9Pe

FWIW, neither this nor the other paste link in your email seem to work
for me (which makes it hard to comment on the rest of the email).

-Peff
