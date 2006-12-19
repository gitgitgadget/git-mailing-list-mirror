X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Possible optimization for gitweb
Date: Tue, 19 Dec 2006 14:10:32 -0800
Message-ID: <7v1wmvpmef.fsf@assigned-by-dhcp.cox.net>
References: <20061219205422.GA17864@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 22:10:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061219205422.GA17864@localhost> (Robert Fitzsimons's message
	of "Tue, 19 Dec 2006 20:54:22 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34858>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwnAT-0001I3-3c for gcvg-git@gmane.org; Tue, 19 Dec
 2006 23:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932998AbWLSWKe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 17:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbWLSWKe
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 17:10:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:55576 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932998AbWLSWKd (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 17:10:33 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219221033.IKPU22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 17:10:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0m9r1W00d1kojtg0000000; Tue, 19 Dec 2006
 17:09:52 -0500
To: Robert Fitzsimons <robfitz@273k.net>
Sender: git-owner@vger.kernel.org

Robert Fitzsimons <robfitz@273k.net> writes:

> The new workflows I'm proposing would be:
> 	get/parse ~100 commit's using rev-list
> 	foreach commit
> 		output commit

Absolutely.

And Ok on rev-list part, but perhaps --skip would be more
appropriate name.
