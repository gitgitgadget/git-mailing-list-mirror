Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A9E201A4
	for <e@80x24.org>; Sat, 13 May 2017 09:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbdEMJ0D (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 05:26:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:50783 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbdEMJ0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 05:26:02 -0400
Received: (qmail 29667 invoked by uid 109); 13 May 2017 09:26:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 09:26:02 +0000
Received: (qmail 30717 invoked by uid 111); 13 May 2017 09:26:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 05:26:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 May 2017 05:26:00 -0400
Date:   Sat, 13 May 2017 05:26:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2017, #04; Fri, 12)
Message-ID: <20170513092600.zmblth7vuzfwbsuw@sigill.intra.peff.net>
References: <xmqqpofe60dy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpofe60dy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 03:43:21PM +0900, Junio C Hamano wrote:

> * sg/clone-refspec-from-command-line-config (2017-05-09) 2 commits
>  - git-clone --config order & fetching extra refs during initial clone
>  - clone: respect configured fetch respecs during initial fetch
> 
>  "git clone -c var=val" is a way to set configuration variables in
>  the resulting repository, but it is more useful to also make these
>  variables take effect while the initial clone is happening,
>  e.g. these configuration variables could be fetch refspecs.
> 
>  Will merge to 'next'.

I think the top one was meant to be a squash (certainly the commit
message isn't quite up to par). Let me know if you'd prefer it as a
separate cleanup and I can write a commit message and sign-off.

-Peff
