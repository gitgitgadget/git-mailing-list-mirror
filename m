Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ACCA1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbcHIS2E (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:28:04 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35748 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbcHIS2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:28:01 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F651F859;
	Tue,  9 Aug 2016 18:28:00 +0000 (UTC)
Date:	Tue, 9 Aug 2016 18:28:00 +0000
From:	Eric Wong <e@80x24.org>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809182800.GA19044@dcvr>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 08/04/2016 05:58 PM, Johannes Schindelin wrote:
> > [...]
> > Even requiring every contributor to register with GitHub would be too much
> > of a limitation, I would wager.
> > [...]

> * Discussion of pull requests can be done either
>   * via the website (super easy for beginners but powerful for
> experienced users),
>   * by setting up email notifications for your account and replying to
> those emails, or
>   * via an API.
>   Such discussion is all in markdown, which supports light formatting,
> hyperlinks, and @-mentions.

<snip>

> Disclaimer: I work for GitHub, but in this email I'm speaking for myself.
> 
> Michael
> 
> [1] I concede that people who refuse on ideological grounds to use
> proprietary software will find this step insurmountable. Perhaps we
> could come up with a workaround for such people.

I'm one of those ideological people and I don't see an
acceptable workaround.  GitHub already has misfeatures designed
to lock people in into centralized messaging:

* pull request feature doesn't work for self-hosted repos
  (this disincentivizes people from running and improving
   git-daemon/git-http-backend/etc...)

* "noreply" email addresses

* @-mentions you wrote about

* custom email notifications

This is a problem with Gitlab, Redmine, etc, too:
they cannot interoperate with each other.

At least for now, large proprietary mail providers like Gmail
still interoperate with whatever Free Software SMTP software I
run.  I dread the day when that is no longer true.

Some of these problems I hope public-inbox (or something like
it) can fix and turn the tide towards email, again.  In
contrast, public-inbox is designed to push decentralization:

* "reply" links are instructions for "git send-email" which
  encourage reply-to-all (this applies to what Jeff said
  about vger going down, I noticed it, too)

* anybody can clone the code + repo, replicate the
  instances, and tweak it to their needs.

* public-inbox.org/git/$MESSAGE_ID/t.atom allows subscriptions
  to Atom feeds without any registration or user-tracking

* Message-IDs are exposed for proper threading and interop

* low-bandwidth, Tor-friendly design to encourage deployments
  even behind NATs and firewalls.

Anyways, my optimistic side might interpret your advocacy as
GitHub already feeling threatened by public-inbox.  I certainly
wouldn't expect it at this stage, but I certainly hope it will
be the case one day :)


Disclaimer: I've always been willing to risk a lifetime of
unemployment for ideology.
