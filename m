From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's new in git-gui
Date: Thu, 12 Jul 2007 03:10:51 -0400
Message-ID: <20070712071051.GU4436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 09:11:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8spI-0005LA-23
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 09:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbXGLHK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 03:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbXGLHK5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 03:10:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53307 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbXGLHK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 03:10:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I8spA-0002w1-96; Thu, 12 Jul 2007 03:10:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DBD9620FBAE; Thu, 12 Jul 2007 03:10:51 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52251>

I just released git-gui 0.7.5 to the usual location:

  gitweb:  http://repo.or.cz/w/git-gui.git/
  clone:   git://repo.or.cz/git-gui.git
           http://repo.or.cz/r/git-gui.git

Changes since git-gui 0.7.4 (currently in git.git maint):

Gerrit Pape (1):
      git-gui: properly popup error if gitk should be started but is not installed

Shawn O. Pearce (9):
      git-gui: Unlock the index when cancelling merge dialog
      git-gui: Don't bind F5/M1-R in all windows
      git-gui: Bind M1-P to push action
      git-gui: Include a Push action on the left toolbar
      git-gui: Ensure windows shortcuts always have .bat extension
      git-gui: Skip nicknames when selecting author initials
      git-gui: Correct ls-tree buffering problem in browser
      git-gui: Don't linewrap within console windows
      git-gui: Work around bad interaction between Tcl and cmd.exe on ^{tree}

-----------------

In addition to the above the git-gui 0.8.0 development line is
progressing along nicely.  Most of the changes have been focused
around new branch management features, including deleting remote
branches, switching to a detached HEAD, and creating branches from
a detached HEAD.

There is also some limited support for a "bound branch" concept.
Users can now create (or recreate) a local branch whose name
matches the name of a tracking branch.  During the creation (and
optional checkout) git-gui will fetch the tracking branch and then
fast-forward or reset the local branch to match it.


The master branch has the following changes since 0.7.5 and
gitgui-0.7.4-21-g03d2562 (currently in git.git master):

Junio C Hamano (1):
      git-gui: use "blame -w -C -C" for "where did it come from, originally?"

Shawn O. Pearce (41):
      Merge branch 'maint'
      Merge branch 'maint'
      git-gui: Start blame windows as tall as possible
      git-gui: Correct resizing of remote branch delete dialog
      Merge branch 'maint'
      git-gui: Honor rerere.enabled configuration option
      git-gui: New Git version check support routine
      Merge branch 'maint'
      git-gui: Teach class system to support [$this cmd] syntax
      git-gui: Abstract the revision picker into a mega widget
      git-gui: Refactor the delete branch dialog to use class system
      git-gui: Optimize for newstyle refs/remotes layout
      git-gui: Maintain remote and source ref for tracking branches
      git-gui: Allow users to match remote branch names locally
      git-gui: Fast-forward existing branch in branch create dialog
      git-gui: Enhance choose_rev to handle hundreds of branches
      git-gui: Sort tags descending by tagger date
      git-gui: Option to default new branches to match tracking branches
      git-gui: Automatically refresh tracking branches when needed
      git-gui: Better handling of detached HEAD
      git-gui: Refactor our ui_status_value update technique
      git-gui: Refactor branch switch to support detached head
      git-gui: Unabbreviate commit SHA-1s prior to display
      git-gui: Default selection to first matching ref
      git-gui: Allow double-click in checkout dialog to start checkout
      git-gui: Extract blame viewer status bar into mega-widget
      git-gui: Change the main window progress bar to use status_bar
      git-gui: Show a progress meter for checking out files
      git-gui: Always use absolute path to all git executables
      git-gui: Correct gitk installation location
      git-gui: Assume unfound commands are known by git wrapper
      git-gui: Treat `git version` as `git --version`
      git-gui: Perform our own magic shbang detection on Windows
      git-gui: Teach console widget to use git_read
      git-gui: Improve the Windows and Mac OS X shortcut creators
      Merge branch 'maint'
      git-gui: Paper bag fix for Cygwin shortcut creation
      git-gui: Use sh.exe in Cygwin shortcuts
      git-gui: Include a space in Cygwin shortcut command lines
      Merge branch 'maint'
      git-gui: Change prior tree SHA-1 verification to use git_read


-- 
Shawn.
