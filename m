Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64F4D20248
	for <e@80x24.org>; Thu,  7 Mar 2019 02:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCGC6Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 21:58:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726597AbfCGC6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 21:58:24 -0500
Received: (qmail 9431 invoked by uid 109); 7 Mar 2019 02:58:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 02:58:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19721 invoked by uid 111); 7 Mar 2019 02:58:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 21:58:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 21:58:21 -0500
Date:   Wed, 6 Mar 2019 21:58:21 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] Documentation/config: note trailing newline with
 --type=color
Message-ID: <20190307025821.GB25656@sigill.intra.peff.net>
References: <b5ca6391fd0273fb7d6b92bc5ada96df93bc5cf2.1551487219.git.me@ttaylorr.com>
 <be22686b93fa76f0ff63a7d93cb731545c57cb22.1551916338.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be22686b93fa76f0ff63a7d93cb731545c57cb22.1551916338.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 06, 2019 at 03:52:38PM -0800, Taylor Blau wrote:

> In 63e2a0f8e9 (builtin/config: introduce `color` type specifier,
> 2018-04-09), `--type=color` was introduced and preferred to the
> old-style `--get-color`.
> 
> The two behave the same in almost every way, save for the fact that
> `--type=color` prints a trailing newline where `--get-color` does not.
> Instead of introducing ambiguity between `--type=color` and the other
> `--type` variants, document the difference between `--type=color` and
> `--get-color` instead.

I just responded to the one Junio posted elsewhere in the thread, but
for the record this one is fine to me, too (and it gets the literal
quoting right ;) ).

-Peff
