Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7C41FCA5
	for <e@80x24.org>; Wed, 28 Dec 2016 08:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbcL1Iww (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Dec 2016 03:52:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:60960 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbcL1Iwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2016 03:52:51 -0500
Received: (qmail 13328 invoked by uid 109); 28 Dec 2016 08:52:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 08:52:51 +0000
Received: (qmail 17128 invoked by uid 111); 28 Dec 2016 08:53:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Dec 2016 03:53:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Dec 2016 03:52:48 -0500
Date:   Wed, 28 Dec 2016 03:52:48 -0500
From:   Jeff King <peff@peff.net>
To:     "John P. Hartmann" <jphartmann@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: HowTo distribute a hook with the reposity.
Message-ID: <20161228085248.tu54e6ug5fvpr26l@sigill.intra.peff.net>
References: <6e228b75-0208-63e8-b4e8-70905e3f9ea3@gmail.com>
 <CA+P7+xqHTgRvMRwgL2TJ7SRb_SR0sbtA039J_5N0xSjf3TNrgg@mail.gmail.com>
 <20161228060840.gelgcs2hd33id56j@sigill.intra.peff.net>
 <6801f971-418d-18c9-8002-9c2f7b8c8008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6801f971-418d-18c9-8002-9c2f7b8c8008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 28, 2016 at 08:42:25AM +0000, John P. Hartmann wrote:

> This project is hosted on github.  If I put the hook into the repository
> manually (if I can; I don't know that), is it true that the hook would be
> distributed on a clone action, but not on a pull?

I'm not sure what you mean by "into the repository". If you mean "into
the .git directory", then no, you can't do that. Git will not add ".git"
directory contents to a repository, you cannot manipulate the contents
of ".git" directories on GitHub, and a client wouldn't ever look at them
on clone or fetch anyway.

Did you mean something else?

-Peff
