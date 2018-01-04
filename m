Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069B81F406
	for <e@80x24.org>; Thu,  4 Jan 2018 04:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeADEBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 23:01:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:52836 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751707AbeADEBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 23:01:32 -0500
Received: (qmail 2246 invoked by uid 109); 4 Jan 2018 04:01:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Jan 2018 04:01:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2303 invoked by uid 111); 4 Jan 2018 04:01:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 23:01:57 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 23:01:25 -0500
Date:   Wed, 3 Jan 2018 23:01:25 -0500
From:   Jeff King <peff@peff.net>
To:     Isaac Shabtay <isaac@shabtay.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
Message-ID: <20180104040124.GA11626@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
 <20180103222821.GA32287@sigill.intra.peff.net>
 <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK2k7nQcY+QQBfda6CHM8tFo3i4XX2tXxHKv73t6SJ4rRvWo1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 03, 2018 at 02:42:51PM -0800, Isaac Shabtay wrote:

> Indeed interesting... this one's for the books...
> Thanks for the patches. Any idea when these are going to make it to the
> official Git client builds? (specifically the Windows one)

They haven't even been reviewed yet. If they get good feedback, then the
maintainer will pick them up, then merge them to 'next', and then
eventually to 'master', after which they'd become part of the next
major release. For a pure bug-fix, it may instead go to 'maint' and
become part of the next minor release.

Right now we're entering release freeze for v2.16.0. We'd still take
fixes for recent breakages there, but given the age of the problem I
doubt it will make the cutoff. But as this is a bug-fix, it might make
it into v2.16.1.

-Peff
