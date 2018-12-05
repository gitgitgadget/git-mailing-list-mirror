Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E107B211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 04:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLEEGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 23:06:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:59298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726950AbeLEEF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 23:05:59 -0500
Received: (qmail 28374 invoked by uid 109); 5 Dec 2018 04:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Dec 2018 04:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27539 invoked by uid 111); 5 Dec 2018 04:05:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 04 Dec 2018 23:05:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Dec 2018 23:05:57 -0500
Date:   Tue, 4 Dec 2018 23:05:57 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>, git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.20.0-rc2
Message-ID: <20181205040557.GA9325@sigill.intra.peff.net>
References: <xmqq36rhjnts.fsf@gitster-ct.c.googlers.com>
 <87in09ytd2.fsf@evledraar.gmail.com>
 <CAGZ79kZPXoST3Jfmd06ALV3BGX+yd5rYKUhVkWpHmj94Kit-wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZPXoST3Jfmd06ALV3BGX+yd5rYKUhVkWpHmj94Kit-wQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 06:48:22PM -0800, Stefan Beller wrote:

> > Perhaps we should note this more prominently, and since Brandon isn't at
> > Google anymore can some of you working there edit this post? It's the
> > first Google result for "git protocol v2", so it's going to be quite
> > confusing for people if after 2.20 the instructions in it no longer
> > work.
> 
> Thanks for pointing this out, we missed the implications when that patch was
> discussed. Looking into it.

I think if it just does "ls-remote --heads", that would still prove the
point (it would omit all of the tags).

-Peff
