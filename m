Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CA01FBEC
	for <e@80x24.org>; Thu,  9 Mar 2017 10:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbdCIKiU (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 05:38:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:41172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752982AbdCIKiP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 05:38:15 -0500
Received: (qmail 8268 invoked by uid 109); 9 Mar 2017 10:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 10:38:14 +0000
Received: (qmail 28546 invoked by uid 111); 9 Mar 2017 10:38:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 05:38:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 05:38:12 -0500
Date:   Thu, 9 Mar 2017 05:38:12 -0500
From:   Jeff King <peff@peff.net>
To:     Guillaume Wenzek <guillaume.wenzek@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: BUG Report: git branch ignore --no-abbrev flag
Message-ID: <20170309103812.skwmyn4bmkxjwjl4@sigill.intra.peff.net>
References: <CAAvNd=ir1qNQVaKphdg51AfGnsNgTrfvW2L6cca3SHiZrWNgHA@mail.gmail.com>
 <xmqqlgsf39fg.fsf@gitster.mtv.corp.google.com>
 <xmqqzigv1lc3.fsf@gitster.mtv.corp.google.com>
 <CAAvNd=gAvONS-XP2vOLExdWiwDXTPbB5beiXikwdig7xC5OKow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAvNd=gAvONS-XP2vOLExdWiwDXTPbB5beiXikwdig7xC5OKow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 10:44:42AM +0100, Guillaume Wenzek wrote:

> The full version number is "2.12.0.246.ga2ecc84866" but I don't think
> that's an official number, I'm using my company (Google) apt
> repository.

That's built from the commit at a2ecc84866, which is in the "next"
branch (and is 246 commits ahead of v2.12.0). So that explains why you
are seeing the behavior. The code _isn't_ in v2.12.0, but you're running
a much more recent version.

-Peff
