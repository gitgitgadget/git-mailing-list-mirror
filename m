Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C8C1F461
	for <e@80x24.org>; Thu, 16 May 2019 22:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfEPWWH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 18:22:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:60038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726762AbfEPWWH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 18:22:07 -0400
Received: (qmail 3264 invoked by uid 109); 16 May 2019 22:22:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 22:22:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8021 invoked by uid 111); 16 May 2019 22:22:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 May 2019 18:22:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 May 2019 18:22:05 -0400
Date:   Thu, 16 May 2019 18:22:05 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] Doc: git.txt: remove backticks from link and add
 git-scm.com/docs
Message-ID: <20190516222204.GB11784@sigill.intra.peff.net>
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
 <20190515224709.2936-1-philipoakley@iee.org>
 <20190515224709.2936-3-philipoakley@iee.org>
 <xmqqbm035fhx.fsf@gitster-ct.c.googlers.com>
 <d79d5e70-ec3a-c6ca-b23d-a44edf2579d2@iee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d79d5e70-ec3a-c6ca-b23d-a44edf2579d2@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 12:25:47PM +0100, Philip Oakley wrote:

> > Except perhaps for these to see what's there:
> > 
> > Documentation/git-archimport.txt:	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
> That domain is gone. Whole line should probably be removed.

Heh, see:

  https://public-inbox.org/git/20170420203441.mrlwbkqinub7m225@sigill.intra.peff.net/

I left it to people who actually care about arch to clean up that line
and figure out if there is some useful alternative.

-Peff
