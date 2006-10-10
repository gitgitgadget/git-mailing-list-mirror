From: Junio C Hamano <junkio@cox.net>
Subject: GIT 1.4.3-rc2
Date: Tue, 10 Oct 2006 00:11:04 -0700
Message-ID: <7viris63xz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 10 09:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBm9-0003w6-Ud
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 09:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWJJHLH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 03:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbWJJHLG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 03:11:06 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6598 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965067AbWJJHLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 03:11:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061010071105.OBMV6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Tue, 10 Oct 2006 03:11:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YXB71V00S1kojtg0000000
	Tue, 10 Oct 2006 03:11:08 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28614>

I've tagged the tip of master as 1.4.3-rc2.  Modulo last minute
brown paper bag, I think we are pretty close to the real thing,
hopefully should happen this weekend.

Changes since 1.4.3-rc1 are as follows; they are mostly fixes as
expected (except one thing -- which shows in this list itself).

Alan Chandler (2):
      Update the gitweb/README file to include setting the GITWEB_CONFIG environment
      Fix usage string to match that given in the man page

Alexandre Julliard (2):
      git.el: Fixed inverted "renamed from/to" message.
      vc-git.el: Switch to using git-blame instead of git-annotate.

Dennis Stosberg (2):
      lock_ref_sha1_basic does not remove empty directories on BSD
      Add default values for --window and --depth to the docs

Franck Bui-Huu (1):
      Add git-upload-archive to the main git man page

Jakub Narebski (1):
      gitweb: Cleanup Git logo and Git logo target generation

Junio C Hamano (9):
      Makefile: install and clean merge-recur, still.
      git-mv: invalidate the removed path properly in cache-tree
      git-push: .git/remotes/ file does not require SP after colon
      escape tilde in Documentation/git-rev-parse.txt
      tar-tree deprecation: we eat our own dog food.
      gitweb: Make the Git logo link target to point to the homepage
      git-send-email: avoid uninitialized variable warning.
      cherry-pick: make -r the default
      Fix git-revert

Luben Tuikov (3):
      gitweb: Escape ESCAPE (\e) character
      gitweb: Do not print "log" and "shortlog" redundantly in commit view
      gitweb: blame: Minimize vertical table row padding

Martin Waitz (4):
      gitweb: document webserver configuration for common gitweb/repo URLs.
      git-commit: cleanup unused function.
      git-commit: fix coding style.
      test-lib: separate individual test better in verbose mode.

Nicolas Pitre (1):
      add commit count options to git-shortlog

Petr Baudis (4):
      Show snapshot link in shortlog only if have_snapsho
      gitweb: Separate (new) and (deleted) in commitdiff by a space
      gitweb: Handle commits with empty commit messages more reasonably
      gitweb: [commit view] Do not suppress commitdiff link in root commit

Rene Scharfe (1):
      git-tar-tree: don't RUN_SETUP

Robin Rosenberg (1):
      Error in test description of t1200-tutorial

Yasushi SHOJI (1):
      gitweb: refactor decode() for utf8 conversion
