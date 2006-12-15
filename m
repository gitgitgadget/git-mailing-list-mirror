X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 13:55:07 -0800
Message-ID: <7vslfgomdg.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<200612141136.59041.andyparkins@gmail.com>
	<20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org>
	<20061214120518.GL1747@spearce.org>
	<Pine.LNX.4.64.0612141251520.18171@xanadu.home>
	<7vy7pa45m8.fsf@assigned-by-dhcp.cox.net>
	<20061214200245.GP1747@spearce.org> <4581C83A.10907@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:55:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34559>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL1U-0006W9-1F for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965201AbWLOVzN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbWLOVzL
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:44891 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965191AbWLOVzI (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215508.KNPW29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vK1V00t1kojtg0000000; Fri, 15 Dec 2006
 16:55:20 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> Shawn Pearce wrote:
>>
>> About the only trouble that can cause is a failed push when
>> git-receive-pack needs to generate the reflog entry but cannot
>> get the user's committer data because their gecos information
>> doesn't exist.
>
> In that case, it would be best if it let the commit go through using
> only the username. Reflogs are fixable afterwards, so there's no real
> harm done.

This sounds sensible, regardless of the current discussion on
the default 'logallrefupdates' setting.

Volunteers?
