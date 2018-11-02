Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCA321F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeKBP61 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:58:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37776 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727745AbeKBP61 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:58:27 -0400
Received: (qmail 30057 invoked by uid 109); 2 Nov 2018 06:52:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:52:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1110 invoked by uid 111); 2 Nov 2018 06:51:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:51:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:52:18 -0400
Date:   Fri, 2 Nov 2018 02:52:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 0/8] fixes for unqualified <dst> push
Message-ID: <20181102065218.GK31216@sigill.intra.peff.net>
References: <20181026192734.9609-1-avarab@gmail.com>
 <20181026230741.23321-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181026230741.23321-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 11:07:33PM +0000, Ævar Arnfjörð Bjarmason wrote:

> After sending out v2 I noticed I didn't update the examples in a
> couple of the commit messages, and figured I'd finish this up by
> adding a patch to document how this works in the "git-push"
> manpage. This behavior has never been properly documented. range-diff
> with v2:

I read over these patches and the comments from Junio. Overall, I like
the direction of the first half 5, and tend to agree with the review
that the "refs/remotes" thing is going too far.

I didn't dig down into reviewing each line, since it looked like Junio
already did, and there's probably a re-roll coming.

-Peff
