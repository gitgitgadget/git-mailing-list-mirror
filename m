Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62EBF1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeBOF0H (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:26:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:53332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751954AbeBOF0G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:26:06 -0500
Received: (qmail 859 invoked by uid 109); 15 Feb 2018 05:26:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:26:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7176 invoked by uid 111); 15 Feb 2018 05:26:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:26:51 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:26:04 -0500
Date:   Thu, 15 Feb 2018 00:26:04 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 05/23] cat-file: move struct expand_data into
 ref-filter
Message-ID: <20180215052604.GE18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4325-7ab9a01a-ab67-4beb-9721-3dcc5095720a-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4325-7ab9a01a-ab67-4beb-9721-3dcc5095720a-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Need that for further reusing of formatting logic in cat-file.
> Have plans to get rid of using expand_data in cat-file at all,
> and use it only in ref-filter for collecting, formatting and printing
> needed data.

This seems like another step that we're going to end up reversing later,
because ref-filter has a different representation for these kinds of
expansions. I'll keep reading...

-Peff
