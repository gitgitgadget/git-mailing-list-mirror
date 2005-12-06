From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Tue, 06 Dec 2005 11:59:23 -0800
Message-ID: <14331.1133899163@lotus.CS.Berkeley.EDU>
References: <7vslt67v9o.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 06 21:00:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjiyZ-0003OZ-4N
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 20:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbVLFT7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 14:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965008AbVLFT7o
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 14:59:44 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:42649 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S965007AbVLFT7n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 14:59:43 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB6JxN6d014333;
	Tue, 6 Dec 2005 11:59:23 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB6JxNZU014332;
	Tue, 6 Dec 2005 11:59:23 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vslt67v9o.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13287>

And Junio C Hamano writes:
 - I'd like to throw in another Makefile patch to catch both 5.8 and 
 - 5.9 for this, but would appreciate if people with various vintage 
 - of Solaris boxes can give some inputs before doing that.

Anyone else seeing the qsort in object.c trash memory?  The
input _looks_ correct.  I only see this on Solaris (8), but 
I've never had a problem with qsort there.  I think we have 
a Solaris 9 box around here somewhere, but probably only
partially 9.  The admins here are too busy fixing Windows to
maintain anything else properly.

 - This was done with somewhat stripped down configuration.

Once I replace the qsort (with an insertion sort), almost all 
the tests work with my odd-ball but full configuration.  I'm 
having some problems with cpio in the push tests, but it's 
just some path issue for my setup.  When I run the same 
commands by hand, they work.

I'll test this on AIX again soon.

Jason
