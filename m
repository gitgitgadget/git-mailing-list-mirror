Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36E21F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 04:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbcITE3u (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 00:29:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:45416 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751105AbcITE3t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 00:29:49 -0400
Received: (qmail 24725 invoked by uid 109); 20 Sep 2016 04:29:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 04:29:49 +0000
Received: (qmail 16958 invoked by uid 111); 20 Sep 2016 04:30:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Sep 2016 00:30:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Sep 2016 21:29:47 -0700
Date:   Mon, 19 Sep 2016 21:29:47 -0700
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH v3] format-patch: Add --rfc for the common case of [RFC
 PATCH]
Message-ID: <20160920042946.735auuwzsy2lv3yt@sigill.intra.peff.net>
References: <501a6bfb2a70f44f080b2f119e4503ccbf88f639.1474330487.git-series.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <501a6bfb2a70f44f080b2f119e4503ccbf88f639.1474330487.git-series.josh@joshtriplett.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 09:23:25PM -0700, Josh Triplett wrote:

> This provides a shorter and more convenient alias for
> --subject-prefix='RFC PATCH'.
> 
> Includes documentation in the format-patch manpage, and a new test
> covering --rfc.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
> v3:
> - Fix an error message referring to --subject-prefix
> - Expand the acronym "RFC"

This looks fine to me. Thanks.

-Peff
