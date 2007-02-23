From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Fri, 23 Feb 2007 00:33:54 -0800
Message-ID: <7v3b4x9sst.fsf@assigned-by-dhcp.cox.net>
References: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 23 09:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKVsP-0005pQ-Uf
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbXBWId7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbXBWId7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:33:59 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64011 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099AbXBWId6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:33:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223083358.WFFR6078.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Feb 2007 03:33:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SwZx1W0011kojtg0000000; Fri, 23 Feb 2007 03:33:57 -0500
X-maint-at: 75b62b489af7b62a5518c3f199d2a2776205e088
X-master-at: ef1a5c2fa8bc67abea6cbacf975ea3260cd40fa3
In-Reply-To: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Feb 2007 23:32:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40427>

On the 'maint' front, there aren't that many 'grave fixes'
anymore, which is somewhat (happily) surprising after a big
release like 1.5.0.  Shawn has updated git-gui to 0.6.1.
I'll perhaps do 1.5.0.2 next week.

In 'master', I pushed out autoCRLF and git-apply fixes.  These
are changes people can easily notice breakage and would benefit
from wider exposure.  Hopefully we can have simple path based
text/binary attribute on top of them -- I am hoping it to come
from people who actually benefit from autoCRLF ;-).

* The 'maint' branch has these fixes since the last announcement.

 Fredrik Kuivinen (1):
  Fix 'git commit -a' in a newly initialized repository

 Jason Riedy (1):
  Check for PRIuMAX rather than NO_C99_FORMAT in fast-import.c.

 Johannes Schindelin (1):
  git-diff: fix combined diff

 Martin Koegler (1):
  git-gui: Create new branches from a tag.

 Michael Loeffler (1):
  Use gunzip -c over gzcat in import-tars example.

 Shawn O. Pearce (16):
  git-gui: Refactor 'exec git subcmd' idiom.
  git-gui: Basic version check to ensure git 1.5.0 or later is used.
  git-gui: Permit merging tags into the current branch.
  git-gui: More consistently display the application name.
  git-gui: Print version on the console.
  git-gui: Prefer version file over git-describe.
  git-gui: Expose the browser as a subcommand.
  git-gui: Correct crash when saving options in blame mode.
  git-gui: Use mixed path for docs on Cygwin.
  git-gui: Display all authors of git-gui.
  git-gui: Change summary of git-gui.
  git-gui: Include browser in our usage message.
  git-gui: Remove TODO list.
  git-gui: Don't crash in citool mode on initial commit.
  Document the new core.bare configuration option.
  Include git-gui credits file in dist.


* The 'master' branch has these since the last announcement.

 Alex Riesen (1):
  disable t4016-diff-quote.sh on some filesystems

 Fredrik Kuivinen (2):
  New autoconf test for iconv
  Fix 'git commit -a' in a newly initialized repository

 Jason Riedy (1):
  Check for PRIuMAX rather than NO_C99_FORMAT in fast-import.c.

 Johannes Schindelin (5):
  apply: fix memory leak in prefix_one()
  name-rev: avoid "^0" when unneeded
  git grep: use pager
  Teach diff -B about colours
  git-diff: fix combined diff

 Junio C Hamano (16):
  t0020: add test for auto-crlf
  Teach 'git apply' to look at $GIT_DIR/config
  Teach core.autocrlf to 'git apply'
  Teach 'git apply' to look at $HOME/.gitconfig even outside of a repository
  git-apply: do not lose cwd when run from a subdirectory.
  git-apply: require -p<n> when working in a subdirectory.
  Link 1.5.0.1 documentation from the main page.
  Add prefixcmp()
  Mechanical conversion to use prefixcmp()
  prefixcmp(): fix-up mechanical conversion.
  prefixcmp(): fix-up leftover strncmp().
  t4119: add test for traditional patch and different p_value
  Fix botched "leak fix"
  git-apply: notice "diff --git" patch again
  git-apply: guess correct -p<n> value for non-git patches.
  t4119: test autocomputing -p<n> for traditional diff input.

 Linus Torvalds (2):
  Lazy man's auto-CRLF
  Make AutoCRLF ternary variable.

 Martin Koegler (1):
  git-gui: Create new branches from a tag.

 Martin Waitz (1):
  Support for large files on 32bit systems.

 Michael Loeffler (1):
  Use gunzip -c over gzcat in import-tars example.

 Pavel Roskin (1):
  git-remote: support remotes with a dot in the name

 Shawn O. Pearce (16):
  git-gui: Refactor 'exec git subcmd' idiom.
  git-gui: Basic version check to ensure git 1.5.0 or later is used.
  git-gui: Permit merging tags into the current branch.
  git-gui: More consistently display the application name.
  git-gui: Print version on the console.
  git-gui: Prefer version file over git-describe.
  git-gui: Expose the browser as a subcommand.
  git-gui: Correct crash when saving options in blame mode.
  git-gui: Use mixed path for docs on Cygwin.
  git-gui: Display all authors of git-gui.
  git-gui: Change summary of git-gui.
  git-gui: Include browser in our usage message.
  git-gui: Remove TODO list.
  git-gui: Don't crash in citool mode on initial commit.
  Document the new core.bare configuration option.
  Include git-gui credits file in dist.

 Simon 'corecode' Schubert (1):
  Allow passing of an alternative CVSROOT via -d.

 Theodore Ts'o (2):
  Add config_boolean() method to the Git perl module
  Allow git-remote to update named groups of remotes
