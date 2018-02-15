Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5D991F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754771AbeBOF5O (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:57:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:53450 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751929AbeBOF5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:57:14 -0500
Received: (qmail 2846 invoked by uid 109); 15 Feb 2018 05:57:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:57:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7446 invoked by uid 111); 15 Feb 2018 05:57:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:57:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:57:12 -0500
Date:   Thu, 15 Feb 2018 00:57:12 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 21/23] for-each-ref: tests for new atoms added
Message-ID: <20180215055711.GQ18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f438c-9d30a51c-129c-4721-a85a-a3d66a2270b6-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f438c-9d30a51c-129c-4721-a85a-a3d66a2270b6-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Add tests for new formatting atoms: rest, deltabase, objectsize:disk.
> rest means nothing and we expand it into empty string.
> We need this atom for cat-file command.
> Have plans to support deltabase and objectsize:disk further
> (as it is done in cat-file), now also expand it to empty string.

I'm glad that you're adding tests, but I'm not sure it's a good idea to
add tests checking for the thing we know to be wrong. If anything, you
could be adding test_expect_failure looking for the _right_ thing, and
accept that it does not yet work.

-Peff
