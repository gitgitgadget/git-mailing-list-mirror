Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E8A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeHMXuO (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:50:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:53824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729063AbeHMXuO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:50:14 -0400
Received: (qmail 16282 invoked by uid 109); 13 Aug 2018 21:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 13 Aug 2018 21:06:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13966 invoked by uid 111); 13 Aug 2018 21:06:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 13 Aug 2018 17:06:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Aug 2018 17:06:18 -0400
Date:   Mon, 13 Aug 2018 17:06:18 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: Contributor Summit planning
Message-ID: <20180813210617.GA19738@sigill.intra.peff.net>
References: <20180813163108.GA6731@sigill.intra.peff.net>
 <87h8jyrtj6.fsf@evledraar.gmail.com>
 <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>
 <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 13, 2018 at 01:41:51PM -0700, Stefan Beller wrote:

> > Oh, using "git shortlog" might be also simpler ;-)
> 
> I guess you'd need to memorize a different set of flags for that
> as without -s it would be harder to parse than the oneliner above.

I frequently using "git shortlog -ns" to see who is active (especially
coupled with "--since=".

I also use "--no-merges", because it makes me look a lot better when
compared relatively to Junio. :) I agree with you that "--no-merges"
means we don't capture all the work that goes into integrating. But
there's a lot of work that isn't reflected in commit count (reviewing,
bug triage, the fact that some commits are much bigger than others,
etc). So at best it's a starting point for figuring out who
participates.

-Peff
