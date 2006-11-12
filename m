X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git
Date: Sat, 11 Nov 2006 22:07:02 -0800
Message-ID: <7vu015gpvd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 06:07:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-maint-at: e02cd6388f0193706279268a7d9fa57be4cbc997
X-master-at: a74e60a0f59899c612053b6fe0f0f62652118151
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31256>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gj8Uu-0007Tp-PX for gcvg-git@gmane.org; Sun, 12 Nov
 2006 07:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754037AbWKLGHF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 01:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbWKLGHE
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 01:07:04 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:56281 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1754037AbWKLGHD
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 01:07:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112060702.IWOX18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 01:07:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id li6d1V00D1kojtg0000000; Sun, 12 Nov 2006
 01:06:38 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Execuive summary.

I've tagged the tip of 'master' as v1.4.4-rc2 tonight.  In the
meantime, GIT 1.4.3.5 was cut from the 'maint' branch.

We hopefully can declare the real 1.4.4 soon enough, before the
turkey time.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

   Eric Wong (3):
      git-svn: avoid printing filenames of files we're not tracking
      git-svn: don't die on rebuild when --upgrade is specified
      git-svn: fix dcommit losing changes when out-of-date from svn

   Junio C Hamano (2):
      path-list: fix path-list-insert return value
      git-cvsserver: read from git with -z to get non-ASCII pathnames.

   Petr Baudis (1):
      Nicer error messages in case saving an object to db goes wrong

   Robert Shearman (1):
      git-rebase: Use --ignore-if-in-upstream option when executing git-format-patch.


* The 'master' branch has these since the last announcement.

   Eric Wong (3):
      git-svn: avoid printing filenames of files we're not tracking
      git-svn: don't die on rebuild when --upgrade is specified
      git-svn: fix dcommit losing changes when out-of-date from svn

   Jakub Narebski (3):
      gitweb: Better git-unquoting and gitweb-quoting of pathnames
      gitweb: Use character or octal escape codes (and add span.cntrl) in esc_path
      gitweb: New improved patchset view

   Junio C Hamano (14):
      gitweb: fix disabling of "forks"
      gitweb: minimally fix "fork" support.
      gitweb: do not give blame link unconditionally in diff-tree view
      git-status: quote LF in its output
      git-pickaxe: retire pickaxe
      gitweb: protect blob and diff output lines from controls.
      gitweb: protect commit messages from controls.
      gitweb: fix unmatched div in commitdiff
      Documentation: move blame examples
      git-annotate: no need to exec blame; it is built-in now.
      git-annotate: fix -S on graft file with comments.
      path-list: fix path-list-insert return value
      git-cvsserver: read from git with -z to get non-ASCII pathnames.
      GIT 1.4.4-rc2

   OGAWA Hirofumi (1):
      gitk: Fix nextfile() and add prevfile()

   Petr Baudis (1):
      Nicer error messages in case saving an object to db goes wrong

   Robert Shearman (1):
      git-rebase: Use --ignore-if-in-upstream option when executing git-format-patch.


* The 'next' branch, in addition, has these.

   Junio C Hamano (4):
      upload-pack: stop the other side when they have more roots than we do.
      pack-objects: use of version 3 delta is now optional.
      Revert "pack-objects: use of version 3 delta is now optional."
      adjust_shared_perm: chmod() only when needed.


* The 'pu' branch, in addition, has these.

   Alexandre Julliard (1):
      Shallow clone: do not ignore shallowness when following tags

   Jakub Narebski (1):
      gitweb: New improved formatting of chunk header in diff

   Johannes Schindelin (6):
      upload-pack: no longer call rev-list
      support fetching into a shallow repository
      allow cloning a repository "shallowly"
      Build in shortlog
      allow deepening of a shallow repository
      add tests for shallow stuff

   Junio C Hamano (6):
      git-branch -a: show both local and remote tracking branches.
      git-commit: show --summary after successful commit.
      git-diff/git-apply: make diff output a bit friendlier to GNU patch (part 2)
      rev-list --left-right
      blame: --show-stats for easier optimization work.
      gitweb: steal loadavg throttle from kernel.org

