Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F7501F859
	for <e@80x24.org>; Wed, 10 Aug 2016 01:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbcHJB5i (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 21:57:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56506 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932540AbcHJB5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 21:57:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A83A41F859;
	Wed, 10 Aug 2016 01:57:36 +0000 (UTC)
Date:	Wed, 10 Aug 2016 01:57:36 +0000
From:	Eric Wong <e@80x24.org>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160810015736.GA17898@starla>
References: <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <20160809182800.GA19044@dcvr>
 <20160810005548.gee6ontd33ck5vej@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160810005548.gee6ontd33ck5vej@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Aug 09, 2016 at 06:28:00PM +0000, Eric Wong wrote:
> > Some of these problems I hope public-inbox (or something like
> > it) can fix and turn the tide towards email, again.
> 
> This really seems like the dichotomy that drives people towards central
> services like GitHub or GitLab.  We need an alternative that doesn't
> involve email, or at the very least, doesn't require people to use email
> directly.  Half of the pain in the process comes from coaxing email
> clients that don't treat mail text as sacrosanct to leave it alone and
> not mangle it.  (Some of that would go away if we accepted attachments
> with inline disposition, but not all of it.  All of it would go away if
> the submission process just involved "git push" to an appropriate
> location.)

I don't mind patches as attachments and did some work a few
months ago to ensure they're individually downloadable in the
public-inbox WWW interface (along with full mboxrd messages)[1].

Fwiw, attachments are preferred in perl5-porters, and it might
be acceptable on LKML, even.  Not my call, though.

Having a push/pull-only workflow would still require some sort
of messaging system to notify others.  Ideally that message
would have the output of "git request-pull" to ensure people are
on the same page; but I'd prefer patches (either attachments or
inline) continue to be sent anyways in case the server is down
or the reader is offline or on a machine without git.

[1] see Brian's (who is new, here) initial email for diff-highlight:
    https://public-inbox.org/git/20160728162712.GA29220@tci.corp.yp.com/
