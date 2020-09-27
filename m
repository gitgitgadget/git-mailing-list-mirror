Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F8C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B9A23998
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbgI0InK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:43:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:42454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbgI0InJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:43:09 -0400
Received: (qmail 29233 invoked by uid 109); 27 Sep 2020 08:43:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:43:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4208 invoked by uid 111); 27 Sep 2020 08:43:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:43:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:43:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2020, #07; Fri, 25)
Message-ID: <20200927084308.GA2465822@coredump.intra.peff.net>
References: <xmqq3635jwhu.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq3635jwhu.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 03:57:01PM -0700, Junio C Hamano wrote:

> * jk/shortlog-group-by-trailer (2020-09-25) 8 commits
>  - shortlog: allow multiple groups to be specified
>  - shortlog: parse trailer idents
>  - shortlog: rename parse_stdin_ident()
>  - shortlog: de-duplicate trailer values
>  - shortlog: match commit trailers with --group
>  - trailer: add interface for iterating over commit trailers
>  - shortlog: refactor committer/author grouping
>  - shortlog: change "author" variables to "ident"
> 
>  "git shortlog" has been taught to group commits by the contents of
>  the trailer lines, like "Reviewed-by:", "Coauthored-by:", etc.
> 
>  Will merge to 'next'.

Note that I just sent out a v2 of this one in response to review:

  https://lore.kernel.org/git/20200927083933.GA2222823@coredump.intra.peff.net/

The changes are fairly minor, so I think it would be OK to proceed as
planned with v2 in your next integration cycle.

-Peff
