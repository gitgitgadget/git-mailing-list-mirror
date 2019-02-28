Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1B920248
	for <e@80x24.org>; Thu, 28 Feb 2019 21:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbfB1VGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 16:06:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:33414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388397AbfB1VGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 16:06:36 -0500
Received: (qmail 30870 invoked by uid 109); 28 Feb 2019 21:06:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 21:06:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23670 invoked by uid 111); 28 Feb 2019 21:06:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 16:06:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 16:06:34 -0500
Date:   Thu, 28 Feb 2019 16:06:34 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH RFC 02/20] ref-filter: rename field in ref_array_item
 stuct
Message-ID: <20190228210633.GB12723@sigill.intra.peff.net>
References: <0102016915f499b8-5813fc52-230b-469e-b939-a1244e83a2b9-000000@eu-west-1.amazonses.com>
 <0102016915f49a3c-5b22158a-2d4f-4611-9239-8388af61fd8f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102016915f49a3c-5b22158a-2d4f-4611-9239-8388af61fd8f-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 04:05:45PM +0000, Olga Telezhnaya wrote:

> Rename objectname field to oid in struct ref_array_item.
> We usually use objectname word for string representation
> of object id, so oid explains the content better.

OK. I suspect the original was selected to match the %(objectname)
placeholder. But I agree that "oid" is the more common variable name,
and I think the connection between the placeholder and the variable
should be pretty clear.

-Peff
