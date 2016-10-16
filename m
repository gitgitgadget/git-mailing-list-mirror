Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AF32098B
	for <e@80x24.org>; Sun, 16 Oct 2016 21:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbcJPVYS (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 17:24:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58108 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753402AbcJPVYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 17:24:16 -0400
Received: (qmail 1779 invoked by uid 109); 16 Oct 2016 21:17:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 21:17:35 +0000
Received: (qmail 23995 invoked by uid 111); 16 Oct 2016 21:17:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Oct 2016 17:17:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Oct 2016 17:17:33 -0400
Date:   Sun, 16 Oct 2016 17:17:33 -0400
From:   Jeff King <peff@peff.net>
To:     Howard Johnson <hwj@BridgeportContractor.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: link broken on git man page
Message-ID: <20161016211732.isiosoqe3zkxb7pq@sigill.intra.peff.net>
References: <db083f89-b502-fe61-ce62-e7c4701f8764@BridgeportContractor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <db083f89-b502-fe61-ce62-e7c4701f8764@BridgeportContractor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 16, 2016 at 01:42:12PM -0700, Howard Johnson wrote:

> This link below is broken in the man page.  (I'm on Debian Jessie).
> [...]
>        Formatted and hyperlinked version of the latest Git documentation can
>        be viewed at http://git-htmldocs.googlecode.com/git/git.html.

This is fixed already in f793582 (doc: git-htmldocs.googlecode.com is no
more, 2016-06-22), which is in git v2.9.1. Debian testing/unstable are
at v2.9.3, but Jessie is still on v2.1.4.

I don't know the policy for cherry-picking patches to Debian stable
releases. I think only security fixes are done immediately, but
"important" fixes get rolled into stable updates every few months.
I don't know that this is "important", but it does point to information
that grew stale outside of the release's control, and as a trivial
documentation-only change, it shouldn't cause a regression.

+cc Jonathan, who works on git packaging for Debian.

-Peff
