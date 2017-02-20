Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33EEF201B0
	for <e@80x24.org>; Mon, 20 Feb 2017 09:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbdBTJBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 04:01:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:58665 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbdBTJBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 04:01:18 -0500
Received: (qmail 10878 invoked by uid 109); 20 Feb 2017 09:01:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 09:01:17 +0000
Received: (qmail 14966 invoked by uid 111); 20 Feb 2017 09:01:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 04:01:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 04:01:16 -0500
Date:   Mon, 20 Feb 2017 04:01:16 -0500
From:   Jeff King <peff@peff.net>
To:     Toolforger <toolforger@durchholz.org>
Cc:     git@vger.kernel.org
Subject: Re: url.<base>.insteadOf vs. submodules
Message-ID: <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 10:12:28PM +0100, Toolforger wrote:

> I am trying to make url.<base>.insteadOf work on the URLs inside
> .gitmodules, but it won't work (applying it to the repo itself works fine,
> to the config setting seems to be fine).

The submodule operations happen in their own processes, and do not look
at the config of the parent repo. Are you setting the config in
.git/config of the super-project?

I don't know if there plans to make that work, but one workaround is to
set the config in ~/.gitconfig.

-Peff
