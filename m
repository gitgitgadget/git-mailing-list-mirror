Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DC01F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbeBOFSe (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:18:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:53312 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750743AbeBOFSd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:18:33 -0500
Received: (qmail 402 invoked by uid 109); 15 Feb 2018 05:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7112 invoked by uid 111); 15 Feb 2018 05:19:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:19:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:18:31 -0500
Date:   Thu, 15 Feb 2018 00:18:31 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 03/23] cat-file: reuse struct ref_format
Message-ID: <20180215051831.GC18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f432e-07d6260a-0100-4859-af1c-2cdf8da76829-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f432e-07d6260a-0100-4859-af1c-2cdf8da76829-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Start using ref_format struct instead of simple char*.
> Need that for further reusing of formatting logic from ref-filter.

Makes sense, and the patch itself looks correct.

-Peff
