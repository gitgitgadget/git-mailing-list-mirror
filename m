Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F261F597
	for <e@80x24.org>; Fri, 27 Jul 2018 11:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbeG0MvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 08:51:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:60930 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730290AbeG0MvV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 08:51:21 -0400
Received: (qmail 23056 invoked by uid 109); 27 Jul 2018 11:29:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Jul 2018 11:29:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25283 invoked by uid 111); 27 Jul 2018 11:29:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 27 Jul 2018 07:29:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jul 2018 07:29:50 -0400
Date:   Fri, 27 Jul 2018 07:29:50 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 1/5] packfile: make get_delta_base() non static
Message-ID: <20180727112950.GA18599@sigill.intra.peff.net>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
 <20180722054836.28935-2-chriscool@tuxfamily.org>
 <xmqqy3e0zjw0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy3e0zjw0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 09:19:27AM -0700, Junio C Hamano wrote:

> Christian Couder <christian.couder@gmail.com> writes:
> 
> > From: Jeff King <peff@peff.net>
> >
> > As get_delta_base() will be used outside 'packfile.c' in
> > a following commit, let's make it non static and let's
> > declare it in 'packfile.h'.
> 
> As a public function in *.h, don't we want a bit of comment there to
> help those who want to use it from outside packfile.c?

Arguably it may want a better name, too.

-Peff
