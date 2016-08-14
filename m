Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0912018E
	for <e@80x24.org>; Sun, 14 Aug 2016 22:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbcHNWwU (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 18:52:20 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52380 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbcHNWwT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 18:52:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 249391FD99;
	Sun, 14 Aug 2016 22:52:19 +0000 (UTC)
Date:	Sun, 14 Aug 2016 22:52:19 +0000
From:	Eric Wong <e@80x24.org>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Message-ID: <20160814225219.GA12202@dcvr>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com>
 <20160812224255.GA16250@dcvr>
 <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net>
 <20160813090432.GA25565@starla>
 <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net>
 <20160814012706.GA18784@starla>
 <A8D4E6C8B72B472BB7B580804F9FAB85@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8D4E6C8B72B472BB7B580804F9FAB85@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Wong" <e@80x24.org>
> >
> >Yes, I was somewhat careful to check for proper mboxes from gmane;
> >I just missed entire ranges :x
> >
> 
> There were a number of messages that were listed by gmane as being in the
> various Git for Windows lists such as msysgit, especially when the messages
> went to both lists (as the issue had common cause) that failed to get onto
> the regualr gmane list.
> 
> Are these something that has been included?

If they were on both lists, yes, gmane seems to miss some of
those messages, unfortunately.

> Philip
> 
> A quick search on a possible message gave
> https://public-inbox.org/git/55BF6808.1000500@web.de/ which has no parent,
> but that parent actually only went to the msysgit list, so no real surprise
> there, but I do remember some other cases that were on list - I just can't
> find them at the moment :-(.

If a message was only posted exclusively on other lists, it
should stay there and it's archives.  public-inbox provides a
way to lookup external messages by Message-ID for this reason.

Is there a way to lookup messages by Message-ID from the msysgit
archives?  I could add it to the existing list of alternate
Message-ID lookup services:

  https://public-inbox.org/meta/20160814054731.26194-1-e@80x24.org/

GoogleGroups doesn't seem usable without JavaScript at all,
unfortunately :<

I don't think the msysgit archives would be too large and I
wouldn't mind hosting them myself.  But, users on GoogleGroups
may not be used to our conventions and not appreciate having
their unobfuscated addresses exposed or reply-to-all...

I will probably add an option to support centralized lists to
public-inbox sometime, though.  I don't like centralization,
but completely inaccessible archives are worse.
