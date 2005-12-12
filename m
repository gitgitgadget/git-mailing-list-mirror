From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.16.1
Date: Mon, 12 Dec 2005 02:12:10 +0100
Message-ID: <20051212011210.GC12373@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 02:13:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElcEs-0004y5-Dq
	for gcvg-git@gmane.org; Mon, 12 Dec 2005 02:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLLBMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 20:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVLLBMN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 20:12:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:5065 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750802AbVLLBMN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 20:12:13 -0500
Received: (qmail 4730 invoked by uid 2001); 12 Dec 2005 02:12:10 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13512>

  Hello,

  this is Cogito version 0.16.1, the next stable release of the
human-friendly version control UI for the Linus' GIT tool. Share
and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  This crispy new release gives you a few minor to medium bugfixes and
a significant cg-patch speedup. You can reach it as the "v0.16" branch
of the Cogito repository. Note that this is just the stable branch, more
interesting stuff is happenning (and especially going to happen) on the
master development branch; if everything goes well, I might release
cogito-0.17rc1 at the end of this week).

  So the new stuff since 0.16 is:

Jonas Fonseca:
      cg-merge: Improve the hook description
      cg-status: handle subdirs when listing heads

Petr Baudis:
      Fix cg-admin-setuprepo warning on missing post-update hook
      Initial cg-push to a remote branch wouldn't work properly
      Fix cg-object-id <singleletter>
      Fix unsafe sed usage in scripts
      cg-clean -n will just pretend to remove stuff
      Make cg-clean whitespace-safe
	If you use filenames with spaces _and_ cg-clean (or cg-clean
	at all, after all), you should certainly upgrade!
      bash-3.1-related fixes
      Fix broken cg-log FILE in subdirectory
      Drastically speed up cg-patch
      cogito-0.16.1

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
