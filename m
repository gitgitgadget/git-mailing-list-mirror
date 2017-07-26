Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CD0B2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 13:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdGZNRc (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 09:17:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:49422 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751097AbdGZNRb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 09:17:31 -0400
Received: (qmail 28931 invoked by uid 109); 26 Jul 2017 13:17:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jul 2017 13:17:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25746 invoked by uid 111); 26 Jul 2017 13:17:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Jul 2017 09:17:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Jul 2017 09:17:29 -0400
Date:   Wed, 26 Jul 2017 09:17:29 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fsck: cleanup unused variable
Message-ID: <20170726131729.o6bp2qmlqpl674zt@sigill.intra.peff.net>
References: <20170726013456.4187-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170726013456.4187-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 06:34:56PM -0700, Jonathan Tan wrote:

> Remove the unused variable "heads" from cmd_fsck().
> 
> This variable was made unused in commit c3271a0 ("fsck: do not fallback
> "git fsck <bogus>" to "git fsck"", 2017-01-17).

Thanks, I should have caught this then.

The patch is obviously correct, though I'm curious why gcc's
-Wunused-but-set-variable didn't catch this.

-Peff
