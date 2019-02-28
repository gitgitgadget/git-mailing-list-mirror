Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57DC8202AA
	for <e@80x24.org>; Thu, 28 Feb 2019 21:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfB1V1h (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:27:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:33482 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726203AbfB1V1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:27:37 -0500
Received: (qmail 31221 invoked by uid 109); 28 Feb 2019 21:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:27:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23896 invoked by uid 111); 28 Feb 2019 21:27:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:27:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:27:35 -0500
Date:   Thu, 28 Feb 2019 16:27:35 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 08/20] cat-file: remove rest from expand_data
Message-ID: <20190228212734.GH12723@sigill.intra.peff.net>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a54-e28b7a40-d51c-4dd4-85a3-0eea83d4f0cb-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f49a54-e28b7a40-d51c-4dd4-85a3-0eea83d4f0cb-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Get rid of rest field in struct expand_data.
> expand_data may be global further as we use it in ref-filter also,
> so we need to remove cat-file specific fields from it.
> 
> All globals that I add through this patch will be deleted in the end,
> so treat it just as the middle step.

Same comments apply as patch 7 (and 6 and 5). :)

-Peff
