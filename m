Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2818E20357
	for <e@80x24.org>; Tue, 11 Jul 2017 07:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755222AbdGKHpn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 03:45:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:36678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753178AbdGKHpm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 03:45:42 -0400
Received: (qmail 28628 invoked by uid 109); 11 Jul 2017 07:45:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 07:45:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13754 invoked by uid 111); 11 Jul 2017 07:45:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 03:45:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 03:45:40 -0400
Date:   Tue, 11 Jul 2017 03:45:40 -0400
From:   Jeff King <peff@peff.net>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Andreas Krey <a.krey@gmx.de>, Git Users <git@vger.kernel.org>
Subject: Re: Flurries of 'git reflog expire'
Message-ID: <20170711074539.xqtqqee7a7fbemyn@sigill.intra.peff.net>
References: <20170704075758.GA22249@inner.h.apk.li>
 <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net>
 <20170706133124.GB1216@inner.h.apk.li>
 <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
 <20170711044553.GG3786@inner.h.apk.li>
 <CAGyf7-F-zG7NR_bd_sVLdVM5xT9UbJrW_=5imiihNu15E5OsYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGyf7-F-zG7NR_bd_sVLdVM5xT9UbJrW_=5imiihNu15E5OsYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 12:35:50AM -0700, Bryan Turner wrote:

> That's a few of the reasons we've switched over. I'd imagine most
> hosting providers take a similarly "hands on" approach to controlling
> their GC. Beyond a certain scale, it seems almost unavoidable. Git
> never has more than a repository-level view of the world; only the
> hosting provider can see the big picture.

Thanks for writing this out. I agree with all of the reasons given (in
my email which I suspect crossed with yours, I just said "throttling",
but there really are a lot of other reasons).

-Peff
