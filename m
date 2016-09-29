Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AE3207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934362AbcI2VIo (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:08:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:50207 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934039AbcI2VIn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:08:43 -0400
Received: (qmail 20798 invoked by uid 109); 29 Sep 2016 21:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 21:08:42 +0000
Received: (qmail 5305 invoked by uid 111); 29 Sep 2016 21:08:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 17:08:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 17:08:39 -0400
Date:   Thu, 29 Sep 2016 17:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 2/4] t13xx: do not assume system config is empty
Message-ID: <20160929210839.77ikl33g44w2mpey@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
 <20160928233047.14313-3-gitster@pobox.com>
 <20160929090108.hf2jzfcvbcsfaxw7@sigill.intra.peff.net>
 <xmqqintefuau.fsf@gitster.mtv.corp.google.com>
 <20160929182621.lobihscwl7amtu7s@sigill.intra.peff.net>
 <xmqq60pefrvc.fsf@gitster.mtv.corp.google.com>
 <20160929192613.o6q2fqp3mjntz2l6@sigill.intra.peff.net>
 <xmqqoa36e7v8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa36e7v8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 02:03:39PM -0700, Junio C Hamano wrote:

> > -	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
> > +	git config --show-origin --get-regexp "user\.[g|l|s].*" >output &&
> >  	test_cmp expect output
> >  '
> 
> Makes sense modulo you inherited useless vertical bars from the
> original.  I'll squash something like that in but without || ;-)

Heh, I glossed over that completely. Thanks.

-Peff
