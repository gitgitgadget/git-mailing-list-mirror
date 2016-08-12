Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060F11F859
	for <e@80x24.org>; Fri, 12 Aug 2016 22:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbcHLWm6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 18:42:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35176 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbcHLWm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 18:42:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054EF1F859;
	Fri, 12 Aug 2016 22:42:56 +0000 (UTC)
Date:	Fri, 12 Aug 2016 22:42:55 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160812224255.GA16250@dcvr>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> For those who prefer to read it over NNTP:
> 
> 	nntp://news.gmane.org/gmane.comp.version-control.git
> 
> is still available.  An alternative
> 
>         nntp://news.public-inbox.org/inbox.comp.version-control.git
> 
> will become usable once it catches up with old messages.

Mostly caught up, I injected 33 more today which were
cross-posted (which tripped up some of my anti-spam rules) or
simply missed by gmane.

There may be more in some personal archives gmane doesn't
have...

I've also added NNTP links (including gmane) to the footer in
public-inbox.org/git

> message ID is often the most robust (if not very friendly) way to do
> so, like this:
> 
> 	http://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org

Some of the generated links have %40 in them which is the URI
escape for '@'.  I'll make a change to keep the '@' unescaped to
lessen confusion.

Due to the use of SQLite as a stable store for NNTP article
numbers; public-inbox can also do partial matching (up to 100
results, currently) to help correct legitimate mistakes; but I
wouldn't rely on it too much:

	public-inbox.org/git/Pine.LNX.4.58.0504150753440
