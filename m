Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4621420248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfBVPJt (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:09:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:54416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726860AbfBVPJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:09:48 -0500
Received: (qmail 1546 invoked by uid 109); 22 Feb 2019 15:09:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Feb 2019 15:09:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28643 invoked by uid 111); 22 Feb 2019 15:10:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Feb 2019 10:10:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2019 10:09:46 -0500
Date:   Fri, 22 Feb 2019 10:09:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: remove an out-of-date comment
Message-ID: <20190222150946.GC5090@sigill.intra.peff.net>
References: <20190222105658.26831-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222105658.26831-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 11:56:58AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Remove a comment referring to a caveat that hasn't been applicable
> since 18b0fc1ce1 ("Git.pm: Kill Git.xs for now", 2006-09-23).
> 
> At the time of 8d7f586f13 ("Git.pm: Support for perl/ being built by a
> different compiler", 2006-06-25) some of the code in perl would be
> built by a C compiler, but support for that went away a few months
> later in 18b0fc1ce1 discussed above.
> 
> Since my 20d2a30f8f ("Makefile: replace perl/Makefile.PL with simple
> make rules", 2017-12-10) the perl/ directory doesn't even have its own
> build process.

I liked that commit before, but seeing that it makes this hairy corner
case go away, I like it even more. ;)

The patch itself seems obviously correct.

-Peff
