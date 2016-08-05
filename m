Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293462018E
	for <e@80x24.org>; Fri,  5 Aug 2016 18:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758999AbcHESq6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 14:46:58 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52140 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837AbcHESq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 14:46:57 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DF12018E;
	Fri,  5 Aug 2016 18:46:56 +0000 (UTC)
Date:	Fri, 5 Aug 2016 18:46:56 +0000
From:	Eric Wong <e@80x24.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160805184656.GA463@starla>
References: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
 <alpine.DEB.2.20.1608050925240.5786@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1608050925240.5786@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 4 Aug 2016, Stefan Beller wrote:
> > git send-email/format-patch recently learned to include a base commit
> 
> You may have noticed that my mail-patch-series.sh-generated code
> submissions contain that base commit. But they still do not contain the
> SHA-1s of my local commits corresponding to the patches, and even if they
> did, the replies with suggested edits would most likely have lost said
> information.
> 
> I also hate to break it to you that git-send-email is not going to be part
> of any solution.

I think it ought to be.  Some reasons I like emailing patches are:

* there's no taking it back once it's sent

* it's backed up within seconds by thousands of subscribers :)

* doesn't require the reader to have an active connection
  to fetch out-of-band

* doesn't require the reader to be on the same machine capable
  of cloning/building the project

There are times when I've been on a slow machine, or offline
when I wanted to read some patches.

However, I do like including a pull request in cover letters
of a patch series (not necessary for one-offs).



But on a side note, I also find it depressing that SMTP is
uncompressed and TLS compression is (still?) unsafe.  At least I
use ssh tunnels w/ compression for IMAP/SMTP to my own server.
