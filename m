Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0852018E
	for <e@80x24.org>; Fri,  5 Aug 2016 19:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939402AbcHETVT (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 15:21:19 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55222 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948759AbcHETVR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 15:21:17 -0400
Received: from x (unknown [IPv6:2605:e000:d5ce:1e00:c5f5:b7bf:c731:5d3f])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id DAE6017209C;
	Fri,  5 Aug 2016 21:21:12 +0200 (CEST)
Date:	Fri, 5 Aug 2016 09:21:10 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160805192108.oe3yd5eyu4jopvwn@x>
References: <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Sep 17, 2001 at 10:00:00AM +0000, Stefan Beller wrote:
> But both send-email as well as mail-patch-series as well as git-series
> are all about the *sending* part. Not about the back and forth part, i.e.
> these don't deal with: "here is a fixup on top". And by that I mean
> receiving mails and applying them. git-am is there as a front-end
> once you obtained the mail, but from what I get, your original problem
> is to get up to date with the latest state, that is either in pu or a proposed
> fixup mail on top of your series?

git-series, at least, is intended to handle the back-and-forth: if you
actually publish the series and not just the final result, someone could
pull the series, make a (non-fast-forwarding) change to that, make a new
series commit, and publish their modified version of your series.  You
could then incorporate that change.  One of the use cases I developed it
for was collaborative development of a patch series.

(That workflow still needs a lot more tool assistance to become fully
usable, not least of which to assist with the process of merging changes
to the series.  Working on that.)
