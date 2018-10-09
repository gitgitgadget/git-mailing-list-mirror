Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 759671F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 03:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJIKYE (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 06:24:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:46882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725749AbeJIKYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 06:24:04 -0400
Received: (qmail 7598 invoked by uid 109); 9 Oct 2018 03:09:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 09 Oct 2018 03:09:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10402 invoked by uid 111); 9 Oct 2018 03:08:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 08 Oct 2018 23:08:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Oct 2018 23:09:18 -0400
Date:   Mon, 8 Oct 2018 23:09:18 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        sbeller@google.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v5 0/4] Filter alternate references
Message-ID: <20181009030918.GB6250@sigill.intra.peff.net>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1539021825.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1539021825.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 11:09:20AM -0700, Taylor Blau wrote:

> Attached is (what I anticipate to be) the final re-roll of my series to
> introduce 'core.alternateRefsCommand' and 'core.alternateRefsPrefixes'
> in order to limit the ".have" advertisement when pushing over protocol
> v1 to a repository with configured alternates.

Thanks, this looks good to me!

-Peff
