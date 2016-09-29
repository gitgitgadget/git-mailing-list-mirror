Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BFB520987
	for <e@80x24.org>; Thu, 29 Sep 2016 17:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934205AbcI2Rcp (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 13:32:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:49975 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933853AbcI2Rcn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 13:32:43 -0400
Received: (qmail 8463 invoked by uid 109); 29 Sep 2016 17:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 17:32:42 +0000
Received: (qmail 2797 invoked by uid 111); 29 Sep 2016 17:32:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 13:32:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 13:32:39 -0400
Date:   Thu, 29 Sep 2016 13:32:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] pretty: allow formatting names as initials
Message-ID: <20160929173239.c62vv3gtdoz3r6ij@sigill.intra.peff.net>
References: <20160929083315.vwb3aurwbyjwlkjn@sigill.intra.peff.net>
 <20160929083654.nofgkn6kwb7bavzk@sigill.intra.peff.net>
 <xmqq37kihatp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq37kihatp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 10:31:30AM -0700, Junio C Hamano wrote:

> > When I first tested it with "git log --format=%aS" I had to wonder "who
> > the heck is ntnd?". So using only the first-and-last would match the git
> > project's practice better, at least.
> 
> And there is also "isalpha() good enough?" question.
> 
> I think we have a few Chinese and Hangul as well as Cyrillic names
> in our history, some of them having outside-ascii first letters.
> One of the more prolific contributor's initial is ÆAB ;-)

Heh, true. In case it was not clear, these were mostly quick-and-dirty
patches. I think the right test is probably '!isspace()".

-Peff
