From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui i18n / 0.9.x plans
Date: Mon, 30 Jul 2007 21:28:04 -0400
Message-ID: <20070731012804.GZ20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:28:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFgX7-0005Ge-Jr
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 03:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756611AbXGaB2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 21:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756166AbXGaB2S
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 21:28:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38791 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbXGaB2R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 21:28:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFgWn-0000bv-TL; Mon, 30 Jul 2007 21:28:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B9FDA20FBAE; Mon, 30 Jul 2007 21:28:04 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54303>

Now that git-gui 0.8.0 has been released I have updated both the
maint and master branches to 0.8.0.  maint will carry the 0.8.0
development forward, and is strictly for bug fixes to the current
non-i18n codebase.  I'm unlikely to make changes here except to
address current critical issues.

Regarding future development for the off-in-the-future 0.9.0 release
I'd like to see the i18n work merge in before we do anything else
major to git-gui.  I'm likely to shift my focus to fast-import this
week, which means git-gui will probably see no major activity from
me for about the next two weeks.  As soon as the i18n team has
something rebased onto current master that is ready for merging,
I'll bring it over.  Yes, that's a promise on my part to try and
keep my tree frozen for a little while.  :)

Other things I'd like to do in 0.9.0, but may or may not actually
do myself:

 - Automatically refetch tracking branches in merge
 - Text mode log viewer:
   `git-log`, `git-log -g`
 - File monitor on WinNT (to avoid costly Rescan on large projects)
 - Remove more porcelain shell dependencies:
   `git-merge`, `git-repack`, `git-remote prune`
 - UI for cherry-pick/revert
 - Generational GC for 'Compress Database'
 - Integration with git-stash
 - Hunk splitting/selection
 - UI for git-tag
 - Push specific tags by name (rather than by --tags)
 - Pull from arbitrary URL/branch pair

Those are roughly ordered by how much I think myself and my fellow
day-job coworkers want these features, so that's probably roughly
the order I'll try to work through them after the i18n current
changes are merged in.  Of course patches are also welcome.  :)

I haven't yet settled on whether the first i18n enabled version would
be 0.9.0 or a 0.8.1/2.  That's one reason why I want to get the i18n
changes merged early.  If we have a few high quality translations
ready to go I'd rather ship them in a 0.8.x maint release than hang
onto them for another 1-2 months while the major features of the
0.9.0 release get worked on and stablized.

-- 
Shawn.
