From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [COGITO PATCH] mirroring repositories
Date: Thu, 2 Jun 2005 23:24:36 +0200
Message-ID: <20050602212436.GI32189@pasky.ji.cz>
References: <1117402883.8536.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 23:31:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdxF2-0003f0-ME
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 23:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFBV3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFBV0c
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:26:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:26583 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261231AbVFBVYl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 17:24:41 -0400
Received: (qmail 15663 invoked by uid 2001); 2 Jun 2005 21:24:36 -0000
To: Michael Frank <msfrank@syntaxjockey.com>
Content-Disposition: inline
In-Reply-To: <1117402883.8536.5.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 29, 2005 at 11:41:23PM CEST, I got a letter
where Michael Frank <msfrank@syntaxjockey.com> told me that...
> The attached patch adds the two programs cg-mirror-add and
> cg-mirror-sync.  Say you do all of your work on your laptop and you want
> to make a mirror of your repository available to the public.  You
> specify the location of the mirror with cg-mirror-add:
> 
> $ cg-mirror-add scp://my.server:/var/www/repos/project.git
> 
> which locally creates the file .git/mirrors.  Whenever you want to
> upload your changes, you run cg-mirror-sync.

FWIW, I think this is the wrong approach - full-blown pushing makes much
more sense since it's a full superset of mirroring and it's more
universal, and not *that* more complicated to do (basically just the
HEAD stuff - and I think the race conditions around that don't matter
that much in the real life if you take some basic crude protections).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
