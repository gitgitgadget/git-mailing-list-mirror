Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AD4208CD
	for <e@80x24.org>; Sun, 20 Aug 2017 07:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752482AbdHTHuF (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 03:50:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:43842 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751055AbdHTHuF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Aug 2017 03:50:05 -0400
Received: (qmail 21061 invoked by uid 109); 20 Aug 2017 07:50:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 07:50:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12504 invoked by uid 111); 20 Aug 2017 07:50:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 20 Aug 2017 03:50:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Aug 2017 03:50:02 -0400
Date:   Sun, 20 Aug 2017 03:50:02 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Daudt <me@ikke.info>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Carlsson, Magnus" <Magnus.Carlsson@arris.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git fetch with refspec does not include tags?
Message-ID: <20170820075001.gmsxeh3fh4f2topg@sigill.intra.peff.net>
References: <1502960406180.9006@arris.com>
 <1502960572292.1402@arris.com>
 <20170817092853.hteuzni5lxia4ejf@sigill.intra.peff.net>
 <xmqq1soagf1p.fsf@gitster.mtv.corp.google.com>
 <20170817202257.GC3839@alpha.vpn.ikke.info>
 <xmqqk222expv.fsf@gitster.mtv.corp.google.com>
 <20170817204312.GD3839@alpha.vpn.ikke.info>
 <20170820074728.4dawjlnaufjdf4j5@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170820074728.4dawjlnaufjdf4j5@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 20, 2017 at 03:47:28AM -0400, Jeff King wrote:

> Yeah, I don't think we want to go back to the original behavior. I agree
> that it is partially to blame for the inconsistency that started this
> thread, but I think on balance it has saved much more confusion than it
> has started. And we can address that inconsistency with better tag rules
> (like the "autofollow if we wrote any real refs" thing).
> 
> I don't have a patch for that yet, so if anybody feels like taking a
> look, it would be much appreciated.

Also: I don't think we've seen a patch yet for documenting the current
auto-follow behavior.  Even if we don't make a behavior change, let's
not forget to improve that, which should be much less work. :)

-Peff
