From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] Include Makefile.localdef in Makefile, if it exists.
Date: Fri, 02 Dec 2005 22:35:17 -0800
Message-ID: <3061.1133591717@lotus.CS.Berkeley.EDU>
References: <Pine.LNX.4.63.0512030322410.19086@wbgn013.biozentrum.uni-wuerzburg.de>
X-From: git-owner@vger.kernel.org Sat Dec 03 07:35:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiQzh-0006Fv-OY
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 07:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbVLCGfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 01:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbVLCGfT
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 01:35:19 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:15257 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751179AbVLCGfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 01:35:18 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id jB36ZH6d003064
	for <git@vger.kernel.org>; Fri, 2 Dec 2005 22:35:17 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id jB36ZHAo003063
	for <git@vger.kernel.org>; Fri, 2 Dec 2005 22:35:17 -0800 (PST)
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.63.0512030322410.19086@wbgn013.biozentrum.uni-wuerzburg.de> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13146>

And Johannes Schindelin writes:
 - I wonder why you do not just override them in config.mak, which was 
 - introduced just for that purpose...

'Cause I'm a git and didn't notice it, thanks.  The prefix stuff 
probably ought to be moved below the -include config.mak so 
someone need only change $(prefix) and not the rest.  I might
send along such a patch, along with a note about config.mak in
INSTALL...

Jason
