Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A467020450
	for <e@80x24.org>; Sun,  5 Nov 2017 09:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbdKEJiL (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 04:38:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:46816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752244AbdKEJiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 04:38:10 -0500
Received: (qmail 30596 invoked by uid 109); 5 Nov 2017 09:38:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 05 Nov 2017 09:38:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14184 invoked by uid 111); 5 Nov 2017 09:38:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 05 Nov 2017 04:38:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Nov 2017 04:38:08 -0500
Date:   Sun, 5 Nov 2017 04:38:08 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: what is the function of .git/branches/?
Message-ID: <20171105093808.oxxchoh6j4b6yv37@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1711051122160.3602@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711051122160.3602@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 05, 2017 at 11:24:00AM +0200, Robert P. J. Day wrote:

>   currently proofing "pro git" book, and an example of a new repo
> doesn't show a .git/branches/ directory, but initializing a new repo
> with current version of 2.13.6 *does* show an initially empty
> directory by that name. however, AFAICT, branches are still tracked
> under .git/refs/heads/, so what's with that branches/ directory?

It's a historical way of storing what's now in the "[remote]" section of
config files. It's covered briefly in "git help repository-layout"
(which is a good starting point for similar questions), and in more
detail in the REMOTES section of fetch/pull/push.

-Peff
