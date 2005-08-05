From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.13
Date: Fri, 5 Aug 2005 04:03:09 +0200
Message-ID: <20050805020307.GP24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 05 04:04:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0rYP-0007Gt-9i
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 04:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVHECDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 22:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262807AbVHECDO
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 22:03:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:61199 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262806AbVHECDN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 22:03:13 -0400
Received: (qmail 28620 invoked by uid 2001); 5 Aug 2005 02:03:10 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,

  I'm happy to announce release 0.13 of the Cogito SCMish layer over the
GIT Tree History Storage tool. As usual, get it at:

	http://www.kernel.org/pub/software/scm/cogito

  Highlights:

	* Cogito is now alone!
		GIT is no longer part of Cogito distribution.
		That means you need to get and install it separately.
		It is recommended to use at least 0.99.3. The newer
		the better (hopefully).

	* Partial support for invoking commands from subdirectories
		This works only for very few commands yet
		(cg-diff, cg-status, cg-add, cg-rm), but I'm working
		on it.  Other commands will just refuse to run if you
		call them from a subdirectory.
	* .gitignore support in cg-status
	* cg-info is not anymore; its output is part of cg-status
	* cg-restore -f will overwrite even local modifications

	* Portability fixes
	* Plenty of other bugfixes

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
