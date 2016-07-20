Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 726E61F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbcGTNCh (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:02:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:47425 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753391AbcGTNCf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:02:35 -0400
Received: (qmail 7390 invoked by uid 102); 20 Jul 2016 13:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:02:35 -0400
Received: (qmail 20261 invoked by uid 107); 20 Jul 2016 13:02:58 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:02:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:02:32 -0600
Date:	Wed, 20 Jul 2016 07:02:32 -0600
From:	Jeff King <peff@peff.net>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20160720130231.GB17469@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <578EC0CA.8060501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578EC0CA.8060501@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 02:07:38AM +0200, Jakub Narębski wrote:

> W dniu 2016-06-30 o 00:00, Jeff King pisze:
> > On Wed, Jun 29, 2016 at 11:49:35PM +0200, Jakub Narębski wrote:
> 
> >> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it still
> >> limited to object counting?
> >
> > At GitHub we are using them for --contains analysis, along with mass
> > ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
> > plan is to send patches upstream, but they need some cleanup first.
> 
> Ping. have you got time to clean up those patches?

No, I haven't. Don't hold your breath; it's something I hope to work on
in the next 6 months, not the next 6 weeks.

-Peff
