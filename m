Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D82E820248
	for <e@80x24.org>; Thu,  4 Apr 2019 01:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDDB5q (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:57:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:46274 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDB5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:57:46 -0400
Received: (qmail 19107 invoked by uid 109); 4 Apr 2019 01:57:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 01:57:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13270 invoked by uid 111); 4 Apr 2019 01:58:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 21:58:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 21:57:44 -0400
Date:   Wed, 3 Apr 2019 21:57:44 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
Message-ID: <20190404015744.GF4409@sigill.intra.peff.net>
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 09:38:02AM -0500, Robert Dailey wrote:

> Similar to git commit, it would be nice to have a --no-edit option for
> git tag. Use case is when I force-recreate a tag:
> 
> $ git tag -af 1.0 123abc
> 
> An editor will be prompted with the previous annotated tag message. I
> would like to add --no-edit to instruct it to use any previously
> provided message and without prompting the editor:
> 
> $ git tag --no-edit -af 1.0 123abc

Yeah, that sounds like a good idea. I think it wouldn't be very hard to
implement, either. Maybe a good starter project or #leftoverbits for
somebody.

-Peff
