Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B961FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933265AbcLNQDe (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 11:03:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:56459 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932477AbcLNQDe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 11:03:34 -0500
Received: (qmail 4659 invoked by uid 109); 14 Dec 2016 16:03:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 16:03:33 +0000
Received: (qmail 26120 invoked by uid 111); 14 Dec 2016 16:04:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Dec 2016 11:04:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2016 11:03:30 -0500
Date:   Wed, 14 Dec 2016 11:03:30 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCH v9 4/5] http: create function to get curl allowed
 protocols
Message-ID: <20161214160330.iqvwxshsgk4n2gm7@sigill.intra.peff.net>
References: <1480636862-40489-1-git-send-email-bmwill@google.com>
 <1481679637-133137-1-git-send-email-bmwill@google.com>
 <1481679637-133137-5-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481679637-133137-5-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 05:40:36PM -0800, Brandon Williams wrote:

> Move the creation of an allowed protocols whitelist to a helper
> function.

This is "what" but not "why". You can figure it out if you see the next
patch, but it's often nice to make a brief mention, like:

  This will be useful when we need to compute the set of allowed
  protocols differently for normal and redirect cases.

-Peff
