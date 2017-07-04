Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A617D202AC
	for <e@80x24.org>; Tue,  4 Jul 2017 21:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbdGDV2w (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 17:28:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:59568 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752204AbdGDV2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 17:28:52 -0400
Received: (qmail 28025 invoked by uid 109); 4 Jul 2017 21:28:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jul 2017 21:28:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3915 invoked by uid 111); 4 Jul 2017 21:29:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Jul 2017 17:29:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jul 2017 17:28:49 -0400
Date:   Tue, 4 Jul 2017 17:28:49 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Sahil Dua <sahildua2305@gmail.com>
Subject: Re: Truncating HEAD reflog on branch move
Message-ID: <20170704212849.n4bvp7crhd7p7d7w@sigill.intra.peff.net>
References: <20170622184516.kq3y7nxwohm3coq4@sigill.intra.peff.net>
 <xmqqvannkfp8.fsf@gitster.mtv.corp.google.com>
 <20170622202146.cxrkjca636xl4dgk@sigill.intra.peff.net>
 <xmqqd19vix03.fsf@gitster.mtv.corp.google.com>
 <20170622215235.to6yleo3adt5klv2@sigill.intra.peff.net>
 <20170622222545.yewnynklle24ebtf@sigill.intra.peff.net>
 <20170623031315.7aw5qd7c4wdqlyf6@sigill.intra.peff.net>
 <20170704195806.ndbykl776t3vigya@genre.crustytoothpaste.net>
 <20170704212408.xy6jciggoueq6qsu@sigill.intra.peff.net>
 <20170704212709.vqymnj6kkz3prwty@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170704212709.vqymnj6kkz3prwty@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 04, 2017 at 09:27:09PM +0000, brian m. carlson wrote:

> On Tue, Jul 04, 2017 at 05:24:08PM -0400, Jeff King wrote:
> > On Tue, Jul 04, 2017 at 07:58:06PM +0000, brian m. carlson wrote:
> > > I've looked at your original patch, which modified reflog-walk.c, and it
> > > does fix the issue.  I'm happy to send in a patch with that and a test
> > > (provided you're okay with me adding your sign-off), or if you wanted to
> > > send in something a bit more complete, like the series of patches here,
> > > that's fine, too.
> > 
> > I've been on vacation for the past week, but wrapping this up is on my
> > todo. I'll try to get to it tonight.
> 
> Okay, if it's on your radar, that's fine.  Certainly you should enjoy
> your vacation and not feel obligated to work on Git unless you want to.

Heh, no, "tonight" is the first work day after the vacation ends. Once
the fireworks are done, it's back to work. ;)

-Peff
