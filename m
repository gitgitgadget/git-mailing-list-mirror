Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7610B1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 06:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbeI0NFU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 09:05:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:33176 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726951AbeI0NFU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 09:05:20 -0400
Received: (qmail 12755 invoked by uid 109); 27 Sep 2018 06:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 06:48:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28283 invoked by uid 111); 27 Sep 2018 06:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 02:48:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 02:48:37 -0400
Date:   Thu, 27 Sep 2018 02:48:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
Message-ID: <20180927064836.GA13130@sigill.intra.peff.net>
References: <20180921223558.65055-1-sbeller@google.com>
 <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com>
 <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
 <20180926185812.GD30680@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180926185812.GD30680@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 02:58:12PM -0400, Jeff King wrote:

> And if we were going to generate something external, would it make more
> sense to write in a structured format like doxygen? I am not a big fan
> of it myself, but at least from there you can generate a more richly
> interconnected set of documentation.

By the way, I tried running Doxygen on the current code-base. I _still_
hate the presentation of it (mostly because it's jarring to jump out of
my terminal to a web browser). But it actually does an OK job of showing
strbuf.h, with our overview attached to the struct and individual
functions correctly documented. There are a couple of formatting
hiccups, but it's actually pretty close.

-Peff
