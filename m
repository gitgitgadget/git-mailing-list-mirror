From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.16rc2
Date: Sun, 13 Nov 2005 02:02:30 +0100
Message-ID: <20051113010230.GL30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 13 02:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb6Gq-0005zG-AT
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 02:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVKMBCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 20:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKMBCc
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 20:02:32 -0500
Received: from w241.dkm.cz ([62.24.88.241]:35049 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750703AbVKMBCb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 20:02:31 -0500
Received: (qmail 7599 invoked by uid 2001); 13 Nov 2005 02:02:30 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11722>

  Hello,

  I'm announcing the release of Cogito version 0.16rc2, the human-friendly
version control UI for Linus' GIT tool. Share and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  Compared to rc1, this carries few bugfixes, a minor feature or two,
some small documentation updates, extended testsuites etc.

  The new stuff includes:

  * Curl is used instead of wget for HTTP heads fetching
  * Handle multiple merge bases (leaving the decision on the user)
  * cg-init -m'msg' support

  * Fix a long-standing bug with some stale files not being removed
    during large fast-forwards
  * Non-symlink HEADs are now fetched from properly
  * cg-commit -f now really works
  * Local fetching should work even without GNU cp now
  * Some fetch progressbar fixes

  * Few tiny improvements
  * Several new tests
  * Small documentation updates

  If I will get no more bugreports during the next few days, this will
become 0.16 final.

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
