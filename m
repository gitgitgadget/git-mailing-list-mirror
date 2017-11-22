Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9FC20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdKVWGa (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:06:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:38060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751324AbdKVWG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:06:29 -0500
Received: (qmail 4523 invoked by uid 109); 22 Nov 2017 22:06:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 22:06:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5136 invoked by uid 111); 22 Nov 2017 22:06:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 17:06:45 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 17:06:27 -0500
Date:   Wed, 22 Nov 2017 17:06:27 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
Message-ID: <20171122220627.GE2854@sigill>
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
 <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
 <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
 <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
 <20171122202720.GD11671@aiede.mtv.corp.google.com>
 <20171122211729.GA2854@sigill>
 <20171122215635.GE11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122215635.GE11671@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 01:56:35PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Wed, Nov 22, 2017 at 12:27:20PM -0800, Jonathan Nieder wrote:
> 
> >> That said, I wonder if this use case is an illustration that a name
> >> like --no-lock-index (as was used in Git for Windows when this feature
> >> first appeared) or --no-refresh-on-disk-index (sorry, I am terrible at
> >> coming up with option names) would make the feature easier to
> >> discover.
> [...]
> >         Or maybe just living with the minor philosophical rough edges,
> > since it seems OK in practice.
> 
> To be clear, my concern is not philosophical but practical: I'm saying
> if it's a "git status" option (or at least shows up in the "git
> status" manpage) and it is memorably about $GIT_DIR/index (at least
> mentions that in its description) then it is more likely to help
> people.

Right, I went a little off track of your original point.

What I was trying to get at is that naming it "status --no-lock-index"
would not be the same thing (even though with the current implementation
it would behave the same). IOW, can we improve the documentation of
"status" to point to make it easier to discover this use case.

-Peff
