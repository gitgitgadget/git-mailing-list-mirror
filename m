Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2587D1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 21:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767AbcG1U77 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 16:59:59 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48478 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757635AbcG1U76 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 16:59:58 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF921F858;
	Thu, 28 Jul 2016 20:59:57 +0000 (UTC)
Date:	Thu, 28 Jul 2016 20:59:57 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: Re: [ANNOUNCE] more archives of this list
Message-ID: <20160728205957.GA16391@starla>
References: <20160710004813.GA20210@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160710004813.GA20210@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Code is AGPL-3.0+: git clone https://public-inbox.org/
> 
> 
> Additional mirrors or forks (perhaps different UIs) are very welcome,

Btw, it's possible to do quote highlighting with user-side CSS:

https://public-inbox.org/meta/20160709-user-side-css-example@11/

Will probably add classes for diff colors, too, since a git
repository browser with mailing list integration will happen.

For the moment, cgit + examples/cgit-commit-filter.lua allows
searching subjects (at least non-merge ones).

So the commit subject below is a link:
https://bogomips.org/mirrors/git.git/commit/?id=7b35efd734e501f
to:
https://public-inbox.org/git/?x=t&q="fsck_walk():+optionally+name+objects+on+the+go"
