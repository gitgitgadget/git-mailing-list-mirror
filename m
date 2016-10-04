Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC1320986
	for <e@80x24.org>; Tue,  4 Oct 2016 15:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbcJDP36 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 11:29:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbcJDP36 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 11:29:58 -0400
Received: (qmail 29094 invoked by uid 109); 4 Oct 2016 15:29:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 15:29:57 +0000
Received: (qmail 6037 invoked by uid 111); 4 Oct 2016 15:30:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 11:30:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 11:29:55 -0400
Date:   Tue, 4 Oct 2016 11:29:55 -0400
From:   Jeff King <peff@peff.net>
To:     Sandro Santilli <strk@kbt.io>
Cc:     git@vger.kernel.org
Subject: Re: color.diff.whitespace unused on removed lines
Message-ID: <20161004152954.74bojbyagxr2xefz@sigill.intra.peff.net>
References: <20161004081429.GC17002@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004081429.GC17002@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 10:14:29AM +0200, Sandro Santilli wrote:

> The color.diff.whitespace configuration is not used on
> removed lines, but only on added lines.

Right. The original purpose was to warn you when you were introducing
whitespace breakages. Getting rid of other people's whitespace breakages
is OK.

We later did b8767f7 (diff.c: --ws-error-highlight=<kind> option,
2015-05-26) to let you see them on other lines, though. I think that
would do what you want.

-Peff
