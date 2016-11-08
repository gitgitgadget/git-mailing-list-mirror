Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84D7B2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 22:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752973AbcKHWE3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 17:04:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:40370 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbcKHWE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 17:04:29 -0500
Received: (qmail 32642 invoked by uid 109); 8 Nov 2016 22:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 22:04:28 +0000
Received: (qmail 24678 invoked by uid 111); 8 Nov 2016 22:04:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Nov 2016 17:04:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Nov 2016 17:04:26 -0500
Date:   Tue, 8 Nov 2016 17:04:26 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 2/2] transport: add protocol policy config option
Message-ID: <20161108220426.bqvmmjr54w7btgih@sigill.intra.peff.net>
References: <1478547323-47332-1-git-send-email-bmwill@google.com>
 <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1478555462-132573-2-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478555462-132573-2-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 01:51:02PM -0800, Brandon Williams wrote:

> Previously the `GIT_ALLOW_PROTOCOL` environment variable was used to
> specify a whitelist of protocols to be used in clone/fetch/push
> commands.  This patch introduces new configuration options for more
> fine-grained control for allowing/disallowing protocols.  This also has
> the added benefit of allowing easier construction of a protocol
> whitelist on systems where setting an environment variable is
> non-trivial.

This v5 looks good to me (both patches 1 and 2).

-Peff
