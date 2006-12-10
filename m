X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation/git-commit: rewrite to make it more end-user friendly.
Date: Sun, 10 Dec 2006 15:05:11 -0800
Message-ID: <7vfybn2vyw.fsf@assigned-by-dhcp.cox.net>
References: <7vy7pik51b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612082141260.2630@xanadu.home>
	<7vd56tei20.fsf_-_@assigned-by-dhcp.cox.net>
	<200612100130.48812.Josef.Weidendorfer@gmx.de>
	<20061210210057.GB23387@fieldses.org>
	<Pine.LNX.4.64.0612101704390.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 23:05:37 +0000 (UTC)
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612101704390.2630@xanadu.home> (Nicolas Pitre's
	message of "Sun, 10 Dec 2006 17:07:40 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33954>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXjS-0005gy-Hu for gcvg-git@gmane.org; Mon, 11 Dec
 2006 00:05:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762456AbWLJXFO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 18:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762470AbWLJXFO
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 18:05:14 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50481 "EHLO
 fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1762456AbWLJXFM (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 18:05:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061210230511.HULI2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sun, 10
 Dec 2006 18:05:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id xB4a1V0011kojtg0000000; Sun, 10 Dec 2006
 18:04:34 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

>> Man pages are reference documentation, so I figure it's OK to sacrifice
>> a little newbie-friendliness for accuracy and concision.
>
> I disagree.  Clarity should be the first goal.  And the fact that even 
> modified files have to be specified is something worth enphasizing, 
> especially since this is not something other systems do.

Let's keep plumbing documentation technical reference material,
but allow more newbie friendliness in Porcelain-ish
documentation.
