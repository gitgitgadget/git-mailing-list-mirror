Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E831F859
	for <e@80x24.org>; Wed, 10 Aug 2016 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbcHJA4A (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 20:56:00 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53079 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517AbcHJA4A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 20:56:00 -0400
Received: from x (unknown [IPv6:2605:e000:d5ce:1e00:c5f5:b7bf:c731:5d3f])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 3A78B172094;
	Wed, 10 Aug 2016 02:55:51 +0200 (CEST)
Date:	Tue, 9 Aug 2016 14:55:49 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Eric Wong <e@80x24.org>
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
Message-ID: <20160810005548.gee6ontd33ck5vej@x>
References: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <20160809182800.GA19044@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160809182800.GA19044@dcvr>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 06:28:00PM +0000, Eric Wong wrote:
> Some of these problems I hope public-inbox (or something like
> it) can fix and turn the tide towards email, again.

This really seems like the dichotomy that drives people towards central
services like GitHub or GitLab.  We need an alternative that doesn't
involve email, or at the very least, doesn't require people to use email
directly.  Half of the pain in the process comes from coaxing email
clients that don't treat mail text as sacrosanct to leave it alone and
not mangle it.  (Some of that would go away if we accepted attachments
with inline disposition, but not all of it.  All of it would go away if
the submission process just involved "git push" to an appropriate
location.)

- Josh Triplett
