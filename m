From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: The git-gui Times - Volume Zero Edition Eight Dot Three
Date: Mon, 17 Sep 2007 23:21:53 -0400
Message-ID: <20070918032153.GK3099@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 05:22:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXTf1-00085O-G5
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 05:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752523AbXIRDV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 23:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbXIRDV6
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 23:21:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43212 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbXIRDV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 23:21:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IXTeh-0007no-HY; Mon, 17 Sep 2007 23:21:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9135B20FBAE; Mon, 17 Sep 2007 23:21:54 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58525>

Recent Shortages at git-gui Times
---------------------------------
Unlike our sister publication ``The msysGit Herald'' the git-gui
Times is published on an apple stem.  To conserve bits and bites
our editors try to use only short logs, as long logs are simply
too expensive with today's rising paper costs.


maint
-----
gitgui-0.8.3 has been tagged from the maint branch and published
on repo.or.cz

    git://repo.or.cz/git-gui.git     maint
	http://repo.or.cz/r/git-gui.git  maint

and we continue to thank Pasky for his publishing services.  The
full list of changes since gitgui-0.8.2 (which shipped with git
1.5.3/1.5.3.1) is reprinted below:

  Gerrit Pape (1):
      git-gui: lib/index.tcl: handle files with % in the filename properly

  Michele Ballabio (2):
      git-gui: show unstaged symlinks in diff viewer
      git-gui: handle "deleted symlink" diff marker

  Shawn O. Pearce (13):
      git-gui: Correct starting of git-remote to handle -w option
      git-gui: Fix detaching current branch during checkout
      git-gui: Properly set the state of "Stage/Unstage Hunk" action
      git-gui: Disable Tk send in all git-gui sessions
      git-gui: Avoid use of libdir in Makefile
      git-gui: Assume untracked directories are Git submodules
      git-gui: Trim trailing slashes from untracked submodule names
      git-gui: Don't delete send on Windows as it doesn't exist
      git-gui: Make backporting changes from i18n version easier
      git-gui: Font chooser to handle a large number of font families
      git-gui: Provide 'uninstall' Makefile target to undo an installation
      git-gui: Paper bag fix "Commit->Revert" format arguments
      git-gui: Disable native platform text selection in "lists"

We hope these will appear on a mainstream git near you.


master
------
In addition to the above fixes the master branch has collected a few
items since the last edition of ``The git-gui Times''.  The editors
would not mind if this list was larger in the next edition, but can't
promise anything in advance of it being typeset for publication.
Letters to the editor in the form of patches are always welcome.

    git://repo.or.cz/git-gui.git     master
	http://repo.or.cz/r/git-gui.git  master

  Harri Ilari Tapio Liusvaara (1):
      git-gui: Disambiguate "commit"

  Michele Ballabio (1):
      git-gui: add some strings to translation

  Shawn O. Pearce (3):
      git-gui: Document the new i18n context support
      git-gui: Make the tree browser also use lightgray selection
      git-gui: Paper bag fix missing translated strings

-- 
Shawn.
