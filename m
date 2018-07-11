Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D529F1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 17:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733093AbeGKRkg (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 13:40:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:55728 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732860AbeGKRkg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 13:40:36 -0400
Received: (qmail 17893 invoked by uid 109); 11 Jul 2018 17:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 17:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10558 invoked by uid 111); 11 Jul 2018 17:35:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 13:35:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 13:35:13 -0400
Date:   Wed, 11 Jul 2018 13:35:13 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] t/lib-httpd: avoid occasional failures when
 checking access.log
Message-ID: <20180711173513.GA24949@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180711125647.16512-1-szeder.dev@gmail.com>
 <20180711125647.16512-4-szeder.dev@gmail.com>
 <20180711145730.GB15269@sigill.intra.peff.net>
 <CAM0VKjm8V58w=2+Zx+ykrfmOmNDOtPY5HeuFy+mWm_H40UrF1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjm8V58w=2+Zx+ykrfmOmNDOtPY5HeuFy+mWm_H40UrF1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 07:26:19PM +0200, SZEDER Gábor wrote:

> > But it is really "make sure that a failed test here does not prevent us
> > from doing this cleanup". So the original really should have just
> > dropped that comment and added a test_when_finished. Bumping it into a
> > separate test as you have here accomplishes the same thing.
> 
> After taking a step back, I think this would fit better into the first
> patch, wouldn't it?
> I will send v3 shortly.

Yeah, I agree it would be even nicer to clean it up there.

-Peff
