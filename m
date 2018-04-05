Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CB21F404
	for <e@80x24.org>; Thu,  5 Apr 2018 21:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeDEV6C (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 17:58:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:55086 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751465AbeDEV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 17:58:02 -0400
Received: (qmail 8573 invoked by uid 109); 5 Apr 2018 21:58:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 21:58:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19633 invoked by uid 111); 5 Apr 2018 21:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 17:59:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 17:58:00 -0400
Date:   Thu, 5 Apr 2018 17:58:00 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v4 0/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180405215759.GB29117@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180405020034.GA8879@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405020034.GA8879@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 07:00:34PM -0700, Taylor Blau wrote:

> I have attached a fourth re-roll of my series to introduce
> "--type=<type>" in "git config", and prefer it to "--<type>".
> 
> In particular, since the last update, I have changed the following:
> 
>   - Clearer wording in the second patch per Eric's suggestion.
> 
>   - Stopped spelling the required argument to "--type=" as "[type]", and
>     instead as "<type>" (cc: Eric).
> 
>   - Changed "unexpected" to "unrecognized" in the fatal message when we
>     don't know how to interpret the argument to "--type".

This iteration looks good to me, assuming that last-one-wins is still
the direction we want to go. I'm open to the notion that the cleanup is
not worth the change in behavior. It is IMHO, but obviously it's
somewhat subjective.

-Peff
