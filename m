Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8B9E20248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbfB1VLZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:11:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:33434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726467AbfB1VLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:11:25 -0500
Received: (qmail 31041 invoked by uid 109); 28 Feb 2019 21:11:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:11:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23729 invoked by uid 111); 28 Feb 2019 21:11:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:11:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:11:23 -0500
Date:   Thu, 28 Feb 2019 16:11:23 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 04/20] for-each-ref: tests for new atom %(rest) added
Message-ID: <20190228211122.GD12723@sigill.intra.peff.net>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a4f-cdb13ec8-58ea-47aa-a64a-517db120961e-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f49a4f-cdb13ec8-58ea-47aa-a64a-517db120961e-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Add tests for new formatting atom %(rest).
> We need this atom for cat-file command.

While I do normally encourage splitting up commits, in this case I think
it would make sense to squash this together with patch 3. There's
nothing to say here about what %(rest) is that isn't already said in
that commit message.

That said, I'm still not sure that for-each-ref should be supporting
%(rest) at all. We should hopefully already have coverage of cat-file
using "%(rest)" (and if not, we should add some to make sure it's not
regressed by the conversion).

-Peff
