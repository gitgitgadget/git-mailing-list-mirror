Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52EC11FCA9
	for <e@80x24.org>; Sat, 17 Sep 2016 18:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbcIQSnI (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 14:43:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:44632 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753271AbcIQSnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 14:43:08 -0400
Received: (qmail 22290 invoked by uid 109); 17 Sep 2016 18:43:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Sep 2016 18:43:07 +0000
Received: (qmail 25154 invoked by uid 111); 17 Sep 2016 18:43:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 17 Sep 2016 14:43:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Sep 2016 11:43:04 -0700
Date:   Sat, 17 Sep 2016 11:43:04 -0700
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC
 PATCH]
Message-ID: <20160917184304.w7lzzsi7pxpnh5sr@sigill.intra.peff.net>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 17, 2016 at 12:21:52AM -0700, Josh Triplett wrote:

> This provides a shorter and more convenient alias for
> --subject-prefix='RFC PATCH'.
> 
> Includes documentation in the format-patch manpage, and a new test
> covering --rfc.
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
> v2:
> - Add documentation to the format-patch manpage
> - Call subject_prefix_callback rather than reimplementing it
> - Update test to move expectations inside

Assuming we want this option, the implementation looks good to me (and I
don't have a big opinion the first part of that sentence).

-Peff
