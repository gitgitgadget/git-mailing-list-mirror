Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8196D1FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 22:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426115AbdDUWN5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 18:13:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:38030 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426109AbdDUWNz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 18:13:55 -0400
Received: (qmail 26597 invoked by uid 109); 21 Apr 2017 22:13:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 22:13:53 +0000
Received: (qmail 20955 invoked by uid 111); 21 Apr 2017 22:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 21 Apr 2017 18:14:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Apr 2017 18:13:50 -0400
Date:   Fri, 21 Apr 2017 18:13:50 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [GIT 2.12.2 REGRESSION] git cherry-pick -x
Message-ID: <20170421221350.xlhhrsk7m2bxh4tz@sigill.intra.peff.net>
References: <20170421220155.GA142345@google.com>
 <CAGZ79kYBgvzkO66pL3buffAChKtPu2Xt5Q4FUoiijYHj591aCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYBgvzkO66pL3buffAChKtPu2Xt5Q4FUoiijYHj591aCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 03:10:03PM -0700, Stefan Beller wrote:

> +Jonathan, who worked on trailers
> [...]
> > I haven't tried bisecting precisely, but somewhere along the way git
> > cherry-pick -x regressed between 2.9.3 and 2.12.2.

Yeah, it bisects to 967dfd4d5 (sequencer: use trailer's trailer layout,
2016-11-02).

-Peff
