Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D5E2018E
	for <e@80x24.org>; Sat,  9 Jul 2016 23:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbcGIXpU (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 19:45:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:39754 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846AbcGIXpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 19:45:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415992018E;
	Sat,  9 Jul 2016 23:45:18 +0000 (UTC)
Date:	Sat, 9 Jul 2016 23:45:18 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2016, #03; Fri, 8)
Message-ID: <20160709234518.GA3702@dcvr.yhbt.net>
References: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq37njlora.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> * sb/submodule-parallel-fetch (2016-06-27) 2 commits
>   (merged to 'next' on 2016-07-06 at de5fd35)
>  + xwrite: poll on non-blocking FDs
>  + xread: retry after poll on EAGAIN/EWOULDBLOCK
> 
>  Fix a recently introduced codepaths that are involved in parallel
>  submodule operations, which gave up on reading too early, and
>  could have wasted CPU while attempting to write under a corner case
>  condition.
> 
>  Will merge to 'master'.

Any thoughts on my cleanup 3/2 patch for this series?
("hoist out io_wait function for xread and xwrite")
https://public-inbox.org/git/20160627201311.GA7039@dcvr.yhbt.net/raw

Jeff liked it:
https://public-inbox.org/git/20160627214947.GA17149@sigill.intra.peff.net/
