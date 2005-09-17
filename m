From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.14.2
Date: Sun, 18 Sep 2005 00:03:09 +0200
Message-ID: <20050917220309.GB3590@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Sep 18 00:04:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGkmR-0004J5-Kz
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 00:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVIQWDM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 18:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbVIQWDM
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 18:03:12 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59020 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751208AbVIQWDL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Sep 2005 18:03:11 -0400
Received: (qmail 9128 invoked by uid 2001); 18 Sep 2005 00:03:09 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8771>

  Hi,

  this is a mostly bugfix release of Cogito-0.14.2. It fixes several
minor bugs, one major bug (cg-rm not working in the directory), and adds
one new fix-feature - cg-push now works for any combination of
local/remote head names, not just for both being 'master'. Also,
cg-pushing from symlinked directory will trigger the remote update hook
properly.

  Note that this release deprecates .git/exclude. Please consider making
your list of exclude files revision controlled and global to the whole
project, not just your repository. If you are positive that you do not
want that, please move it to .git/info/exclude.

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
