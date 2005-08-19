From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Fri, 19 Aug 2005 07:58:36 -0700
Message-ID: <4091.1124463516@lotus.CS.Berkeley.EDU>
References: <7vk6ii1emh.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 17:00:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E68Kn-0002Q0-EF
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 16:59:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVHSO6l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 10:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVHSO6l
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 10:58:41 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:43967 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S964815AbVHSO6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 10:58:40 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id j7JEwe6d004093
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 07:58:40 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id j7JEwaTr004092
	for <git@vger.kernel.org>; Fri, 19 Aug 2005 07:58:40 -0700 (PDT)
To: git@vger.kernel.org
In-reply-to: <7vk6ii1emh.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

And Junio C Hamano writes:
 - It turns out that your patch breaks GCC build 

Whoops, sorry.  Your fix works with Sun's cc.  

BTW, how would people feel about replacing the 
setenv() and unsetenv() calls with the older putenv()?
The Solaris version I have to work on doesn't have 
the nicer functions (and I'm not an admin).  I have 
to check that the unsetenv() in git-fsck-cache.c works 
correctly as a putenv before I send along a patch.  
There's also the issue that /bin/sh isn't bash, but an 
installation-time helper script can fix that.

Jason
