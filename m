Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8078C2018E
	for <e@80x24.org>; Tue, 16 Aug 2016 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbcHPU4h (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:56:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54296 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbcHPU4h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:56:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8997E1F859;
	Tue, 16 Aug 2016 20:56:36 +0000 (UTC)
Date:	Tue, 16 Aug 2016 20:56:36 +0000
From:	Eric Wong <e@80x24.org>
To:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
Cc:	meta@public-inbox.org, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20160816205636.GA15363@dcvr>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
 <xmqqa8gcej1p.fsf@gitster.mtv.corp.google.com>
 <20160816204411.GA31448@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160816204411.GA31448@dcvr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eric Wong <e@80x24.org> wrote:
> Currently for web users, I suggest:
> 
> 	curl $URL >tmpXXX
> 
> 	# open tmpXXXX and tag+copy to patchesXXX using MUA of choice:
> 	# (also seems to be what Jeff describes):
> 	mutt -f tmpXXX
> 
> 	git am patchesXXXX

I should add this is also a better match to an "offline first"
workflow for disconnected use.  My Internet connections drop
all the time :<

I don't mind people over-downloading at all, and stuffing an
extra cover + comments is likely more efficient with gzip than
going back online to fetch separately.

> Perhaps adding checkbox next to each item might work as a
> select-to-include-in-mbox download form.

...So I'm not sure if I want to invest time into this idea
since either the server or user could be offline by the
time messages are selected.
