Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31E41F744
	for <e@80x24.org>; Wed, 20 Jul 2016 13:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbcGTNm0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 09:42:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:47474 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbcGTNmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 09:42:25 -0400
Received: (qmail 10323 invoked by uid 102); 20 Jul 2016 13:42:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:42:25 -0400
Received: (qmail 20660 invoked by uid 107); 20 Jul 2016 13:42:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 09:42:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 07:42:12 -0600
Date:	Wed, 20 Jul 2016 07:42:12 -0600
From:	Jeff King <peff@peff.net>
To:	Richard Soderberg <rsoderberg@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: git-prompt.sh incompatible with non-basic global grep.patternType
Message-ID: <20160720134211.GA19359@sigill.intra.peff.net>
References: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 03:56:09PM -0700, Richard Soderberg wrote:

> ps. git log --basic-regexp does not fix the issue, as for unknown
> reasons (I'll start another thread) the command-line option doesn't
> override grep.patternType.

Dscho gave a fix for your immediate issue, but this "ps" definitely
seems like a bug to me. Command-line options should always take
precedence over config.

-Peff
