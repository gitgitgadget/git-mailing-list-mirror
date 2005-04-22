From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [git-pasky] updating tree and source files
Date: Fri, 22 Apr 2005 19:16:49 +0200
Message-ID: <20050422171649.GD7173@pasky.ji.cz>
References: <200504221750.24188.rhys@rhyshardwick.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 19:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP1i9-0003Ai-WF
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 19:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVDVRRJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 13:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVDVRRJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 13:17:09 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43932 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262071AbVDVRQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 13:16:56 -0400
Received: (qmail 7581 invoked by uid 2001); 22 Apr 2005 17:16:49 -0000
To: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Content-Disposition: inline
In-Reply-To: <200504221750.24188.rhys@rhyshardwick.co.uk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 06:50:23PM CEST, I got a letter
where Rhys Hardwick <rhys@rhyshardwick.co.uk> told me that...
> Hi

Hello,

> I have been looking through the scripts, but cannot find out whether when 
> running: git pull, checkout-cache will be run if the tree is different.
> 
> My main question is, if there is a new version on the git server, and i do a 
> git pull, will this update the source files.  Do I have to carry out some 
> more commands in order for this to happen?
> 
> Sorry if this is a really newb question, but hopefully I should catch up soon!

git pull will update your working tree if your working tree branch is
tracking the pulled remote branch. If you do just 'git pull', this is
always the case.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
