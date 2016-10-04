Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38E5F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754069AbcJDQN2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:13:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:52100 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752590AbcJDQN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:13:27 -0400
Received: (qmail 31947 invoked by uid 109); 4 Oct 2016 16:13:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 16:13:26 +0000
Received: (qmail 6639 invoked by uid 111); 4 Oct 2016 16:13:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 12:13:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 12:13:24 -0400
Date:   Tue, 4 Oct 2016 12:13:24 -0400
From:   Jeff King <peff@peff.net>
To:     Sandro Santilli <strk@kbt.io>
Cc:     git@vger.kernel.org
Subject: Re: color.diff.whitespace unused on removed lines
Message-ID: <20161004161323.53qec37i2tujaxcy@sigill.intra.peff.net>
References: <20161004081429.GC17002@localhost>
 <20161004152954.74bojbyagxr2xefz@sigill.intra.peff.net>
 <20161004153523.GA2798@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161004153523.GA2798@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 05:35:23PM +0200, Sandro Santilli wrote:

> > We later did b8767f7 (diff.c: --ws-error-highlight=<kind> option,
> > 2015-05-26) to let you see them on other lines, though. I think that
> > would do what you want.
> 
> Thanks, it does do what I want.
> Any chance to specify it in the config file that I want it
> always to behave in a certain way ?

No, I don't think there's currently a matching config option. You can
use an alias, or propose a patch to add a config option.

-Peff
