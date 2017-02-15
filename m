Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBEC02013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752480AbdBOVaQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:30:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:55988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbdBOVaP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:30:15 -0500
Received: (qmail 23089 invoked by uid 109); 15 Feb 2017 21:30:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:30:15 +0000
Received: (qmail 17613 invoked by uid 111); 15 Feb 2017 21:30:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:30:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:30:13 -0500
Date:   Wed, 15 Feb 2017 16:30:13 -0500
From:   Jeff King <peff@peff.net>
To:     Serdar Sahin <serdar@peakgames.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Non-zero exit code without error
Message-ID: <20170215213013.kohh263sauixf2sk@sigill.intra.peff.net>
References: <CAL7ZE5xYVM6=C+SJLJ2HMFZ2gvuduw8p0UnS0RnBaXibj0mgDw@mail.gmail.com>
 <CAP8UFD18Sbqo-_ZVyYTJtwNaRc8bFSd0KEYQ1oRH7-G+xnJTJg@mail.gmail.com>
 <CAL7ZE5yXaJQFci+9aF4+cxeycnf71FMyLTV14t_TGDR3cnnfVA@mail.gmail.com>
 <CAP8UFD3uEAuK5SQD8V8f4GC3-jC+ix2sPwiFBw_kW3JhBG6L=g@mail.gmail.com>
 <BE964323A3E644BBB01F8672263419EA@peakgames.net>
 <CAL7ZE5y5wgJfkwn0sAwVPtHhEXuX7tUc-pNkOor1WzAx_u3WhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL7ZE5y5wgJfkwn0sAwVPtHhEXuX7tUc-pNkOor1WzAx_u3WhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:56:02AM +0300, Serdar Sahin wrote:

> Just to see, if GIT server causes some issues, I’ve pushed to repo to
> github public as a private repo, and can reproduce the issue there as
> well.

FWIW, that server will be running roughly the same version of Git that
is on your GitHub Enterprise install.

I doubt the server version is relevant, though. No matter what the
server does, if the client is exiting non-zero without indicating why, I
think the client needs to be fixed.

-Peff
