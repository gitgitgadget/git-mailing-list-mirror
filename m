Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E9F1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437136AbfHIQ3C (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 12:29:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:39098 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2437021AbfHIQ3C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 12:29:02 -0400
Received: (qmail 12333 invoked by uid 109); 9 Aug 2019 16:29:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Aug 2019 16:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31411 invoked by uid 111); 9 Aug 2019 16:31:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Aug 2019 12:31:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Aug 2019 12:29:01 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Christian Couder' <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2019, #06; Thu, 25)
Message-ID: <20190809162900.GA9094@sigill.intra.peff.net>
References: <xmqq36itprzo.fsf@gitster-ct.c.googlers.com>
 <20190809001315.GA87896@syl.lan>
 <3C7105E5-5DE1-42DC-A9A4-65C061FD6139@dereferenced.org>
 <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001e01d54ebb$9a1ab4b0$ce501e10$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 09, 2019 at 10:06:06AM -0400, Randall S. Becker wrote:

> On 01 Aug 2019 13:05:12, Junio wrote:
> > >> *snip*
> 
> I think this got missed in the shuffle, but I am getting questions about the topic from my own team that I cannot answer.
> 
> I noticed that the switch and restore commands are now available in
> 2.23.0 but are not discussed in recent What's Cooking or Git Rev (or I
> blithely missed them). The question from my team is what are the plans
> for deprecating checkout. They have loads of scripts and want to plan
> for moving over.

I don't know of any plans for checkout in particular, but I think the
docs for restore/switch make it clear that it's way too early to start
scripting around them:

  $ git grep EXPERIMENTAL Documentation/
  Documentation/git-restore.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
  Documentation/git-switch.txt:THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

-Peff
