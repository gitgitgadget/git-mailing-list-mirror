Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C7AA200B9
	for <e@80x24.org>; Sat,  5 May 2018 18:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeEES0e (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 14:26:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:57206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751235AbeEES0d (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 14:26:33 -0400
Received: (qmail 12888 invoked by uid 109); 5 May 2018 18:26:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 05 May 2018 18:26:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12145 invoked by uid 111); 5 May 2018 18:26:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 05 May 2018 14:26:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 May 2018 14:26:31 -0400
Date:   Sat, 5 May 2018 14:26:31 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
Message-ID: <20180505182631.GC17700@sigill.intra.peff.net>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 04, 2018 at 05:34:32PM +0200, Johannes Schindelin wrote:

> This builtin does not do a whole lot so far, apart from showing a usage
> that is oddly similar to that of `git tbdiff`. And for a good reason:
> the next commits will turn `branch-diff` into a full-blown replacement
> for `tbdiff`.

One minor point about the name: will it become annoying as a tab
completion conflict with git-branch?

It feels really petty complaining about the name, but I just want to
raise the point, since it will never be easier to change than right now.

(And no, I don't really have another name in mind; I'm just wondering if
"subset" names like this might be a mild annoyance in the long run).

-Peff
