Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB931F667
	for <e@80x24.org>; Tue, 15 Aug 2017 09:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbdHOJwR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 05:52:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:39220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753276AbdHOJwR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 05:52:17 -0400
Received: (qmail 29921 invoked by uid 109); 15 Aug 2017 09:52:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 09:52:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9584 invoked by uid 111); 15 Aug 2017 09:52:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 05:52:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Aug 2017 05:52:14 -0400
Date:   Tue, 15 Aug 2017 05:52:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #03; Mon, 14)
Message-ID: <20170815095214.pqsk777lu4aou5im@sigill.intra.peff.net>
References: <xmqqr2wdso3k.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2wdso3k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 04:53:35PM -0700, Junio C Hamano wrote:

> * jk/trailers-parse (2017-08-10) 5 commits
>  - interpret-trailers: add --parse convenience option
>  - interpret-trailers: add an option to normalize output
>  - interpret-trailers: add an option to show only existing trailers
>  - interpret-trailers: add an option to show only the trailers
>  - trailer: put process_trailers() options into a struct
> 
>  "git interpret-trailers" has been taught a "--parse" and a few
>  other options to make it easier for scripts to grab existing
>  trailer lines from a commit log message.
> 
>  Will merge to 'next'.

Please hold off on merging this for another round. I ended up
implementing the %(trailers) features on top. That spurred a few
cleanups through the earlier part of the series. Along with taking
Christian's suggestion to rename the --normalize option, I'll have a new
version out shortly.

-Peff
