Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083051F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 14:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753129AbeGCOiX (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 10:38:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:57752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752745AbeGCOiW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 10:38:22 -0400
Received: (qmail 20954 invoked by uid 109); 3 Jul 2018 14:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Jul 2018 14:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2257 invoked by uid 111); 3 Jul 2018 14:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 03 Jul 2018 10:38:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jul 2018 10:38:20 -0400
Date:   Tue, 3 Jul 2018 10:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 0/2] teach --only-matching to 'git-grep(1)'
Message-ID: <20180703143820.GC23556@sigill.intra.peff.net>
References: <cover.1529961706.git.me@ttaylorr.com>
 <cover.1530562110.git.me@ttaylorr.com>
 <20180703143729.GB23556@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180703143729.GB23556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 03, 2018 at 10:37:29AM -0400, Jeff King wrote:

> On Mon, Jul 02, 2018 at 03:08:54PM -0500, Taylor Blau wrote:
> 
> > Attached is the second re-roll of my series to teach 'git grep
> > --only-matching'. Since last time, not much has changed. The change I
> > did include is summarized below, and an inter-diff is attached as
> > always.
> > 
> >   - Initialize both match_color and line_color to NULL, thereby
> >     silencing a compiler warning where match_color was given to
> >     opt->output_color uninitialized [1].
> 
> This iteration looks fine to me. I think we'd ideally do
> s/grep/& --column/ in the commit message of the second patch, but that's
> not worth re-rolling.

In the example it shows, I mean (a global s/ would not be good ;) ).

-Peff
