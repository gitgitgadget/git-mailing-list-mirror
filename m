Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F2821F404
	for <e@80x24.org>; Fri, 23 Feb 2018 18:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeBWSBM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 13:01:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:34204 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751643AbeBWSBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 13:01:11 -0500
Received: (qmail 853 invoked by uid 109); 23 Feb 2018 18:01:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Feb 2018 18:01:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16841 invoked by uid 111); 23 Feb 2018 18:01:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Feb 2018 13:01:58 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2018 13:01:09 -0500
Date:   Fri, 23 Feb 2018 13:01:09 -0500
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] two small grep patches
Message-ID: <20180223180109.GA5208@sigill.intra.peff.net>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
 <20180223144757.31875-1-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223144757.31875-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 03:47:55PM +0100, Rasmus Villemoes wrote:

> Changes in v2:
> 
> - Drop patch 3 with dubious gain/complexity ratio
> - Add comments regarding ownership of grep_source
> 
> I was a little torn between copy-pasting the comment or just saying
> "see above" in the second case. I think a memset would be confusing,
> at least unless one extends the comment to explain why one then does
> the memset despite the first half of the comment.

This looks good to me. Thanks for following up.

-Peff
