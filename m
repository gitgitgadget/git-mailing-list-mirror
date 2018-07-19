Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68821F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeGSWSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:18:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:53334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727743AbeGSWR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:17:59 -0400
Received: (qmail 11062 invoked by uid 109); 19 Jul 2018 21:33:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 21:33:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17174 invoked by uid 111); 19 Jul 2018 21:33:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 17:33:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 17:33:00 -0400
Date:   Thu, 19 Jul 2018 17:33:00 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/2] banned.h: mark strncpy as banned
Message-ID: <20180719213300.GC13151@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203934.GB8079@sigill.intra.peff.net>
 <87y3e7aq0e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y3e7aq0e.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 11:12:49PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Thu, Jul 19 2018, Jeff King wrote:
> 
> > Since this use of strncpy was verified by manual inspection
> > and since it doesn't trigger the automated ban-list, we're
> > better off leaving it to keep our divergence from glibc
> > minimal.
> 
> FWIW it's s/glibc/gawk/. It's originally from glibc, but gawk
> perma-forked it long ago, and an ancient copy of thath is the one we
> use.

Thanks, I didn't know that. Not materially different, but it's worth
correcting the commit message.

-Peff
