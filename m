Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D0A1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934001AbdCJT6z (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:58:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:42265 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932994AbdCJT6y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:58:54 -0500
Received: (qmail 30457 invoked by uid 109); 10 Mar 2017 19:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 19:58:53 +0000
Received: (qmail 4413 invoked by uid 111); 10 Mar 2017 19:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Mar 2017 14:59:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Mar 2017 14:58:51 -0500
Date:   Fri, 10 Mar 2017 14:58:51 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>, git@vger.kernel.org
Subject: Re: git commit --interactive patch-mode no longer allows selecting
 files
Message-ID: <20170310195850.jsgjelmrhcnz7zoz@sigill.intra.peff.net>
References: <8C99B562-9194-4227-B40D-F64BBECEEE38@joernhees.de>
 <20170309182320.n77lvytjh7u2b2a2@sigill.intra.peff.net>
 <xmqqk27wykfj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk27wykfj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 11:57:04AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It's a bug. The fix is in c852bd54bd87fdcdc825f5d45c26aa745be13ba6, but
> > has not yet been merged to any integration branches. I hope it will make
> > it into v2.12.1.
> 
> Wow, you got me worried.  
> 
> It has been in 'pu' (and my private edition 'jch', which is
> somewhere between 'next' and 'pu') and marked as "Will merge to
> 'next'".

Yeah, sorry, I just meant "not in master or next". I did check that you
had picked it up.

-Peff
