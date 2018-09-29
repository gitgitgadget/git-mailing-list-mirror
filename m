Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C81B1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 07:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeI2OFx (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 10:05:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:36098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727508AbeI2OFx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 10:05:53 -0400
Received: (qmail 9404 invoked by uid 109); 29 Sep 2018 07:38:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Sep 2018 07:38:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4473 invoked by uid 111); 29 Sep 2018 07:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 29 Sep 2018 03:38:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Sep 2018 03:38:27 -0400
Date:   Sat, 29 Sep 2018 03:38:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, avarab@gmail.com,
        git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH] strbuf.h: format according to coding guidelines
Message-ID: <20180929073827.GD2174@sigill.intra.peff.net>
References: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
 <20180928173033.159192-1-sbeller@google.com>
 <xmqqr2hdbdp8.fsf@gitster-ct.c.googlers.com>
 <xmqqin2pbcwh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqin2pbcwh.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 28, 2018 at 01:11:26PM -0700, Junio C Hamano wrote:

> > I am mildly against giving names to obvious ones.
> 
> Just to make sure nobody listening from sidelines do not
> misunderstand, ones like getwholeline_fd() that takes more than one
> parameter with the same time is a prime example of a function that
> take non-obvious parameters that MUST be named.  
> 
> What I am mildly against is the rule that says "name ALL
> parameters".  I tend to think these names make headers harder to
> read, and prefer to keep them to the minimum.
> 
> I actually do not mind the rule to be more like
> 
>  * Use the same parameter names used in the function declaration when
>    the description in the API documentation refers the parameter.

Yes, I agree very much with that rule (and your genera line of
thinking).

I am not personally against just naming every parameter, but I simply
don't care either way.

-Peff
