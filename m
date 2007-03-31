From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sat, 31 Mar 2007 02:34:14 -0700
Message-ID: <7v1wj5ycx5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 11:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXZyV-0001js-He
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 11:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbXCaJeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 05:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbXCaJeQ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 05:34:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:42768 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbXCaJeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 05:34:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331093414.FCUO373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 05:34:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hMaF1W0041kojtg0000000; Sat, 31 Mar 2007 05:34:15 -0400
X-maint-at: 3ac53e0d13fa7483cce90eb6a1cfcdcbda5b8e35
X-master-at: 4f01748d51b530c297eeb5a0ece9af923d5db937
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43541>

As you can see, there are a few more fixes on the 'maint' branch
since 1.5.0.6; I might do 1.5.0.7 just for the sake of it, but I
am fairly determined to tag 1.5.1 on Apr 4th in a shape that is
"no worse" than 1.5.0, so it might not be strictly necessary.

If you can remind me of patches that are "must have"s for 1.5.1
that I've missed, that would be very nice.  We've broken "git
am" and "git rebase" (without --merge) on 'master' branch for
people who has i18n contents after 1.5.0 but they should be
fixed now.

Please, remember that the key word for this weekend is "make
1.5.1 NO WORSE than 1.5.0".  IOW, the focus is on obvious
regression fixes.

----------------------------------------------------------------
* The 'maint' branch has these fixes since the last announcement.

 Gerrit Pape (2):
  Documentation/git-svnimport.txt: fix typo.
  Documentation/git-rev-parse.txt: fix example in SPECIFYING RANGES.

 H. Peter Anvin (1):
  git-upload-pack: make sure we close unused pipe ends


* The 'master' branch has these since the last announcement
  in addition to the above.

 Andy Parkins (1):
  Reimplement emailing part of hooks--update in contrib/hooks/post-receive-email

 Christian Couder (1):
  Bisect: Improve error message in "bisect_next_check".

 Don Zickus (1):
  git-mailinfo fixes for patch munging

 Eric Wong (1):
  git-svn: avoid respewing similar error messages for missing paths

 Francis Daly (1):
  git-quiltimport /bin/sh-ism fix

 Jakub Narebski (1):
  gitweb: Support comparing blobs (files) with different names

 Julian Phillips (1):
  contrib/workdir: add a simple script to create a working directory

 Junio C Hamano (2):
  Update draft release notes for 1.5.1
  Do not bother documenting fetch--tool

 Theodore Ts'o (12):
  Fix minor formatting issue in man page for git-mergetool
  mergetool: Replace use of "echo -n" with printf(1) to be more portable
  mergetool: Don't error out in the merge case where the local file is deleted
  mergetool: portability fix: don't assume true is in /bin
  mergetool: portability fix: don't use reserved word function
  mergetool: factor out common code
  mergetool: Remove spurious error message if merge.tool config option not set
  mergetool: Fix abort command when resolving symlinks and deleted files
  mergetool: Add support for Apple Mac OS X's opendiff command
  mergetool: Make git-rm quiet when resolving a deleted file conflict
  mergetool: Clean up description of files and prompts for merge resolutions
  Rename warn() to warning() to fix symbol conflicts on BSD and Mac OS
