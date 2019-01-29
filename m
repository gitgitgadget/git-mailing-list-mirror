Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6211F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfA2WiL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:38:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:54068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727342AbfA2WiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:38:11 -0500
Received: (qmail 20704 invoked by uid 109); 29 Jan 2019 22:38:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Jan 2019 22:38:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11671 invoked by uid 111); 29 Jan 2019 22:38:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 Jan 2019 17:38:17 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2019 17:38:07 -0500
Date:   Tue, 29 Jan 2019 17:38:07 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
Message-ID: <20190129223807.GC1895@sigill.intra.peff.net>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129160030.GA7083@sigill.intra.peff.net>
 <87zhrj2n2l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhrj2n2l.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 29, 2019 at 10:03:46PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I think these are reasonable to have (and I personally much prefer
> > "prove" to the raw "make test" output anyway).
> 
> I wonder if anyone would mind if we removed the non-prove path.
> 
> When I added it in 5099b99d25 ("test-lib: Adjust output to be valid TAP
> format", 2010-06-24) there were still some commonly shipped OS's that
> had a crappy old "prove", but now almost a decade later that's not a
> practical problem, and it's installed by default with perl, and we
> already depend on perl for the tests.
> 
> I don't feel strongly about it, but it would allow us to prune some
> login in the test library / Makefile.
> 
> Maybe something for a show of hands at the contributor summit?

Certainly no argument from me personally, but I do wonder if anybody
uses the old one. Maybe we could mark it with a deprecation notice or
something. I'd be happy to do a straw poll at the contributor summit (or
on the list, if anybody reads this ;) ).

-Peff
