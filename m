Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AA2B202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbdCISXY (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:23:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754526AbdCISXY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:23:24 -0500
Received: (qmail 10567 invoked by uid 109); 9 Mar 2017 18:23:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 18:23:23 +0000
Received: (qmail 13967 invoked by uid 111); 9 Mar 2017 18:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 09 Mar 2017 13:23:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Mar 2017 13:23:20 -0500
Date:   Thu, 9 Mar 2017 13:23:20 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?SsO2cm4=?= Hees <dev@joernhees.de>
Cc:     git@vger.kernel.org
Subject: Re: git commit --interactive patch-mode no longer allows selecting
 files
Message-ID: <20170309182320.n77lvytjh7u2b2a2@sigill.intra.peff.net>
References: <8C99B562-9194-4227-B40D-F64BBECEEE38@joernhees.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8C99B562-9194-4227-B40D-F64BBECEEE38@joernhees.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2017 at 06:48:58PM +0100, Jörn Hees wrote:

> i'm not entirely sure if this is a bug or intended (couldn't find it in the changelogs though)...
> 
> Before 2.12.0 a `git commit --int` / `git add --int` followed by [p]
> for patch-mode, would allow a numeric selection of the files to patch
> hunks for (this behavior is well documented all over the internet).
> 
> Since 2.12.0 the numeric selection is skipped and automatically drops
> me directly into hunk mode (Mac OS X homebrew).

It's a bug. The fix is in c852bd54bd87fdcdc825f5d45c26aa745be13ba6, but
has not yet been merged to any integration branches. I hope it will make
it into v2.12.1.

-Peff
