Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F45420986
	for <e@80x24.org>; Mon, 10 Oct 2016 13:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752400AbcJJNK5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 09:10:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:54975 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752218AbcJJNKn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 09:10:43 -0400
Received: (qmail 21104 invoked by uid 109); 10 Oct 2016 13:10:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 13:10:42 +0000
Received: (qmail 30308 invoked by uid 111); 10 Oct 2016 13:11:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 09:11:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 09:10:41 -0400
Date:   Mon, 10 Oct 2016 09:10:41 -0400
From:   Jeff King <peff@peff.net>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
 handle distro changes to DEF_VER
Message-ID: <20161010131041.lpdh4a7nol24hsz2@sigill.intra.peff.net>
References: <20161010025323.9415-1-jeremyhu@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161010025323.9415-1-jeremyhu@apple.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 09, 2016 at 07:53:23PM -0700, Jeremy Huddleston Sequoia wrote:

> Subject: Re: [PATCH] t4014-format-patch: Adjust git_version regex to better
>  handle distro changes to DEF_VER
>
> Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>

I see there was a discussion elsewhere on the list about exactly what
you are putting into DEF_VAR that causes the problem. Perhaps the commit
message here would be a good place to mention that, why the current
regex breaks it, and why your new version fixes not only it, but other
possible values of DEF_VAR.

-Peff
