Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5301C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB60F205CB
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 10:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHNKFo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:05:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:58836 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNKFo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 06:05:44 -0400
Received: (qmail 30420 invoked by uid 109); 14 Aug 2020 10:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 10:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23517 invoked by uid 111); 14 Aug 2020 10:05:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 06:05:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 06:05:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] make git-bugreport a builtin
Message-ID: <20200814100543.GA3312240@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813145936.GC891370@coredump.intra.peff.net>
 <f576fdce-9005-4653-3f91-0ddd2fff125d@gmail.com>
 <20200813173845.GA1598703@coredump.intra.peff.net>
 <xmqqa6yy2yjb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6yy2yjb.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:25:44AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >     macros). That could change eventually of course, but it's not like
> >     switching back to a stand-alone at that point is a big deal.
> 
> If it is not a big deal, then I am fine, but at the same time it
> becomes unclear why we can say "we can use X and Y niceties only
> available for builtins".

I may have oversold those niceties in the commit message. It is really
only saving us two lines of code, and it wouldn't be a big deal to
revert it (in fact, if you're uncomfortable with that, we could leave
the function otherwise intact).

-Peff
