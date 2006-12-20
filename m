X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 16:34:36 -0800
Message-ID: <7vvek7o15v.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
	<20061218140813.GA32446@spearce.org>
	<7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
	<7v64c8thr4.fsf@assigned-by-dhcp.cox.net>
	<20061219090851.GH2511@spearce.org>
	<7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
	<20061219102741.GA21324@spearce.org>
	<Pine.LNX.4.64.0612191524180.6766@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 00:34:48 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612191524180.6766@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 19 Dec 2006 15:29:54 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34871>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpPs-0002sk-WF for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753484AbWLTAei (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbWLTAei
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:34:38 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:45805 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753484AbWLTAeh (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 19:34:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220003436.PIJG9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 19:34:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0oZv1W00J1kojtg0000000; Tue, 19 Dec 2006
 19:33:55 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> (Things that are really fast on Linux: VM manipulation, and filename path 
> lookup. Those are both ops that Linux _really_ shines on. It may not sound 
> like much, but when you do millions of them, it's the difference between 
> seconds and hours).
>
> 		Linus

... and both have been _heavily_ used in/assumed to be fast by
git implementation.

Linus, your userland programming skills are _spoiled_ by Linux
;-).
