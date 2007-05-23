From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 23 May 2007 14:46:52 -0700
Message-ID: <7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 23:46:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqyfa-0003xm-01
	for gcvg-git@gmane.org; Wed, 23 May 2007 23:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160AbXEWVqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756095AbXEWVqy
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 17:46:54 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:53196 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbXEWVqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 17:46:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523214654.OQDT13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 May 2007 17:46:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2lms1X0081kojtg0000000; Wed, 23 May 2007 17:46:52 -0400
X-maint-at: 7ca055f75ad7ffd2251d4b607fbb86d7bcfd77c7
X-master-at: ed82edc402c271a707da632083f1f4c19155d573
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48180>

Although there are a few post release fixups queued for v1.5.2.1
on 'maint' already, all things considered I must say v1.5.2 was
a quite good release.  There isn't a huge "oops, hand me a brown
paper bag please" fix yet.  Knock, knock...

On the 'master' front, as promised, the first batch that were on
hold since v1.5.2-rc1 is in.  Nothing earth-shattering, really.

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.2.

 Fernando J. Pereda (1):
  Use PATH_MAX instead of TEMPFILE_PATH_LEN

 Frank Lichtenheld (2):
  t1300: Add tests for git-config --bool --get
  git-config: Correct asciidoc documentation for --int/--bool

 Jim Meyering (1):
  git-daemon: don't ignore pid-file write failure

 Johannes Schindelin (2):
  SubmittingPatches: mention older C compiler compatibility
  git-status: respect core.excludesFile

 Jonas Fonseca (1):
  branch: fix segfault when resolving an invalid HEAD

 Junio C Hamano (2):
  annotate: make it work from subdirectories.
  git-cvsserver: fix disabling service via per-method config

 Paolo Bonzini (1):
  Document branch.autosetupmerge.

 Stephan Springl (1):
  Use git-for-each-ref to check whether the origin branch exists.

 Sven Verdoolaege (1):
  unpack-trees.c: verify_uptodate: remove dead code


* The 'master' branch has these since v1.5.2, in addition to the above.

 Alex Riesen (1):
  Fix the progress code to output LF only when it is really needed

 Dana How (1):
  Custom compression levels for objects and packs

 Jakub Narebski (2):
  gitweb: Add test t9500 for gitweb (as standalone script)
  Add an option to git-ls-tree to display also the size of blob

 James Bowes (1):
  Add colour support in rebase and merge tree diff stats output.

 Junio C Hamano (2):
  git-apply: Fix removal of new trailing blank lines.
  Fix command line parameter parser of revert/cherry-pick

 Marco Costalba (1):
  Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file

 Martin Waitz (1):
  rename dirlink to gitlink.

 Michael S. Tsirkin (1):
  connect: display connection progress

 Nicolas Pitre (3):
  allow for undeltified objects not to be reused
  make "repack -f" imply "pack-objects --no-reuse-object"
  deprecate the new loose object header format

 Petr Baudis (1):
  git-rev-list: Add regexp tuning options

 Shawn O. Pearce (1):
  Teach git-describe how to run name-rev

 Sven Verdoolaege (1):
  git-update-ref: add --no-deref option for overwriting/detaching ref

 Theodore Ts'o (1):
  Add --aggressive option to 'git gc'
