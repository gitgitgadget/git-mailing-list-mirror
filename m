Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381E320A29
	for <e@80x24.org>; Wed, 27 Sep 2017 22:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdI0WtM (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 18:49:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:52848 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751671AbdI0WtM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 18:49:12 -0400
Received: (qmail 3370 invoked by uid 109); 27 Sep 2017 22:49:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 22:49:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21005 invoked by uid 111); 27 Sep 2017 22:49:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 27 Sep 2017 18:49:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2017 18:49:10 -0400
Date:   Wed, 27 Sep 2017 18:49:10 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] diff: correct newline in summary for renamed files
Message-ID: <20170927224909.25dfojhx6wzaqwt7@sigill.intra.peff.net>
References: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
 <20170927215852.20163-1-sbeller@google.com>
 <20170927220925.u622metv2fcdtcfq@sigill.intra.peff.net>
 <20170927223239.t6gvfztkdjn2vltb@sigill.intra.peff.net>
 <CAGZ79kYAfii=vwXwSkx-QE+tXSfPE5h1c39gZSB=c5Asfq9P3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYAfii=vwXwSkx-QE+tXSfPE5h1c39gZSB=c5Asfq9P3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 03:39:00PM -0700, Stefan Beller wrote:

> On Wed, Sep 27, 2017 at 3:32 PM, Jeff King <peff@peff.net> wrote:
> 
> > The most appropriate place seems like t4013. I tried adding to its big
> > list of tested formats, but it's quite fragile. The patch below is what
> > I came up with, but it still needs updated to cover the cases which call
> > "log --all".
> >
> > I think we'd do better to just do a set of new tests at the end (or even
> > a new test script for diffing mode changes in various formats).
> 
> Thanks for providing this patch, I think it is actually reasonable to
> do it here. I can fixup the rest if you don't mind.

OK. Please go ahead, then.

-Peff
