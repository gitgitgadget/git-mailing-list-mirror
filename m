Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1061FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753834AbcLFS0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:26:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:52633 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753822AbcLFS0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:26:50 -0500
Received: (qmail 4838 invoked by uid 109); 6 Dec 2016 18:26:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 18:26:50 +0000
Received: (qmail 15889 invoked by uid 111); 6 Dec 2016 18:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 13:27:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 13:26:48 -0500
Date:   Tue, 6 Dec 2016 13:26:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
Message-ID: <20161206182648.sxoftkd4hjhvenaf@sigill.intra.peff.net>
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
 <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
 <xmqqbmwq5k7k.fsf@gitster.mtv.corp.google.com>
 <20161206140259.lly76xkvsj7su3om@sigill.intra.peff.net>
 <xmqqwpfc2a7g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwpfc2a7g.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 10:17:55AM -0800, Junio C Hamano wrote:

> Yup, that is what I meant to say with "that is already possible" and
> we are on the same page.  As all three of us seem to be happy with
> just dropping --abbrev and letting describe do its default thing (as
> configured by whoever is doing the build), let's do so.
> 
> -- >8 --
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Date: Sun, 4 Dec 2016 20:45:59 +0000
> Subject: [PATCH] GIT-VERSION-GEN: do not force abbreviation length used by 'describe'

Thanks, this is a nice summary of the discussion, and the patch is
obviously correct.

-Peff
