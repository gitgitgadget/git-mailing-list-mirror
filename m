From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: What's in git.git
Date: Wed, 25 Jan 2006 12:36:47 -0800
Message-ID: <10786.1138221407@lotus.CS.Berkeley.EDU>
References: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 25 21:37:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1rNs-00013i-1C
	for gcvg-git@gmane.org; Wed, 25 Jan 2006 21:36:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWAYUgt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jan 2006 15:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAYUgs
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jan 2006 15:36:48 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:64396 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750703AbWAYUgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2006 15:36:48 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k0PKalxV010794
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 12:36:47 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k0PKalja010793
	for <git@vger.kernel.org>; Wed, 25 Jan 2006 12:36:47 -0800 (PST)
To: git@vger.kernel.org
In-reply-to: <7vy814qx6o.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15135>

And Junio C Hamano writes:
 -      This uses unsetenv(), which is not strictly portable, but 
 - 	I was too lazy to fix it myself.

And you manage to catch me on the one day in the last month
I've played with git code...  Patch to add compat/unsetenv.c
coming shortly.  Passes unit tests and make test as well as 
before (I have some wierd, local-only cpio problems), but I 
haven't used this extensively.

People _with_ unsetenv can still add compat functions, you 
know.  ;)

Jason
