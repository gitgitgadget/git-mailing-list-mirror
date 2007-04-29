From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 29 Apr 2007 11:33:07 -0700
Message-ID: <7v4pmzdo9o.fsf@assigned-by-dhcp.cox.net>
References: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net>
	<1177662893872-git-send-email-junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 29 20:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiECv-0002Vi-5s
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031040AbXD2SdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031029AbXD2SdJ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:33:09 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60434 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031001AbXD2SdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:33:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429183308.ENYY24310.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Apr 2007 14:33:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id t6Z71W00K1kojtg0000000; Sun, 29 Apr 2007 14:33:07 -0400
X-maint-at: e9d54bd18bcf5dc9eb68eb1cba9a6a7ba3f71fd6
X-master-at: a07157ac624b2524a059a3414e99f6f44bebc1e7
In-Reply-To: <1177662893872-git-send-email-junkio@cox.net> (Junio C. Hamano's
	message of "Fri, 27 Apr 2007 01:34:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45829>

We would need PerlIO fix for git-svn to handle symlinks on MacOS
properly on 'maint', which is still a known issue.  With that
I'll do a v1.5.1.3.

In addition to a few more new features recently discussed, and
of course a lot of fixes that came in the last couple of days,
I've merged the "give them rope" conversion series to 'master'.
Hopefully we will have a handful user-manual updates from JBF
and git-gui 0.6.6 from Shawn and have v1.5.2-rc1 soon.

* The 'maint' branch has these fixes since the last announcement.

 Adam Roben (1):
  git-svn: Added 'find-rev' command

 Johannes Schindelin (1):
  import-tars: be nice to wrong directory modes

 Josh Triplett (1):
  Add missing reference to GIT_COMMITTER_DATE in git-commit-tree documentation

 Julian Phillips (1):
  http.c: Fix problem with repeated calls of http_init

 Junio C Hamano (3):
  Do not barf on too long action description
  Update .mailmap with "Michael"
  Fix import-tars fix.

 Michele Ballabio (1):
  git shortlog documentation: add long options and fix a typo

 Shawn O. Pearce (2):
  Don't allow empty pathnames in fast-import
  Catch empty pathnames in trees during fsck


* The 'master' branch has these since the last announcement
  in addition to the above.

 Josh Triplett (1):
  Fall back to $EMAIL for missing GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL

 Junio C Hamano (7):
  Add 'ident' conversion.
  Add 'filter' attribute and external filter driver definition.
  blame -s: suppress author name and time.
  Split out mailmap handling out of shortlog
  Apply mailmap in git-blame output.
  Make macros to prevent double-inclusion in headers consistent.
  Make sure test-genrandom and test-chmtime are builtas part of the main build.
