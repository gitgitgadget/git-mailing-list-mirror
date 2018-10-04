Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD4821F453
	for <e@80x24.org>; Thu,  4 Oct 2018 00:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJDHAq (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 03:00:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:40768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725799AbeJDHAq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 03:00:46 -0400
Received: (qmail 17590 invoked by uid 109); 4 Oct 2018 00:10:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Oct 2018 00:10:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19780 invoked by uid 111); 4 Oct 2018 00:09:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 20:09:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 20:10:05 -0400
Date:   Wed, 3 Oct 2018 20:10:05 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] alias help tweaks
Message-ID: <20181004001005.GA28016@sigill.intra.peff.net>
References: <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181003114242.9858-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181003114242.9858-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 01:42:39PM +0200, Rasmus Villemoes wrote:

> v2: Added patches 2 and 3, made "git cmd --help" unconditionally (no
> config option, no delay) redirect to the aliased command's help,
> preserve pre-existing behaviour of the spelling "git help cmd".
> 
> v3: Add some additional comments in patch 1 and avoid triggering leak
> checker reports. Use better wording in patch 3.

Thanks, v3 looks good to me!

-Peff
