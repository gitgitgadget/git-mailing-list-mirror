From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.14
Date: Mon, 12 Sep 2005 03:25:19 +0200
Message-ID: <20050912012519.GK15630@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: vojtech@suse.cz
X-From: git-owner@vger.kernel.org Mon Sep 12 03:26:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEd4Y-0008EB-Rk
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 03:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVILBZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 21:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVILBZY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 21:25:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10708 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751118AbVILBZX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 21:25:23 -0400
Received: (qmail 3773 invoked by uid 2001); 12 Sep 2005 03:25:19 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8357>

  Hello,

  this is the release 0.14 of the Cogito SCMish layer over GIT. You know
where to get it and stuff. :-)

  I'm sorry for the long delay - I planned to take two weeks or so from
Cogito doing a monotone-git gateway, but I really didn't expect it to
take so long, plus there were other delays. This resulted in most of the
stuff sitting in the tree idly unreleased for a long time, which was
really a pity, especially for the subdirectories stuff and robust
cg-pull.

  As usual, this isn't as well-tested as I would wish it to be, but it
appears to work (which means the usual
horrible-bug-always-popping-up-just-after-the-release is still hiding) -
in case of problems, I'll release cogito-0.14.1 quickly, though. I'm
leaving for week's holiday today (you must think I'm a horrible (lazy)
person by now...  well ;-), but I'll be able to fix bugs (and apply
bugfixes) if you won't report too many of them.

  Note that if your patch didn't get applied, it likely means I missed
it - please remind me loudly. Thanks.

  The highlights:

  * Much more robust cg-pull
  * Relevant cg-* tools work in subdirectories
  * New scripts cg-admin-cat, cg-clean
  * cg-clone -l for symlinked (lightning fast, but read help) local cloning
  * Git-compatible cg-seek
  * cg-mkpatch able to split patch series to individual files
    (Vojtech: highlight :)
  * Better cg-export (USAGE CHANGE)
  * Speedups, even better portability
  * Plenty of bugfixes

  Have fun and happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
