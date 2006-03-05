From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in git.git
Date: Sun, 5 Mar 2006 10:29:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603051027400.13139@g5.osdl.org>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603042058250.13139@g5.osdl.org> <7vfylxigxc.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0603050946280.13139@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 05 19:29:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFxzB-0004dj-1c
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 19:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWCES3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 13:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWCES3h
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 13:29:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750721AbWCES3h (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 13:29:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k25ITXDZ027853
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Mar 2006 10:29:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k25ITWSM000336;
	Sun, 5 Mar 2006 10:29:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0603050946280.13139@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17235>



On Sun, 5 Mar 2006, Linus Torvalds wrote:
> 
> Good point. Yes, it needs to check that it's not SHOWN. Might as well 
> check against interesting too. Maybe something like this instead?

Actually, thinking more about it, I think we could get rid of SHOWN.

We only ever insert a commit _once_ onto the list, using the SEEN logic, 
so we can never pull the same commit off the list more than once. I think 
SHOWN was for merge-order.

But I might be wrong. I was thinking about SHOWN a bit when I did the 
re-organization, but didn't dare to actually touch it, so I left it alone.

		Linus
