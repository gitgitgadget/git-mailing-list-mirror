X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 15:39:33 -0800
Message-ID: <7vejsmzqh6.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<200611012118.11558.andyparkins@gmail.com>
	<7vodrq251z.fsf@assigned-by-dhcp.cox.net>
	<200611012309.42675.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 23:39:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611012309.42675.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 1 Nov 2006 23:09:41 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30674>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfPgK-0007lx-65 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 00:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750840AbWKAXjf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 18:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752574AbWKAXjf
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 18:39:35 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:47828 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1750840AbWKAXjf
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 18:39:35 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101233934.FZPI22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 18:39:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hbfe1V00b1kojtg0000000 Wed, 01 Nov 2006
 18:39:39 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2006, November 01 22:08, Junio C Hamano wrote:
>
>> That's the "mechanical point of view only" description I was
>> afraid of having.  While I think I now see why they can be
>
> I must have a "mechanical point of view" brain.  I can't see
> any further than the gear wheels.

I care more about how something is useful than how faithfully
something is implemented to the specification, which in turn
means the specification needs to obviously indicate why it is
useful.

A gadget may pick up a nearby baseball bat and jump up and down
three times while holding it, but I do not want to have a
description about the gadget that just says it is designed to do
that.  I want the the description to be obvious that everybody
who reads it understands why that gadget is useful in what
situations.  That's why I feel the examples need to be extended.

But if I understand correctly, you are suggesting two different
modes of operation, namely, with path limiters HEAD is not
moved?

That is not something other git commands with pathspec does.
Path limiters tell command to "do your thing only for paths that
match these patterns, while you usually handle all paths; your
behaviour shall otherwise not be any different in other aspects
between the case you got no limiter and the case you got _all_
paths as limiters."  So I do not think making path-only mode and
pathless mode behave differently is a good idea from the UI
point of view.
