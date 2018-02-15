Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209021F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbeBOFxh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:53:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:53422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752423AbeBOFxg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:53:36 -0500
Received: (qmail 2578 invoked by uid 109); 15 Feb 2018 05:53:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:53:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7377 invoked by uid 111); 15 Feb 2018 05:54:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:54:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:53:34 -0500
Date:   Thu, 15 Feb 2018 00:53:34 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 16/23] ref-filter: make cat_file_info independent
Message-ID: <20180215055334.GN18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4376-0d1c5615-ae9c-4320-bc2d-fd3bda19bce0-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4376-0d1c5615-ae9c-4320-bc2d-fd3bda19bce0-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Remove connection between expand_data variable
> in cat-file and in ref-filter.
> It will help further to get rid of using expand_data in cat-file.

I have to admit I'm confused at this point about what is_cat_file is
for, or even why we need cat_file_data. Shouldn't these items be handled
by their matching ref-filter atoms at this point?

-Peff
