Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F27202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 09:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbdGEJMU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 05:12:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:59894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751599AbdGEJMU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 05:12:20 -0400
Received: (qmail 24585 invoked by uid 109); 5 Jul 2017 09:12:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 09:12:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6131 invoked by uid 111); 5 Jul 2017 09:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 05:12:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 05:12:16 -0400
Date:   Wed, 5 Jul 2017 05:12:16 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 00/30] Create a reference backend for packed refs
Message-ID: <20170705091216.ij4uzp3wgsalb56f@sigill.intra.peff.net>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 01, 2017 at 08:30:38PM +0200, Michael Haggerty wrote:

> This is v3 of a patch series creating a `packed_ref_store` reference
> backend. Thanks to Peff and Junio for their comments about v2 [1].
> 
> Changes since v2:
> 
> * Delete some debugging `cat` commands in t1408.
> 
> * Add some tests of reading packed-refs files with bogus contents.
> 
> * When reporting corruption in packed-refs files, distinguish between
>   unterminated lines and other corruption.
> 
> * Fixed a typo in a commit message.

Thanks. I just quickly re-reviewed based on the diff from v2, and it
looks good to me.

-Peff
