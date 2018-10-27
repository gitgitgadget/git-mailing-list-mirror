Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D165E1F453
	for <e@80x24.org>; Sat, 27 Oct 2018 06:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJ0PH1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:07:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:56820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727532AbeJ0PH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:07:27 -0400
Received: (qmail 23256 invoked by uid 109); 27 Oct 2018 06:27:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 06:27:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3966 invoked by uid 111); 27 Oct 2018 06:26:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 02:26:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 02:27:31 -0400
Date:   Sat, 27 Oct 2018 02:27:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
Message-ID: <20181027062731.GA16664@sigill.intra.peff.net>
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
 <20181027034512.GA2875@syl.hsd1.wa.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181027034512.GA2875@syl.hsd1.wa.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 08:45:12PM -0700, Taylor Blau wrote:

> On Fri, Oct 26, 2018 at 04:57:26PM +0900, Junio C Hamano wrote:
> > * tb/filter-alternate-refs (2018-10-25) 2 commits
> >   (merged to 'next' on 2018-10-26 at 887a7779a3)
> >  + t5410: use longer path for sample script
> >  + Documentation/config.txt: fix typo in core.alternateRefsCommand
> >
> >  Test fix.
> >
> >  Will merge to 'master'.
> 
> There is an additional clean-up patch in [1] that I'm not sure if you
> have seen or not. Could you please queue that as a fixup to the above?
> 
> Thanks,
> Taylor
> 
> [1]: 6aabe7201dc81b98e404010b441fef8d582b0232.1540258140.git.me@ttaylorr.com

Isn't that queued without fanfare one commit below the test fix?

-Peff
