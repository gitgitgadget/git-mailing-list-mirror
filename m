Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D393A2013A
	for <e@80x24.org>; Fri, 17 Feb 2017 09:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932636AbdBQJ0W (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 04:26:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:56983 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932681AbdBQJ0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 04:26:19 -0500
Received: (qmail 8849 invoked by uid 109); 17 Feb 2017 09:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 09:26:18 +0000
Received: (qmail 32215 invoked by uid 111); 17 Feb 2017 09:26:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Feb 2017 04:26:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Feb 2017 04:26:17 -0500
Date:   Fri, 17 Feb 2017 04:26:17 -0500
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: topological index field for commit objects
Message-ID: <20170217092616.ulassn3472stbfga@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
 <578EC0CA.8060501@gmail.com>
 <20160720130231.GB17469@sigill.intra.peff.net>
 <CANQwDwfk2k+qGtx-_RqoLKObAgyV+ebE57UAd-VXDv86HDw2vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwfk2k+qGtx-_RqoLKObAgyV+ebE57UAd-VXDv86HDw2vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 04, 2017 at 02:43:01PM +0100, Jakub Narębski wrote:

> >>>> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it still
> >>>> limited to object counting?
> >>>
> >>> At GitHub we are using them for --contains analysis, along with mass
> >>> ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
> >>> plan is to send patches upstream, but they need some cleanup first.
> >>
> >> Ping. have you got time to clean up those patches?
> >
> > No, I haven't. Don't hold your breath; it's something I hope to work on
> > in the next 6 months, not the next 6 weeks.
> 
> Ping, Was there any progress on this front? It is now almost 6 months
> later...
> 
> Could those patches be made available in a "dirty" form?

I just pushed them up to the "jk/ahead-behind" branch of
https://github.com/peff/git.

They were originally done on top of v1.9.1, but I forward-ported them to
the current "master" just now. The result compiles, but I haven't really
tested it extensively. Caveat applier.

-Peff
