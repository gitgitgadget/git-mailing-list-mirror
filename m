Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBEBD1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 02:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeFGCtQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 22:49:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:37174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753074AbeFGCtP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 22:49:15 -0400
Received: (qmail 14688 invoked by uid 109); 7 Jun 2018 02:49:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Jun 2018 02:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11966 invoked by uid 111); 7 Jun 2018 02:49:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Jun 2018 22:49:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jun 2018 22:49:13 -0400
Date:   Wed, 6 Jun 2018 22:49:13 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 2/2] json-writer: t0019: add Python unit test
Message-ID: <20180607024913.GA9351@sigill.intra.peff.net>
References: <20180605163358.119080-1-git@jeffhostetler.com>
 <20180605163358.119080-3-git@jeffhostetler.com>
 <20180606171052.GI3094@zaya.teonanacatl.net>
 <20180606210300.GA1879@sigill.intra.peff.net>
 <a50f4a76-7534-b036-e1a4-5560178bd044@ramsayjones.plus.com>
 <20180607022353.GA3898@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180607022353.GA3898@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 06, 2018 at 10:23:53PM -0400, Jeff King wrote:

> Though maybe I am wrong that the remote-svn stuff requires python. I
> thought it did, but poking around, it looks like it's all C, and just
> the "svnrdump_sim" helper is python.

I think I was getting this mixed up with the git_remote_helpers python
work, which was removed long ago in ae34ac126f (git_remote_helpers:
remove little used Python library, 2013-09-07).

Note that it really changes much, but I was curious enough to dig down.

-Peff
