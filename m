Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6229C2098B
	for <e@80x24.org>; Wed, 19 Oct 2016 15:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S945206AbcJSPij (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 11:38:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59452 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945190AbcJSPia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 11:38:30 -0400
Received: (qmail 7357 invoked by uid 109); 19 Oct 2016 09:23:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 09:23:28 +0000
Received: (qmail 11949 invoked by uid 111); 19 Oct 2016 09:23:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Oct 2016 05:23:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2016 05:23:27 -0400
Date:   Wed, 19 Oct 2016 05:23:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #03; Tue, 11)
Message-ID: <20161019092326.lcuwe5hxwjf4ndpx@sigill.intra.peff.net>
References: <xmqq1szm8ukf.fsf@gitster.mtv.corp.google.com>
 <20161018133518.hwbv3gbeddjjfvcz@LykOS.localdomain>
 <xmqqtwc9r6uv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwc9r6uv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 08:53:44AM -0700, Junio C Hamano wrote:

> >> * st/verify-tag (2016-10-10) 7 commits
> [...]
> > Hi, I saw this on the previous "what's cooking." Is there anything I
> > need to do on my side to make sure this is ready for next?
> 
> Posting this exact message to the list would be an excellent way
> ;-).
> 
> Hopefully some competent reviewer comes and points me at a thread
> where s/he says the series was already reviewed and in good shape
> soonish, and your message may be a good trigger to make it happen.

Another from my list of "things I have been meaning to review". :)

I think this is close, but I had a few nits to pick with the ref-filter
printing interface. I sent comments for each patch in the v4 thread.

-Peff
