Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B3E51FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 07:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424518AbdD1Hi6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 03:38:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:41506 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424431AbdD1Hh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 03:37:27 -0400
Received: (qmail 437 invoked by uid 109); 28 Apr 2017 07:37:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 07:37:23 +0000
Received: (qmail 17202 invoked by uid 111); 28 Apr 2017 07:37:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 03:37:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 03:37:22 -0400
Date:   Fri, 28 Apr 2017 03:37:22 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stephen Kent <smkent@smkent.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] status: add color config slots for branch info in
 "--short --branch"
Message-ID: <20170428073722.aivdzgwc7duwfg7h@sigill.intra.peff.net>
References: <201704939828871.4296cfa6a746a5004d28db265800a@localhost>
 <20170427090423.amjqi7ca4xl7pzax@sigill.intra.peff.net>
 <xmqqo9vhkzyf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9vhkzyf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 07:50:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As we discussed elsewhere, it would be nice if this tested remoteBranch,
> > too. IMHO the simplest thing to is to rebase it on the t7508 update I
> > just posted.
> >
> > The other option is to add config for remoteBranch which would do
> > nothing for now, and then resolve it to check the correct colors when
> > the two topics are merged (since the test will start failing then).
> > That seems unnecessarily confusing.
> 
> Yes, let's do the former.
> 
> This is to be applied on top of your
> <20170427090105.vaodugbqdaxunoin@sigill.intra.peff.net>
> 
> -- >8 --
> From: Stephen Kent <smkent@smkent.net>
> Date: Fri, 21 Apr 2017 22:42:02 -0700
> Subject: [PATCH] status: add color config slots for branch info in "--short --branch"

Thanks, the result looks good to me.

-Peff
