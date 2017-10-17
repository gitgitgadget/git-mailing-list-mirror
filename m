Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7685C202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 04:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756296AbdJQEOI (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 00:14:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:55018 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755668AbdJQEOI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 00:14:08 -0400
Received: (qmail 32098 invoked by uid 109); 17 Oct 2017 04:14:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 04:14:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20227 invoked by uid 111); 17 Oct 2017 04:14:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Oct 2017 00:14:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Oct 2017 00:14:05 -0400
Date:   Tue, 17 Oct 2017 00:14:05 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/1] mention git stash push first in the man page
Message-ID: <20171017041405.eavuutzgzgs4ppk2@sigill.intra.peff.net>
References: <20171005200049.GF30301@hank>
 <20171005201029.4173-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171005201029.4173-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 09:10:29PM +0100, Thomas Gummerer wrote:

> Because 'stash push' and 'stash save' are so closely related they share one
> section in the man page.  Currently 'stash save' comes first, as that
> was the command that people were historically using.  However this makes
> the newer, more feature rich git stash push very easy to overlook.
> Change the order to give the newer interface for creating a stash the
> more prominent position.

Seems reasonable, though if we are deprecating "save" should we demote
it from being in the synopsis entirely?

-Peff
