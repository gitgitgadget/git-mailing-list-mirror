Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5151F437
	for <e@80x24.org>; Sat, 28 Jan 2017 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbdA1XzM (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 18:55:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:46446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751471AbdA1XzL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 18:55:11 -0500
Received: (qmail 1513 invoked by uid 109); 28 Jan 2017 23:55:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Jan 2017 23:55:01 +0000
Received: (qmail 18744 invoked by uid 111); 28 Jan 2017 23:55:01 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 28 Jan 2017 18:55:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jan 2017 18:54:56 -0500
Date:   Sat, 28 Jan 2017 18:54:56 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset
 --hard
Message-ID: <20170128235455.clv5x7m6n3mzilyt@sigill.intra.peff.net>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-2-t.gummerer@gmail.com>
 <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
 <xmqqfuk6alba.fsf@gitster.mtv.corp.google.com>
 <20170128192958.GB31189@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170128192958.GB31189@hank>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 28, 2017 at 07:30:28PM +0000, Thomas Gummerer wrote:

> Thanks all who chimed in here.  My new description is definitely not
> right.  The reason I wanted to change it is part because it's an
> implementation detail, and part because it's going to be not quite
> right when the filename argument is introduced.
> 
> How about the following:
> 
>  	Save your local modifications to a new 'stash' and roll them back
>  	both in the working tree and in the index.
> 
> As an added bonus this also matches what git stash save -p does.

IMHO that is both informative and accurate. You could add:
 
  (unless --keep-index was used)

at the end of the sentence, though I am not sure it is necessary.

-Peff
