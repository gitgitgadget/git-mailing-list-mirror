X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff: don't add trailing blanks (i.e., do what GNU diff -u now does)
Date: Sun, 17 Dec 2006 12:09:14 -0800
Message-ID: <7vtzzu5lp1.fsf@assigned-by-dhcp.cox.net>
References: <87y7p6nwsh.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0612171200290.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 20:09:26 +0000 (UTC)
Cc: git@vger.kernel.org, Jim Meyering <jim@meyering.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612171200290.3479@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 17 Dec 2006 12:00:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34706>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw2Jz-0004s1-AT for gcvg-git@gmane.org; Sun, 17 Dec
 2006 21:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751225AbWLQUJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 15:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWLQUJQ
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 15:09:16 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35325 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751225AbWLQUJP (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 15:09:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217200915.BJO20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sun, 17
 Dec 2006 15:09:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zw9S1V00y1kojtg0000000; Sun, 17 Dec 2006
 15:09:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 17 Dec 2006, Jim Meyering wrote:
>>
>> You may recall that GNU diff -u changed recently so that it no
>> longer outputs any trailing space unless the input data has it.
>
> I still consider that to be a bug in GNU "diff -u".
>
> We work around that bug when applying patches, but I don't think we should 
> replicate it.

Me neither.
