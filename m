Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18C31F453
	for <e@80x24.org>; Fri, 28 Sep 2018 01:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeI1H3G (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 03:29:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:34600 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726060AbeI1H3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 03:29:06 -0400
Received: (qmail 22109 invoked by uid 109); 28 Sep 2018 01:08:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Sep 2018 01:08:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8406 invoked by uid 111); 28 Sep 2018 01:07:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 21:07:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 21:07:59 -0400
Date:   Thu, 27 Sep 2018 21:07:59 -0400
From:   Jeff King <peff@peff.net>
To:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: colorize branches checked out in a linked
 working tree the same way as the current branch is colorized
Message-ID: <20180928010759.GC11281@sigill.intra.peff.net>
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20180927181708.GA2468@sigill.intra.peff.net>
 <20180927192804.GA27163@rigel>
 <20180927193559.GB6950@sigill.intra.peff.net>
 <20180927213511.GB2628@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927213511.GB2628@rigel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 27, 2018 at 10:35:11PM +0100, Rafael Ascensão wrote:

> git branch has --format, but there's no way (at least to my knowledge)
> to define a value in gitconfig to be used by $git branch.

Oh, you're right. I was thinking of the branch.sort we just added in
v2.19.

I agree that having branch.format (and a matching tag.format) would be
useful.

-Peff
