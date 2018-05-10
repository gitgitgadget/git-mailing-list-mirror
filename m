Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0999A1F424
	for <e@80x24.org>; Thu, 10 May 2018 04:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756268AbeEJExO (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 00:53:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:34322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755614AbeEJExN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 00:53:13 -0400
Received: (qmail 17317 invoked by uid 109); 10 May 2018 04:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 04:53:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20559 invoked by uid 111); 10 May 2018 04:53:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 00:53:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 00:53:11 -0400
Date:   Thu, 10 May 2018 00:53:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH 1/1] commit-graph: fix UX issue when .lock file exists
Message-ID: <20180510045310.GA27259@sigill.intra.peff.net>
References: <20180509141523.89896-1-dstolee@microsoft.com>
 <20180509141523.89896-2-dstolee@microsoft.com>
 <20180509144221.GA14714@sigill.intra.peff.net>
 <926ef4a5-83c1-3d5f-6dfc-0b74fc7090bd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <926ef4a5-83c1-3d5f-6dfc-0b74fc7090bd@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 09, 2018 at 10:53:56AM -0400, Derrick Stolee wrote:

> > Your cover letter is way longer than this description. Should some of
> > that background perhaps go in the commit message?
> 
> I did want a place to include the full die() message in the new behavior,
> but that seemed like overkill for the commit message.

I think it would be fine. In general, it's probably a good idea to err
on the side of more information in the commit message than less. The one
exception is that if your commit message grows very long, make sure it's
organized well. I find there are two "modes" in which I read old commit
messages:

  1. Skimming through log, etc, to try to get the gist of what the
     commit is doing and find out whether it might be related to my
     problem.

  2. Once I've identified it as a problem, I want to know every single
     thing in the mind of the writer that might help me.

(I'm not speaking to this particular message or your messages in general
here; I just didn't want to claim that a blanket "longer is better" is
without limitations).

-Peff
