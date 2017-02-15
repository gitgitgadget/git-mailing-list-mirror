Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9422013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdBOVw7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:52:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:56029 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdBOVw7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:52:59 -0500
Received: (qmail 24683 invoked by uid 109); 15 Feb 2017 21:52:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:52:58 +0000
Received: (qmail 17947 invoked by uid 111); 15 Feb 2017 21:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:52:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:52:56 -0500
Date:   Wed, 15 Feb 2017 16:52:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] show-branch: fix crash with long ref name
Message-ID: <20170215215256.crg3t5nrj6kjvw2i@sigill.intra.peff.net>
References: <20170214154816.12625-1-chriscool@tuxfamily.org>
 <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net>
 <xmqqlgt88t0r.fsf@gitster.mtv.corp.google.com>
 <20170214195513.7zae6x22advkrms6@sigill.intra.peff.net>
 <CAP8UFD0EfUgfmTB4dj-A+rw79F7SWKxYvatNfR+Nj-8ukWYAQA@mail.gmail.com>
 <20170215214052.5py4pxkcz4g2bmtk@sigill.intra.peff.net>
 <xmqqfujf2kfk.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfujf2kfk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 01:50:07PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I see the patches are marked for 'next' in the latest What's Cooking.
> > If it is not too late in today's integration cycle, here is a re-roll of
> > patch 3 that squashes in Pranit's suggestion (if it is too late, then
> > Pranit, you may want to re-send it as a squash on top).
> 
> Thanks.  
> 
> I think that matches what I queued last night, except for the
> Helped-by: line.  Will replace.

Oh, indeed. I should have actually checked what you queued. Thanks.

-Peff
