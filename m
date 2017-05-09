Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071B81FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbdEIDdC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:33:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:47874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEIDdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:33:02 -0400
Received: (qmail 14045 invoked by uid 109); 9 May 2017 03:33:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 03:33:01 +0000
Received: (qmail 19445 invoked by uid 111); 9 May 2017 03:33:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 23:33:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 23:32:59 -0400
Date:   Mon, 8 May 2017 23:32:59 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 0/4] Make diff plumbing commands respect the
 indentHeuristic.
Message-ID: <20170509033258.q7auj5p5lxs4tggd@sigill.intra.peff.net>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170508160339.4551-1-marcnarc@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 12:03:35PM -0400, Marc Branchaud wrote:

> The only change from v3 is in 3/4, to expand t4061 to test various
> combinations of --(no-)indent-heuristic and diff.indentHeuristic.
> 
> I kindof went all-in and tried to cover every possible combination for
> all four affected commands.

TBH, I don't know that we need to be that thorough. Unless we have a
reason to believe that the code will behave differently in context A
versus B, it's probably not buying us much. It would be nice, of course,
if we could get full coverage of all possible paths through the program,
but I think that involves a combinator explosion.

But I'm OK with what you have here (the whole series, though I dropped
one or two comments while reading it).

-Peff
