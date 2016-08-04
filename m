Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5670120193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbcHDUSL (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:18:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40920 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987AbcHDUSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:18:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACFDD20228;
	Thu,  4 Aug 2016 20:17:51 +0000 (UTC)
Date:	Thu, 4 Aug 2016 20:17:51 +0000
From:	Eric Wong <e@80x24.org>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160804201751.GA9592@starla>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> wrote:
> On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > I guess I have no really good idea yet, either, how to retain the ease of
> > access of sending mails to the list, yet somehow keep a strong tie with
> > the original data stored in Git.
> 
> Does it have to be email? Transmitting text could be solved
> differently as well.

I've thought a lot about this over the years still think email
is the least bad.

Anti-spam tools for other messaging systems are far behind,
proprietary, or non-existent.  bugzilla.kernel.org has been hit
hard lately and I see plenty of bug-tracker-to-mail spam as a
result from projects that use web-based bug trackers.

And email spam filtering isn't even that great
(and I think it needs to be better for IPv6 and .onion adoption
 since much of it is still IPv4-oriented blacklisting).

I guess a blockchain (*coin) implementation might work (like
hashcash is used for email anti-spam), but the ones I've glanced
at all look like a bigger waste of electricity than email
filters.


Of course, centralized systems are unacceptable to me;
and with that I'll never claim any network service I run
will be reliable :)
