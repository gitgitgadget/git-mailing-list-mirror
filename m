Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44A571F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbeIRWuT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 18:50:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729037AbeIRWuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 18:50:19 -0400
Received: (qmail 6685 invoked by uid 109); 18 Sep 2018 17:16:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Sep 2018 17:16:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9165 invoked by uid 111); 18 Sep 2018 17:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Sep 2018 13:16:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2018 13:16:43 -0400
Date:   Tue, 18 Sep 2018 13:16:43 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] config doc: add missing list separator for
 checkout.optimizeNewBranch
Message-ID: <20180918171643.GC15470@sigill.intra.peff.net>
References: <20180816182653.15580-1-benpeart@microsoft.com>
 <20180918053449.14047-1-avarab@gmail.com>
 <20180918165707.GC72102@syl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180918165707.GC72102@syl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 18, 2018 at 12:57:07PM -0400, Taylor Blau wrote:

> Hi Ævar,
> 
> On Tue, Sep 18, 2018 at 05:34:49AM +0000, Ævar Arnfjörð Bjarmason wrote:
> > The documentation added in fa655d8411 ("checkout: optimize "git
> > checkout -b <new_branch>"", 2018-08-16) didn't add the double-colon
> > needed for the labeled list separator, as a result the added
> > documentation all got squashed into one paragraph. Fix that by adding
> > the list separator.
> 
> Looks good. Here's my:
> 
>   Signed-off-by: Taylor Blau <me@ttaylorr.com>

I'm confused here. The signoff is really about agreeing publicly to the
DCO, and providing a chain of custody for the changes. So sometimes a
signoff from somebody besides the patch author is good if they
contributed content to the patch, but I don't see that here (or in any
nearby thread).

Did you mean "Reviewed-by:" ?

-Peff
