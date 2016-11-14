Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA471F858
	for <e@80x24.org>; Mon, 14 Nov 2016 14:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbcKNOCR (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 09:02:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:42737 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbcKNOCP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 09:02:15 -0500
Received: (qmail 30616 invoked by uid 109); 14 Nov 2016 14:02:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 14:02:11 +0000
Received: (qmail 980 invoked by uid 111); 14 Nov 2016 14:02:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Nov 2016 09:02:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2016 09:02:09 -0500
Date:   Mon, 14 Nov 2016 09:02:09 -0500
From:   Jeff King <peff@peff.net>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] diffcore-delta: remove unused parameter to
 diffcore_count_changes()
Message-ID: <20161114140209.6bldrtruqs5ltndk@sigill.intra.peff.net>
References: <20161114133905.6632-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161114133905.6632-1-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2016 at 02:39:05PM +0100, Tobias Klauser wrote:

> The delta_limit parameter to diffcore_count_changes() has been unused
> since commit ba23bbc8e ("diffcore-delta: make change counter to byte
> oriented again.", 2006-03-04).
> 
> Remove the parameter and adjust all callers.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
> v2: In the commit message, reference the correct commit where the parameter
>     usage was removed. Spotted by Jeff King.

Looks good. Thanks for following up.

-Peff
