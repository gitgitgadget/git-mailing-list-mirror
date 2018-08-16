Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84761F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeHPVjL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:39:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:57932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727790AbeHPVjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:39:11 -0400
Received: (qmail 12497 invoked by uid 109); 16 Aug 2018 18:39:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Aug 2018 18:39:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18277 invoked by uid 111); 16 Aug 2018 18:39:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 16 Aug 2018 14:39:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Aug 2018 14:39:03 -0400
Date:   Thu, 16 Aug 2018 14:39:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] commit: add short option for --amend
Message-ID: <20180816183903.GA3737@sigill.intra.peff.net>
References: <20180816183117.13716-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180816183117.13716-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 08:31:17PM +0200, Nguyễn Thái Ngọc Duy wrote:

> I just realized how often I type "git ci --amend". Looking back at my
> ~/.bash_history (only 10k lines) this is the second most often git
> command I type which may justify a short option for it (assuming that
> other people use this option often too, of course).
> 
> The short option space for 'git commit' is really crowded with
> acCeFhimnopqsStuvz already taken. So it could be '-M' or '-A' but I'd
> prefer not to hold shift, so I chose '-j' even though it's not
> strictly related to "amend" (or perhaps we can thinking of amending as
> joining commits).
> 
> Thoughts?

I also used to type it a lot. So I did:

  $ type a
  a is aliased to `git commit --amend'

I don't know if that argues for or against a short option.

-Peff
