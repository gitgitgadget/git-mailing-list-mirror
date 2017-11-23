Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C25AC202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 13:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbdKWNv6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 08:51:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:38616 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752683AbdKWNv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 08:51:57 -0500
Received: (qmail 9038 invoked by uid 109); 23 Nov 2017 13:51:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Nov 2017 13:51:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8870 invoked by uid 111); 23 Nov 2017 13:52:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 23 Nov 2017 08:52:13 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Nov 2017 08:51:55 -0500
Date:   Thu, 23 Nov 2017 08:51:55 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
Message-ID: <20171123135155.GA8231@sigill>
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
 <20171121214552.GB16418@alpha.vpn.ikke.info>
 <20171123000346.GA8718@sigill>
 <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 23, 2017 at 02:45:44AM -0500, Robert P. J. Day wrote:

> > It's pretty clear to me as it is, but maybe we can write it differently.
> > Like:
> >
> >   Without a disambiguating `--`, Git makes a reasonable guess. If it
> >   cannot guess (because your request is ambiguous), then it will error
> >   out.
> 
>   ok, i'll give this another try, given that there are two independent
> points to be made here:
> 
> 1) even without the "--", git can generally parse the command and do
> the right thing (or do a *valid* thing, given its heuristics)
> 
> 2) occasionally, without the "--", the command is really and truly
> ambiguous, at which point git will fail and tell you to disambiguate
> 
>   not the wording i will use, but can we agree that those are the two
> points to be made here?

Yep, I think so.

-Peff
