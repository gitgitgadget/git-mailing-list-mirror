Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 266D8203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbcGVTb5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:31:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45692 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbcGVTb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:31:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE516203E2;
	Fri, 22 Jul 2016 19:31:56 +0000 (UTC)
Date:	Fri, 22 Jul 2016 19:31:56 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	git-for-windows <git-for-windows@googlegroups.com>
Subject: Re: [PATCH ew/daemon-socket-keepalive] Windows: add missing
 definition of ENOTSOCK
Message-ID: <20160722193156.GA30158@dcvr>
References: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28dbe3b0-7a16-1b87-3d59-b8c981fead7c@kdbg.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> wrote:
> The previous commit introduced the first use of ENOTSOCK. This macro is
> not available on Windows. Define it as WSAENOTSOCK because that is the
> corresponding error value reported by the Windows versions of socket
> functions.

Thanks.   I thought compat/poll/poll.c already used ENOTSOCK
but I was mislead by the #ifdefs :x
