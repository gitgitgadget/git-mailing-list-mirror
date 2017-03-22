Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70BFE20323
	for <e@80x24.org>; Wed, 22 Mar 2017 13:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759562AbdCVNGo (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 09:06:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:49290 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759554AbdCVNGj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 09:06:39 -0400
Received: (qmail 26663 invoked by uid 109); 22 Mar 2017 13:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 13:06:20 +0000
Received: (qmail 25880 invoked by uid 111); 22 Mar 2017 13:06:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 09:06:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 09:06:15 -0400
Date:   Wed, 22 Mar 2017 09:06:15 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 18/20] commit_packed_refs(): use reference iteration
Message-ID: <20170322130615.hcl5vrezkcr45fdk@sigill.intra.peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <b8d279659c6755c5d042a3062b526e4752114c38.1490026594.git.mhagger@alum.mit.edu>
 <20170320180532.vxzra6tpf3t7qjks@sigill.intra.peff.net>
 <b49b4ae0-bcef-ce1d-62d5-f76a11e84766@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b49b4ae0-bcef-ce1d-62d5-f76a11e84766@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 09:42:58AM +0100, Michael Haggerty wrote:

> > Should we be checking that peel_error is only PEELED or NON_TAG?
> 
> This is a good question, and it took me a while to figure out the whole
> answer. At first I deleted this check without much thought because it
> was just an internal consistency check that should never trigger. But
> actually the story is more complicated than that.
> 
> Tl;dr: the old code is slightly wrong and I think the new code is correct.

OK, that all makes sense. Thanks for digging.

-Peff
