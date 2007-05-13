From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 13 May 2007 15:30:18 -0700
Message-ID: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 00:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnMa8-00032k-QG
	for gcvg-git@gmane.org; Mon, 14 May 2007 00:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415AbXEMWaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 18:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756436AbXEMWaV
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 18:30:21 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:44513 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbXEMWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 18:30:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070513223019.EOAG24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 18:30:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ymWK1W0021kojtg0000000; Sun, 13 May 2007 18:30:19 -0400
X-maint-at: 4a1bb4c3f87f355dd52fcd0babcbd005d59d7ed6
X-master-at: 43d151a1b087db22e2f9a754772b469de1194f67
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47187>

We accumulated quite a few fixes on 'maint' since v1.5.1.4, and
they apply to 'master' as well.

Things that are not in 'master' yet but are scheduled for v1.5.2
final are a performance bug fix for cvsexportcommit (in 'pu')
and user manual updates to add a bit of source code tour, which
hopefully would happen by the middle of the week, and then we
will have the final v1.5.2 next weekend.

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.1.4

 Alex Riesen (1):
  Allow fetching references from any namespace

 Eric Wong (4):
  git-svn: don't drop the username from URLs when dcommit is run
  git-svn: clean up caching of SVN::Ra functions
  git-svn: fix segfaults due to initial SVN pool being cleared
  git-svn: don't attempt to minimize URLs by default

 Jan Hudec (1):
  Updated documentation of hooks in git-receive-pack.

 Jari Aalto (1):
  SPECIFYING RANGES typo fix: it it => it is

 Junio C Hamano (4):
  git-clone: don't get fooled by $PWD
  .mailmap: add some aliases
  checkout: allow detaching to HEAD even when switching to the tip of a branch
  git-config: do not forget seeing "a.b.var" means we are out of "a.var" section.

 Marco Costalba (1):
  Fix an unmatched comment end in arm/sha1_arm.S

 Matthieu Castet (1):
  Remove stale non-static-inline prototype for tree_entry_extract()

 Quy Tonthat (1):
  RPM spec: include files in technical/ to package.

 Richard P. Curnow (2):
  Fix documentation of tag in git-fast-import.txt
  Fix documentation of tag in git-fast-import.txt

 Shawn O. Pearce (1):
  Properly handle '0' filenames in import-tars

 Steffen Prohaska (2):
  tiny fix in documentation of git-clone
  git-config: test for 'do not forget "a.b.var" ends "a.var" section'.


* The 'master' branch has these since v1.5.2-rc3, in addition to the above.

 Frank Lichtenheld (1):
  cvsserver: Limit config parser to needed options

 Jakub Narebski (2):
  gitweb: Test if $from_id and $to_id are defined before comparison
  gitweb: Check if requested object exists

 Jan Hudec (1):
  Minor fixup to documentation of hooks in git-receive-pack.

 Jeff King (1):
  git-add: allow path limiting with -u

 Junio C Hamano (5):
  Minor copyediting on Release Notes for 1.5.2
  Add has_symlink_leading_path() function.
  apply: do not get confused by symlinks in the middle
  read-tree -m -u: avoid getting confused by intermediate symlinks.
  Link to HTML version of external doc if available

 Junio Hamano (1):
  t9400: Use the repository config and nothing else.

 Lars Hjemli (1):
  git-archive: don't die when repository uses subprojects
