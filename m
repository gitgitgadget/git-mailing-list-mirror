Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4623201A7
	for <e@80x24.org>; Mon, 15 May 2017 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751197AbdEOWK6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 18:10:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:52201 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdEOWK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 18:10:57 -0400
Received: (qmail 30016 invoked by uid 109); 15 May 2017 22:10:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 22:10:57 +0000
Received: (qmail 21981 invoked by uid 111); 15 May 2017 22:11:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 18:11:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 18:10:54 -0400
Date:   Mon, 15 May 2017 18:10:54 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v7] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170515221054.j3pmk6fnhnsa5oa6@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170515173220.13103-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170515173220.13103-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 10:32:20AM -0700, Jonathan Tan wrote:

> OK, one combined function (for lazy initialization and checking
> containment in the oidset) with comment it is.
> 
> Change from v6: changed back to "tip_oids_contain", and included Peff's
> comment.

Thanks, looks good to me.

-Peff
