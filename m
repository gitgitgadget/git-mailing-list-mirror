Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B734B1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 16:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfJKQLO (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 12:11:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:45850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726666AbfJKQLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 12:11:13 -0400
Received: (qmail 15579 invoked by uid 109); 11 Oct 2019 16:11:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 16:11:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2503 invoked by uid 111); 11 Oct 2019 16:14:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 12:14:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 12:11:12 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-rev-list.txt: prune options in synopsis
Message-ID: <20191011161112.GA19741@sigill.intra.peff.net>
References: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
 <20191011060457.GC20094@sigill.intra.peff.net>
 <c9e7fbd6-7ad6-bce9-1e17-6391ab3e0630@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9e7fbd6-7ad6-bce9-1e17-6391ab3e0630@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 05:02:33PM +0100, Philip Oakley wrote:

> Another case, of a different style, is that of `git bundle --all` which does
> need mentioning that particular rev-list option as a major usage (I couldn't
> manage to understand the three layers of man page that needed reading).
> 
> I had proposed a patch many years ago [1] but the feedback wasn't positive,
> though my SO question continues [2] to get votes.

Yeah, I agree that "git bundle" could be more clear about this. I think
just adding an example like this might help:

  # generate a bundle similar to what "git clone" would produce
  git bundle create file.bundle --branches --tags

-Peff
