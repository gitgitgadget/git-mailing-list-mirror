Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEEA1FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 16:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934144AbcLWQTW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 11:19:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:59994 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756845AbcLWQTV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 11:19:21 -0500
Received: (qmail 5250 invoked by uid 109); 23 Dec 2016 16:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 16:19:20 +0000
Received: (qmail 25584 invoked by uid 111); 23 Dec 2016 16:20:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Dec 2016 11:20:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2016 11:19:18 -0500
Date:   Fri, 23 Dec 2016 11:19:18 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
Message-ID: <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net>
References: <20161217005442.5866-1-jacob.e.keller@intel.com>
 <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
 <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
 <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 23, 2016 at 12:12:13AM -0800, Jacob Keller wrote:

> I actually would prefer that we just say "this is the default now" and
> provide some knob "no-indent-heuristic" or "no-compaction-heuristic"
> and go with that, I think, since I am pretty sure we're all in
> agreement that the heuristic is an improvement in almost every case,
> certainly all the ones we've found. It's at least not worse in any
> case I've seen, and is usually better.
> 
> Thoughts? I don't have a super strong opinion about which name we went
> with for the knob.

Yes, I think we should also make --indent-heuristic the default. That's
technically orthogonal to the name, but I agree the name becomes a lot
less important when it is just on by default.

-Peff
