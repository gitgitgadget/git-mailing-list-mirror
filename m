Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB41A1FF34
	for <e@80x24.org>; Tue,  9 May 2017 04:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbdEIEJq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 00:09:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47911 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdEIEJq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 00:09:46 -0400
Received: (qmail 16400 invoked by uid 109); 9 May 2017 04:09:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 04:09:46 +0000
Received: (qmail 20052 invoked by uid 111); 9 May 2017 04:10:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 May 2017 00:10:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 May 2017 00:09:43 -0400
Date:   Tue, 9 May 2017 00:09:43 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Script to rebase branches
Message-ID: <20170509040943.j3n5li7fapiuvgbj@sigill.intra.peff.net>
References: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8D018370-79F9-450F-97AF-31EF4C95BA44@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 06, 2017 at 12:23:32PM +0200, Lars Schneider wrote:

> I am about to write a bash/sh script that helps me to rebase a bunch of 
> branches (e.g. select branches based on prefix, conflict resolution/
> rerere support, ...).
> 
> I wonder if anyone has such a script already and is willing to share it.

This is what I use:

  https://github.com/peff/git/blob/meta/rebase

There's no documentation in the script, but the commit message in its
history should give a good sense of what each part does.

-Peff
