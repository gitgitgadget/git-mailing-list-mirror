Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45A301F404
	for <e@80x24.org>; Tue, 20 Mar 2018 04:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751084AbeCTEMI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 00:12:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:35396 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750888AbeCTEMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 00:12:08 -0400
Received: (qmail 28942 invoked by uid 109); 20 Mar 2018 04:12:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 04:12:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28865 invoked by uid 111); 20 Mar 2018 04:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 00:13:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 00:12:06 -0400
Date:   Tue, 20 Mar 2018 00:12:06 -0400
From:   Jeff King <peff@peff.net>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation
 bug)
Message-ID: <20180320041205.GC12938@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net>
 <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <CAHnyXxR+03P8vG02dSuDCnRG0vsbOEWWsNBsKVsedgpkPNu=fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHnyXxR+03P8vG02dSuDCnRG0vsbOEWWsNBsKVsedgpkPNu=fQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 11:17:04PM -0400, Dakota Hawkins wrote:

> Sorry to tack on to my previous email, but I just thought of this:
> 
> If something like "-diff=lfs" won't do what I (and git-lfs) thought it
> would, do you think it would be prudent/reasonable to suggest git-lfs
> add a "no-lfs" filter for exactly this case? That way I could have
> explicit exclusions without any "diff=foo" shenanigans.

It might be if my earlier email weren't totally wrong. ;) I think the
"!filter" syntax that Junio mentioned would do what you want.

-Peff
