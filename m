Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B512027C
	for <e@80x24.org>; Wed, 17 May 2017 13:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753688AbdEQNmp (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 09:42:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:53694 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752530AbdEQNmo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 09:42:44 -0400
Received: (qmail 6558 invoked by uid 109); 17 May 2017 13:42:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 13:42:44 +0000
Received: (qmail 9700 invoked by uid 111); 17 May 2017 13:43:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 09:43:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 09:42:41 -0400
Date:   Wed, 17 May 2017 09:42:41 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 00/23] Prepare to separate out a packed_ref_store
Message-ID: <20170517134241.5zqaqptfgjrrrbju@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 02:05:23PM +0200, Michael Haggerty wrote:

> This patch series is the next leg on a journey towards reading
> `packed-refs` using `mmap()`, the most interesting aspect of which is
> that we will often be able to avoid having to read the whole
> `packed-refs` file if we only need a subset of references.
> 
> The first leg of the journey was separating out the reference cache
> into a separate module [1]. That branch is already merged to master.
> 
> This patch series prepares the ground for separating out a
> `packed_ref_store`, but doesn't yet take that step. (As you can see,
> it's a long enough patch series already!) It's kind of a grab bag of
> cleanup patches plus work to decouple the packed-refs handling code
> from the rest of `files_ref_store`. Some highlights:

I dropped a few minor comments in individual patches, but it all looks
good to me up through patch 22. Your description in patch 23 makes
sense, but I was too frazzled by the end to carefully review the code
itself for that patch. I'll try to come back to it later.

-Peff
