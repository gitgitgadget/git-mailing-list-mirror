Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C36DC1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756435AbcK3XhY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:37:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:49358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754916AbcK3XhY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:37:24 -0500
Received: (qmail 25393 invoked by uid 109); 30 Nov 2016 23:37:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 23:37:24 +0000
Received: (qmail 26851 invoked by uid 111); 30 Nov 2016 23:37:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Nov 2016 18:37:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Nov 2016 18:37:21 -0500
Date:   Wed, 30 Nov 2016 18:37:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3 01/16] Add initial external odb support
Message-ID: <20161130233721.7yqu7pbr2oc53o7v@sigill.intra.peff.net>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
 <20161130210420.15982-2-chriscool@tuxfamily.org>
 <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 03:30:09PM -0800, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > From: Jeff King <peff@peff.net>
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> 
> By the time the series loses RFC prefix, we'd need to see the above
> three lines straightened out a bit more, e.g. a real message and a
> more proper sign-off sequence.

Actually, I would assume that this patch would go away altogether and
get folded into commits that get us closer to the end state. But I
haven't read the series carefully yet, so maybe it really does work
better with this as a base.

I am perfectly OK dropping my commit count by one and getting "based on
a patch by Peff" in a cover letter or elsewhere.

-Peff
