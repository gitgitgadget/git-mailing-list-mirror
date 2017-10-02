Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580A0202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 05:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdJBFfe (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 01:35:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:57154 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750715AbdJBFfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 01:35:33 -0400
Received: (qmail 6893 invoked by uid 109); 2 Oct 2017 05:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 05:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25775 invoked by uid 111); 2 Oct 2017 05:36:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 01:36:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 01:35:31 -0400
Date:   Mon, 2 Oct 2017 01:35:31 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/11] lockfile: fix documentation on
 `close_lock_file_gently()`
Message-ID: <20171002053531.ohalpjhfrt4b5dld@sigill.intra.peff.net>
References: <cover.1506862824.git.martin.agren@gmail.com>
 <619c2cad465cf3994ef84908c97ad4c18ea26e78.1506862824.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <619c2cad465cf3994ef84908c97ad4c18ea26e78.1506862824.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 04:56:04PM +0200, Martin Ågren wrote:

> Commit 83a3069a3 (lockfile: do not rollback lock on failed close,
> 2017-09-05) forgot to update the documentation by the function definition
> to reflect that the lock is not rolled back in case closing fails.

Oops, thanks for catching. Patch looks obviously correct.

-Peff
