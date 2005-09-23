From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.15.1 (important bugfix)
Date: Fri, 23 Sep 2005 15:12:14 +0200
Message-ID: <20050923131213.GE10255@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 15:13:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EInLg-00021H-Sa
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 15:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVIWNMR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 09:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVIWNMR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 09:12:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42189 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750964AbVIWNMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 09:12:16 -0400
Received: (qmail 21253 invoked by uid 2001); 23 Sep 2005 15:12:14 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9189>

  Hello,

  I'm announcing the release of 0.15.1 of Cogito, the human-friendly UI
for Linus' GIT. You can find it at

	http://www.kernel.org/pub/software/scm/cogito/

when kernel.org mirroring will go through another short period of
actually working. ;-)

  I'm cc'ing the Linux Kernel mailing list since this release contains
a bugfix for an ugly potential data loss bug, which actually probably
covers nearly all Cogito users (it was introduced in cogito-0.11.2).
If you had some local uncommitted changes and merge new stuff (either
using cg-update or cg-merge), in some cases it would silently trash your
local changes. It was caused by a bogus git-checkout-cache invocation
pointed out by Linus.

  Other interesting stuff:

  * cg-clean -d would remove the arch/ and include/ subdirs in Linux
    kernel - just any directories containing only subdirectories
    (this isn't as horrible as it sounds since you didn't lose anything
    precious you didn't want to lose - you can recover by just doing
    cg-restore)
  * Support for fetching from URLs of the 'git' protocol scheme
  * cg-log -d filters based on date
  * cg-diff works on BSD now
  * Merge cg-(commit|parent|tree)-id to cg-object-id
  * Some significant documentation enhancements
  * Some new tests in the testsuite (for cg-merge ;-)
  * Usual squad of minor bugfixes

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
