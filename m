Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCBF1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbeGMTkl (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 15:40:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:58776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730017AbeGMTkl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 15:40:41 -0400
Received: (qmail 32409 invoked by uid 109); 13 Jul 2018 19:24:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 19:24:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6389 invoked by uid 111); 13 Jul 2018 19:24:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 15:24:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 15:24:42 -0400
Date:   Fri, 13 Jul 2018 15:24:42 -0400
From:   Jeff King <peff@peff.net>
To:     William Chargin <wchargin@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] sha1-name.c: for ":/", find detached HEAD commits
Message-ID: <20180713192441.GA10354@sigill.intra.peff.net>
References: <CAFW+GMD62V=o4hoEYKVteBZHzqBtquzLzTv2WXiSPZf3ZhOpeg@mail.gmail.com>
 <20180712054909.29077-1-wchargin@gmail.com>
 <xmqqva9kzbhi.fsf@gitster-ct.c.googlers.com>
 <CAFW+GMAp2bA2=_BZ2S0HLO2x2aLE01zXigHrY3QtCmWxRuyAtA@mail.gmail.com>
 <xmqqva9kw9ru.fsf@gitster-ct.c.googlers.com>
 <CAFW+GMByLBbj6oDu-ERhN-bFO__Tj_M752-OYLYa7=z5DF0Ckg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFW+GMByLBbj6oDu-ERhN-bFO__Tj_M752-OYLYa7=z5DF0Ckg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 01:01:23PM -0700, William Chargin wrote:

> Contents look good to me. I don't understand why the file name in your
> patch is sha1_name.c as opposed to sha1-name.c (I see e5e5e0883 from
> 2018-04-10, but that sounds pretty old), but I trust that whatever
> you're doing there is correct.

Junio typically applies bugfixes as close to the bug-source as possible,
which allows them to be merged-up into various releases (rather than
cherry-picked, which would be required if built on top of 'master').

Ideally this is directly on top of the commit that introduced the bug,
though for an ancient bug like this, it's not worth the effort. It looks
like he applied it on the 2.16 maint branch, which predates e5e5e0883.
When it's merged up, the resolution will handle the rename (probably
even automatically due to Git's rename detection).

> > Thanks for working on this.
> 
> You're quite welcome. Thanks to you, Peff, and Duy for your help. This
> was a pleasant experience for me as a new contributor. :-)

Great. Please come back anytime. :)

-Peff
