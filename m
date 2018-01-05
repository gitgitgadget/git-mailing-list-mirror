Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908291F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeAEUw3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:52:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:35822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752183AbeAEUw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:52:29 -0500
Received: (qmail 31316 invoked by uid 109); 5 Jan 2018 20:51:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Jan 2018 20:51:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11048 invoked by uid 111); 5 Jan 2018 20:53:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Jan 2018 15:53:00 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jan 2018 15:52:27 -0500
Date:   Fri, 5 Jan 2018 15:52:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Isaac Shabtay <isaac@shabtay.com>, git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
Message-ID: <20180105205227.GA6958@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net>
 <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
 <20180104040124.GA11626@sigill.intra.peff.net>
 <xmqqfu7kcca9.fsf@gitster.mtv.corp.google.com>
 <20180105195705.GA5217@sigill.intra.peff.net>
 <xmqqmv1savcg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmv1savcg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 05, 2018 at 12:45:03PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Out of curiosity, did this change at some point? I thought the process
> > used to be to merge to maint, and then pick up topics in master by
> > merging maint to master.
> 
> If you look at "Sync with maint" merges made to 'master', you'd
> notice that most of them are only updating Documentation/RelNotes/*
> and otherwise no-effect merges, simply because when such an up-merge
> is made, everything in 'maint' is already in 'master' because topics
> are merged to the latter first.  Security fixes that go through
> embargoes are excempt for obvious reasons ;-)

OK, that makes sense. Pretty sure I did it wrong when I was interim
maintainer back in the day, then. :)

-Peff
