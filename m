Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D305F1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 19:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757329AbcG1TD2 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 15:03:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42556 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754969AbcG1TD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 15:03:27 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A76151F858;
	Thu, 28 Jul 2016 19:03:26 +0000 (UTC)
Date:	Thu, 28 Jul 2016 19:03:26 +0000
From:	Eric Wong <e@80x24.org>
To:	Duy Nguyen <pclouds@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: Alternatives to mid.gmane.org?
Message-ID: <20160728190326.GA9430@starla>
References: <481D1EE2-6A66-418F-AB28-95947BBF3680@gmail.com>
 <CACsJy8Cr-=09dDMTNpqobPkcVjU54+b-fLX61+cz2jkS8o+Tiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Cr-=09dDMTNpqobPkcVjU54+b-fLX61+cz2jkS8o+Tiw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 28, 2016 at 11:11 AM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
> > Hi,
> >
> > gmane is down

At least the following should work in case public-inbox fails:

	https://mid.mail-archive.com/%s
	https://marc.info/?i=%s

public-inbox falls back to them on missing MIDs,
along with https://lists.debian.org/msgid-search/%s

I trip over power cords all the time, I'm hoping other
people mirror/replicate the setup Jeff also linked to:

https://public-inbox.org/git/20160710004813.GA20210@dcvr.yhbt.net/

Right now my email subscription is still an SPOF for the mirror,
along with vger.kernel.org...

> I read this and thought "temporarily" but apparently it's not [1]. A
> lot of our links in the mail archive are gmane's :(
> 
> [1] https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane/

:<

I'll see what I can do about getting a gmane NUM -> MID mapping
up while NNTP still works...
