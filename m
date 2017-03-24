Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC63D20966
	for <e@80x24.org>; Fri, 24 Mar 2017 18:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755854AbdCXSp4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:45:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:51269 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755825AbdCXSpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:45:54 -0400
Received: (qmail 23508 invoked by uid 109); 24 Mar 2017 18:45:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 18:45:53 +0000
Received: (qmail 19267 invoked by uid 111); 24 Mar 2017 18:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 14:46:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Mar 2017 14:45:51 -0400
Date:   Fri, 24 Mar 2017 14:45:51 -0400
From:   Jeff King <peff@peff.net>
To:     Romuald Brunet <romuald@chivil.com>
Cc:     git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: allow atomic flag via configuration
Message-ID: <20170324184550.3l6mw4ybynizblsm@sigill.intra.peff.net>
References: <1490375874.745.227.camel@locke.gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1490375874.745.227.camel@locke.gandi.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 06:17:54PM +0100, Romuald Brunet wrote:

> Added a "push.atomic" option to git-config to allow site-specific
> configuration of the atomic flag of git push

I don't really use --atomic myself, but this seems like a reasonable
thing to want, and the implementation looks cleanly done.

My one question would be whether people would want this to actually be
specific to a particular remote, and not just on for a given repository
(your "site-specific" in the description made me think of that). In that
case it would be better as part of the remote.* config.

-Peff
