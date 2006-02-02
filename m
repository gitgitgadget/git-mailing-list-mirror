From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [RFC & PATCH] Solaris 8: ENOSYS when mkdir applied to automount.
Date: Wed, 01 Feb 2006 20:14:00 -0800
Message-ID: <25920.1138853640@lotus.CS.Berkeley.EDU>
References: <7vwtge37w5.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 05:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4VrN-0007C5-Ha
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 05:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422919AbWBBEOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 23:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423078AbWBBEOE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 23:14:04 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:36249 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1423076AbWBBEOE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 23:14:04 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k124E0xV025922;
	Wed, 1 Feb 2006 20:14:00 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k124E0k6025921;
	Wed, 1 Feb 2006 20:14:00 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vwtge37w5.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15480>

And Junio C Hamano writes:
 - There was a similar patch for working around Cygwin that threw
 - different errno in an earlier thread:

Thanks.  The thread mentioned in that one seems to have a few
"right" solutions.  A compat/gitmkdirat.c likely is the best,
modelled after the gnulib one.  I'll look at it when I can in 
the next week or so, so you can ignore my patch.

 - Somehow I started to trust your ability to code portably a lot
 - better than I trust myself, [...]

eep.  ;)  I only have access to three major variations at the
moment (Linux, semi-old Solaris, recent AIX), so I'm not an
authority...  Solaris 8 is from before the general Linux/glibc 
compatability movement, so it's pretty useful for testing.

Jason
