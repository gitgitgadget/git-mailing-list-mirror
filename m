Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7BD1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 04:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdKHEWW (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 23:22:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:49868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751982AbdKHEWW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 23:22:22 -0500
Received: (qmail 28327 invoked by uid 109); 8 Nov 2017 04:22:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Nov 2017 04:22:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10659 invoked by uid 111); 8 Nov 2017 04:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Nov 2017 23:22:33 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Nov 2017 23:22:20 -0500
Date:   Tue, 7 Nov 2017 23:22:20 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 Outreachy] mru: use double-linked list from list.h
Message-ID: <20171108042219.xfx7tevgkwzrqdtd@sigill.intra.peff.net>
References: <0102015ec7a3424b-529be659-bdb6-42c4-a48f-db264f33d53a-000000@eu-west-1.amazonses.com>
 <0102015ed3e9b1a8-74821a55-aa9a-4e5a-b267-c3d2462e3eed-000000@eu-west-1.amazonses.com>
 <20171002082020.c7ravpwgz45osrmz@sigill.intra.peff.net>
 <xmqqshdpmtm9.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshdpmtm9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 08, 2017 at 10:44:46AM +0900, Junio C Hamano wrote:

> > We could also consider it a #leftoverbits that perhaps some other
> > Outreachy candidate would pick up[1].
> >
> > In the meantime, Junio, I think we'd want to queue this with the intent
> > to graduate it to "pu" or possibly "next", but not "master". Then if
> > somebody (Olga or another applicant) produces the endgame patch, we can
> > queue it on top and move it further. And if nobody does, I can pick it
> > after the application period is over.
> 
> So... do we still want to keep this in 'next', or does somebody
> wants to do honors?  
> 
> I'd really prefer *not* to see you or me ending up finishing it up,
> but at the same time, I really hate seeing a halfway or 3/4 done
> topic hanging around in 'pu'.

We hung back on it to leave it as low-hanging fruit for other Outreachy
applicants. Perhaps Olga would like to pick it up now that the
application period is over.

Alternatively, it might be a nice task for the Bloomberg hackathon this
weekend. I'll add it to the list of topics there, too.

-Peff
