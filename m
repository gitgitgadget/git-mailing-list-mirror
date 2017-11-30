Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105FD20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 20:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750891AbdK3Uap (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 15:30:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:44762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750768AbdK3Uao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 15:30:44 -0500
Received: (qmail 21748 invoked by uid 109); 30 Nov 2017 20:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Nov 2017 20:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31822 invoked by uid 111); 30 Nov 2017 20:31:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 30 Nov 2017 15:31:03 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Nov 2017 15:30:42 -0500
Date:   Thu, 30 Nov 2017 15:30:42 -0500
From:   Jeff King <peff@peff.net>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, kaartic.sivaraam@gmail.com,
        sandals@crustytoothpaste.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/2] refactor "dumb" terminal determination
Message-ID: <20171130203042.GB3313@sigill.intra.peff.net>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
 <20171129143752.60553-2-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171129143752.60553-2-lars.schneider@autodesk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 03:37:51PM +0100, lars.schneider@autodesk.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Move the code to detect "dumb" terminals into a single location. This
> avoids duplicating the terminal detection code yet again in a subsequent
> commit.

Makes sense, and probably worth doing even if we don't follow through on
2/2.

The patch itself looks good to me.

-Peff
