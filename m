Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B511F855
	for <e@80x24.org>; Thu,  4 Aug 2016 23:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbcHDXjN (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 19:39:13 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59176 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758187AbcHDXjM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 19:39:12 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bVSEC-0001kW-E2; Fri, 05 Aug 2016 08:39:04 +0900
Date:	Fri, 5 Aug 2016 08:39:04 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Message-ID: <20160804233904.fnrgv37bj5ikpkn3@glandium.org>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
 <20160804225649.q77p4u6cbdo6q336@glandium.org>
 <xmqqfuqkyutp.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfuqkyutp.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.1-neo (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 04:32:02PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Thu, Aug 04, 2016 at 03:28:55PM -0700, Junio C Hamano wrote:
> >> * mh/connect (2016-06-06) 10 commits
> >>  - connect: [host:port] is legacy for ssh
> >>  ...
> >>  - connect: document why we sometimes call get_port after get_host_and_port
> >> 
> >>  Rewrite Git-URL parsing routine (hopefully) without changing any
> >>  behaviour.
> >> 
> >>  It has been two months without any support.  We may want to discard
> >>  this.
> >
> > What kind of support are you expecting?
> 
> The only rationale I recall you justifying this series was that this
> makes the resulting code easier to read, but I do not recall other
> people agreeing with you, and I do not particularly see the
> resulting code easier to follow.

FWIW, IIRC, Torsten agreed it did.

Mike
