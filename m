Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B921D202DD
	for <e@80x24.org>; Mon, 23 Oct 2017 00:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932175AbdJWAjZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 20:39:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:60734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932158AbdJWAjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 20:39:25 -0400
Received: (qmail 1767 invoked by uid 109); 23 Oct 2017 00:39:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Oct 2017 00:39:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31512 invoked by uid 111); 23 Oct 2017 00:39:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Oct 2017 20:39:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Oct 2017 20:39:22 -0400
Date:   Sun, 22 Oct 2017 20:39:22 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH v3 0/3] deprecate git stash save
Message-ID: <20171023003922.h3hr3y5ap2tk7byu@sigill.intra.peff.net>
References: <20171019183304.26748-2-t.gummerer@gmail.com>
 <20171022170409.8565-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171022170409.8565-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 22, 2017 at 06:04:06PM +0100, Thomas Gummerer wrote:

> Thanks Peff for the review of the previous rounds.
> 
> In addition to addressing the review comments, this round adds another
> patch getting rid of the extra help with an unknown option to git
> stash push.

Yeah, the reasoning in the commit message of patch 3 makes sense to me.

> Thomas Gummerer (3):
>   replace git stash save with git stash push in the documentation
>   mark git stash push deprecated in the man page
>   stash: remove now superfluos help for "stash push"

The whole thing looks good. Thanks!

-Peff
