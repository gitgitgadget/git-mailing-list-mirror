Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252CC20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeLKKud (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:50:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:37976 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726467AbeLKKuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:50:32 -0500
Received: (qmail 14816 invoked by uid 109); 11 Dec 2018 10:50:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:50:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4024 invoked by uid 111); 11 Dec 2018 10:49:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:49:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:50:07 -0500
Date:   Tue, 11 Dec 2018 05:50:07 -0500
From:   Jeff King <peff@peff.net>
To:     Jon Forrest <nobozo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Announcing Pro Git Second Edition Reedited
Message-ID: <20181211105007.GD7233@sigill.intra.peff.net>
References: <pujni2$ulb$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pujni2$ulb$1@blaine.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 09, 2018 at 10:42:12AM -0800, Jon Forrest wrote:

> Several years ago I released what I called Pro Git Reedited. This was an
> attempt to tighten up the text of the excellent Pro Git book written by
> Scott Chacon. Since then, Scott and Ben Straub released the second
> edition of Pro Git so once again I'm releasing a reedited version of
> what they wrote. I hope you enjoy it.
> 
> The PDF of my version is at
> 
> https://drive.google.com/file/d/18wGebSU0dyYU1L_bfyoDQtZRF1Vo1H3p/view?usp=sharing
> 
> If there's enough interest, I'll try to put up an HTML version of
> the book.

The content at https://git-scm.com/book is pulled regularly from
https://github.com/progit/progit2, which has collected a number of fixes
(as well as translations) since the 2nd edition was released.

Have you considered sending some of your edits there? It sounds like
they may be too large to just dump as a big PR, but it might be possible
to grow together over time.

-Peff
