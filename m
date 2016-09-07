Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C132070F
	for <e@80x24.org>; Wed,  7 Sep 2016 22:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbcIGWiW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 18:38:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:39746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751981AbcIGWiU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 18:38:20 -0400
Received: (qmail 31846 invoked by uid 109); 7 Sep 2016 22:38:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 22:38:20 +0000
Received: (qmail 8987 invoked by uid 111); 7 Sep 2016 22:38:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 18:38:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:38:17 -0400
Date:   Wed, 7 Sep 2016 18:38:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] patch-ids: use commit sha1 as patch-id for merge
 commits
Message-ID: <20160907223816.jio6gk72uuknq4ha@sigill.intra.peff.net>
References: <20160907220101.hwwutkiagfottbdd@sigill.intra.peff.net>
 <20160907220439.ukbqnj5biaro2lxv@sigill.intra.peff.net>
 <CA+P7+xr_GqU+v6RevEuqgNK5Kui=izRwD2oPvBh-4NzAp10uOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xr_GqU+v6RevEuqgNK5Kui=izRwD2oPvBh-4NzAp10uOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 07, 2016 at 03:28:10PM -0700, Jacob Keller wrote:

> On Wed, Sep 7, 2016 at 3:04 PM, Jeff King <peff@peff.net> wrote:
> > The patch-ids code which powers "log --cherry-pick" doesn't
> > look at whether each commit is a merge or not. It just feeds
> > the commit's first parent to the diff, and ignores any
> > additional parents.
> >
> 
> The subject here is misleading since it says you will use sha1 of the
> merge commit ,but instead just ignore merge commits and indicate they
> have no patch id. I suspect this is because you switched
> implementations part way through developing this.

Oops, yes, that's exactly what happened. I'll wait for discussion to
settle on the approach and fix it up in the re-roll.

-Peff
