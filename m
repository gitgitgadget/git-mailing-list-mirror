Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0BE31FEB3
	for <e@80x24.org>; Wed,  4 Jan 2017 01:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965541AbdADBTr (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:19:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:34911 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760140AbdADBTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:19:32 -0500
Received: (qmail 12701 invoked by uid 109); 4 Jan 2017 01:18:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 01:18:44 +0000
Received: (qmail 28421 invoked by uid 111); 4 Jan 2017 01:19:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 Jan 2017 20:19:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2017 20:18:41 -0500
Date:   Tue, 3 Jan 2017 20:18:41 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, l.s.r@web.de, git@vger.kernel.org
Subject: Re: [PATCHv2] submodule.c: use GIT_DIR_ENVIRONMENT consistently
Message-ID: <20170104011841.bpoiqvi5hqsdqu7y@sigill.intra.peff.net>
References: <6dd0a31e-d877-5311-37ef-313ed9ab9716@web.de>
 <20170103183047.17968-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170103183047.17968-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 03, 2017 at 10:30:47AM -0800, Stefan Beller wrote:

> In C code we have the luxury of having constants for all the important
> things that are hard coded. This is the only place in C, that hard codes
> the git directory environment variable, so fix it.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

This looks like a good change to me.

Minor nit: the comma after "C" in your commit message is extraneous. ;)

-Peff
