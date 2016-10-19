Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1577920986
	for <e@80x24.org>; Wed, 19 Oct 2016 21:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753435AbcJSVdP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 17:33:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:59709 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750746AbcJSVdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 17:33:15 -0400
Received: (qmail 20308 invoked by uid 109); 19 Oct 2016 21:33:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 21:33:14 +0000
Received: (qmail 18111 invoked by uid 111); 19 Oct 2016 21:33:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 17:33:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 17:33:12 -0400
Date:   Wed, 19 Oct 2016 17:33:12 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        sunshine@sunshineco.com, walters@verbum.org,
        Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: split ref_kind_from_filter
Message-ID: <20161019213311.7gmlrqdnjoibq3de@sigill.intra.peff.net>
References: <20161019203520.zevkb75at2nrogdm@sigill.intra.peff.net>
 <20161019203546.dfqmi2czcxopgj6w@sigill.intra.peff.net>
 <xmqqd1iwkp7m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd1iwkp7m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 02:23:41PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: Re: [PATCH 1/2] ref-filter: split ref_kind_from_filter
> 
> I think you meant ref_kind_from_refname() ;-)
> 
> Looks like a good idea.

Heh, I actually meant filter_ref_kind(), which is the original function.
But any name that is actually a real function would do. :)

-Peff
