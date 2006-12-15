X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 10:21:07 -0800
Message-ID: <7vmz5pvx4c.fsf@assigned-by-dhcp.cox.net>
References: <200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612141343200.18171@xanadu.home>
	<Pine.LNX.4.64.0612142307160.18171@xanadu.home>
	<20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
	<20061215150909.GE17860@spearce.org> <4582C022.3030706@op5.se>
	<20061215154025.GF17860@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 18:21:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061215154025.GF17860@spearce.org> (Shawn Pearce's message of
	"Fri, 15 Dec 2006 10:40:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34538>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvHgI-0002Lr-AQ for gcvg-git@gmane.org; Fri, 15 Dec
 2006 19:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753128AbWLOSVK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 13:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbWLOSVK
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 13:21:10 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:57148 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753128AbWLOSVJ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 13:21:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215182108.GZTD4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 13:21:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z6ML1V00B1kojtg0000000; Fri, 15 Dec 2006
 13:21:20 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> I do the same (diff a lot before commit) and thus find commit
> outputting anything at all to be noisy and irritating.  Frankly
> the new
>
>   git-diff-tree --summary --root --no-commit-id HEAD
>
> that Junio put on the end is already irritating.
>
> But it was added to help users verify that commit did what they
> thought it would (see 61f5cb7f).

The credit should go Pasky's way.  Add/delete/mode are rarer
events and reminding them is sensible.

We do not show the 'summary' when we are concluding a merge that
conflicted.  Otherwise you will be seeing other people's huge
changes that was just brought in.
