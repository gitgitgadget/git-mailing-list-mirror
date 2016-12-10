Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19F1205C9
	for <e@80x24.org>; Sat, 10 Dec 2016 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbcLJK1B (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 05:27:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:54608 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752203AbcLJK1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 05:27:00 -0500
Received: (qmail 6583 invoked by uid 109); 10 Dec 2016 10:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 10:27:00 +0000
Received: (qmail 25783 invoked by uid 111); 10 Dec 2016 10:27:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Dec 2016 05:27:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Dec 2016 05:26:57 -0500
Date:   Sat, 10 Dec 2016 05:26:57 -0500
From:   Jeff King <peff@peff.net>
To:     Klaus Ethgen <Klaus@Ethgen.ch>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] Colon in remote urls
Message-ID: <20161210102657.ateotzowgek7bjuc@sigill.intra.peff.net>
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
 <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
 <88bed7c9-4d5d-45d5-5d13-6a8ae834e602@kdbg.org>
 <20161210082657.zjp52a2zdtqifmg3@sigill.intra.peff.net>
 <20161210094133.7htkb6cmjuhkdh4v@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161210094133.7htkb6cmjuhkdh4v@ikki.ethgen.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 10:41:33AM +0100, Klaus Ethgen wrote:

> Am Sa den 10. Dez 2016 um  9:26 schrieb Jeff King:
> > Yeah, I picked it arbitrarily as the common quoting character, but I
> > agree it probably makes backwards compatibility (and general usability
> > when you have to double-backslash each instance) pretty gross on
> > Windows.
> 
> Well, I don't know of many people using the original git on windows.
> Most of them using some graphical third-party tools.

I laid out options for addressing the problem elsewhere, but I want to
make clear that this line of reasoning is not likely to get any traction
here. Git for Windows is a non-trivial part of the user base, and we do
care about avoiding regressions there.

-Peff
