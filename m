Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D291F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 19:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbeGMUIf (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 16:08:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:58888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730017AbeGMUIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 16:08:35 -0400
Received: (qmail 1064 invoked by uid 109); 13 Jul 2018 19:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 19:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6810 invoked by uid 111); 13 Jul 2018 19:52:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 15:52:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 15:52:31 -0400
Date:   Fri, 13 Jul 2018 15:52:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: What's cooking in git.git (Jul 2018, #01; Wed, 11)
Message-ID: <20180713195230.GA11860@sigill.intra.peff.net>
References: <xmqq7em138a5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7em138a5.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 12:02:42PM -0700, Junio C Hamano wrote:

> * jk/fsck-gitmodules-gently (2018-07-03) 5 commits
>  - fsck: silence stderr when parsing .gitmodules
>  - fsck: silence stderr when parsing .gitmodules
>  - config: add options parameter to git_config_from_mem
>  - config: add CONFIG_ERROR_SILENT handler
>  - config: turn die_on_error into caller-facing enum
> 
>  What's the status of this one?

I think the bottom 4 are fine. We should drop the top "something like
this" patch, and replace it with two patches I just sent in that thread:

  https://public-inbox.org/git/20180713193759.GB10354@sigill.intra.peff.net/

Note the bit I mentioned about building it in the opposite order; let me
know if you'd prefer that.

There's also some discussion there about queuing Ramsay's skiplist patch
separately. It looks like you already have rj/submodule-fsck-skip marked
for merging to master, which is fine.

-Peff
