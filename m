Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C17820705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759075AbcIHSkS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:40:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:40317 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753159AbcIHSkR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:40:17 -0400
Received: (qmail 9420 invoked by uid 109); 8 Sep 2016 18:40:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 18:40:17 +0000
Received: (qmail 17356 invoked by uid 111); 8 Sep 2016 18:40:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 08 Sep 2016 14:40:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Sep 2016 14:40:14 -0400
Date:   Thu, 8 Sep 2016 14:40:14 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: "fatal error in commit_refs" from pushing to github
Message-ID: <20160908184014.l4g6if2gke6i3yjj@sigill.intra.peff.net>
References: <CACsJy8BF_mnSUcEeH=RBMyfh8RrQGJ4dwm_svsC4TciJtECn_w@mail.gmail.com>
 <20160908012553.q2aubze4qggfzjxz@sigill.intra.peff.net>
 <CACsJy8DW1-EsfgGkbnD3LgiygAu2JV9vs_8e+oQbenXERUA6hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DW1-EsfgGkbnD3LgiygAu2JV9vs_8e+oQbenXERUA6hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2016 at 06:03:33PM +0700, Duy Nguyen wrote:

> > So this is really an internal failure at the ref-update stage. There
> > _should_ be a reasonable error message, but I think "fatal error in
> > commit_refs" is the generic last-ditch fallback. I'll pass this along to
> > people in charge of that code, as we should be generating a more useful
> > error message.
> 
> Hmm.. I'm interested in this because the "fix" is from client side. I
> did "git gc" and "git fetch" and the problem was gone.

It may also have been a transient error inside GitHub that resolved
itself between your two pushes.

-Peff
