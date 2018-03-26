Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3F31F404
	for <e@80x24.org>; Mon, 26 Mar 2018 12:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeCZMsu (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 08:48:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:43150 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751141AbeCZMsu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 08:48:50 -0400
Received: (qmail 23926 invoked by uid 109); 26 Mar 2018 12:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 12:48:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19122 invoked by uid 111); 26 Mar 2018 12:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 08:49:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 08:48:48 -0400
Date:   Mon, 26 Mar 2018 08:48:48 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test_must_be_empty: simplify file existence check
Message-ID: <20180326124847.GA21993@sigill.intra.peff.net>
References: <20180326115815.10180-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180326115815.10180-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 01:58:15PM +0200, SZEDER Gábor wrote:

> Commit ea3c87d0b7 (test_must_be_empty: make sure the file exists, not
> just empty, 2018-02-27) basically duplicated the 'test_path_is_file'
> helper function in 'test_must_be_empty'.
> 
> Just call 'test_path_is_file' to avoid this code duplication.

This looks like an improvement to me.

I think you meant to reference 11395a3b4b16d9fc637ca2e41a6892ea2e6289ce,
though (I don't have ea3c87d0b7 at all).

-Peff
