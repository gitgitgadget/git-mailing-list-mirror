Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED751F461
	for <e@80x24.org>; Sun, 19 May 2019 18:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfESS2F (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 14:28:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:33530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725766AbfESS2E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 May 2019 14:28:04 -0400
Received: (qmail 20784 invoked by uid 109); 19 May 2019 05:01:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 19 May 2019 05:01:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28008 invoked by uid 111); 19 May 2019 05:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 19 May 2019 01:01:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 19 May 2019 01:01:15 -0400
Date:   Sun, 19 May 2019 01:01:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Osipov <michael.osipov@siemens.com>
Subject: Re: [PATCH v2] Makefile: remove the NO_R_TO_GCC_LINKER flag
Message-ID: <20190519050115.GA2672@sigill.intra.peff.net>
References: <xmqqd0ki3s0q.fsf@gitster-ct.c.googlers.com>
 <20190517215847.28179-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190517215847.28179-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 17, 2019 at 11:58:47PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Fri, May 17 2019, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> Far be it from me to care about AIX, but it seems like this is ripe for
> >> regressions, because we don't know which platforms were relying on "-R"
> >> instead of "-Wl,-rpath", and now everybody will be using the latter by
> >> default.
> >
> > I do not have a stake in AIX, either, but I had the same reaction.
> 
> I did a bad job of summarizing why this change makes sense. Here's a
> v2 with a changed commit message. The first 4 pargaraphs are most
> relevant.

Thanks for the additional context. After reading the revised
explanation, I agree it's probably OK to move in this direction.

-Peff
