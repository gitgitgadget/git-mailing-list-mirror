From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sun, 19 Feb 2006 00:56:44 -0800
Message-ID: <7vy807k9pv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 19 09:57:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAkND-0007S7-QJ
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 09:56:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbWBSI4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 03:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWBSI4t
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 03:56:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61093 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932365AbWBSI4s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 03:56:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219085414.QGXS17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Feb 2006 03:54:14 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16426>

* The 'master' branch has these since the last announcement.

Alexandre Julliard:
      Add an Emacs interface in contrib.

Aneesh Kumar:
      Add contrib/gitview from Aneesh.

Aneesh Kumar K.V:
      Add a README for gitview
      gitview: typofix

Carl Worth:
      Trap exit to clean up created directory if clone fails.
      Abstract test_create_repo out for use in tests.
      Prevent git-upload-pack segfault if object cannot be found

Eric Wong:
      Introducing contrib/git-svn.
      git-svn: fix revision order when XML::Simple is not loaded
      git-svn: ensure fetch always works chronologically.
      git-svn: remove files from the index before adding/updating
      archimport: remove files from the index before adding/updating

Fernando J. Pereda:
      Allow building Git in systems without iconv

Jonas Fonseca:
      git-rev-parse: Fix --short= option parsing
      Document --short and --git-dir in git-rev-parse(1)

Junio C Hamano:
      rebase: allow rebasing onto different base.
      Detect misspelled pathspec to git-add
      topo-order: make --date-order optional.
      git-tag: -l to list tags (usability).
      Add contrib/README.
      SubmittingPatches: note on whitespaces

Martin Mares:
      Fix retries in git-cvsimport

Shawn Pearce:
      Make git-reset delete empty directories


* The 'next' branch, in addition, has these.

Johannes Schindelin:
      Fix cpio call
      Optionally support old diffs
      Support Irix
      Optionally work without python

Junio C Hamano:
      pack-objects: reuse data from existing packs.
      pack-objects: finishing touches.
      git-repack: allow passing a couple of flags to pack-objects.
      pack-objects: avoid delta chains that are too long.
      Make "empty ident" error message a bit more helpful.
      Delay "empty ident" errors until they really matter.
      Keep Porcelainish from failing by broken ident after making changes.
      fmt-merge-msg: say which branch things were merged into unless 'master'
      Allow git-mv to accept ./ in paths.

Linus Torvalds:
      Handling large files with GIT
      Handling large files with GIT
      git-merge-tree: generalize the "traverse <n> trees in sync" functionality


* The 'pu' branch, in addition, has these.

Johannes Schindelin:
      Fixes for ancient versions of GNU make

Junio C Hamano:
      read-tree: --prefix=<path>/ option.
      write-tree: --prefix=<path>/ and --exclude=<prefix>/.
      commit-tree: --bind <sha1> <path>/ option.
      rev-list: simplify --object list generation.
      rev-list: understand bound commits.
      fsck-objects, convert-objects: understand bound commits.
