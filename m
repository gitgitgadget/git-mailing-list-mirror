From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.1-rc2
Date: Mon, 26 Mar 2007 23:23:01 -0700
Message-ID: <7vzm5zqk6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 08:23:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW55J-000230-BJ
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 08:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbXC0GXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 27 Mar 2007 02:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXC0GXF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 02:23:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55660 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964896AbXC0GXD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 02:23:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327062302.EGDR22511.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 02:23:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fiP11W00U1kojtg0000000; Tue, 27 Mar 2007 02:23:01 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43231>

It's been a week since -rc1 so here is the -rc2.  I think we do
not have any issues scheduled for v1.5.1 but not finished, so I
am hoping that we could do the final, with possibly only small
obvious fixes by the end of the month.

----------------------------------------------------------------

Changes since v1.5.1-rc1 are as follows:

Alex Riesen (2):
      Document --quiet option to git-diff
      Use diff* with --exit-code in git-am, git-rebase and git-merge-ou=
rs

Andy Parkins (2):
      update-hook: abort early if the project description is unset
      update-hook: remove e-mail sending hook.

Brandon Casey (1):
      prefer "git COMMAND" over "git-COMMAND" in gitk

Chris Wright (1):
      make git clone -q suppress the noise with http fetch

Christian Couder (7):
      Bisect: implement "git bisect run <cmd>..." to automatically bise=
ct.
      Documentation: bisect: reformat some paragraphs.
      Documentation: bisect: reword one paragraph.
      Documentation: bisect: reformat more paragraphs.
      Documentation: bisect: add some titles to some paragraphs.
      Documentation: bisect: make a comment fit better in the man page.
      Bisect: Use "git-show-ref --verify" when reseting.

Eric Wong (2):
      gitk: bind <F5> key to Update (reread commits)
      git-svn: fix rel_path() when not connected to the repository root

J. Bruce Fields (5):
      user-manual: run xsltproc without --nonet option
      user-manual: Use def_ instead of ref_ for glossary references.
      glossary: stop generating automatically
      glossary: clean up cross-references
      user-manual: introduce "branch" and "branch head" differently

Jakub Narebski (5):
      gitweb: Fix "next" link in commit view
      gitweb: Don't escape attributes in CGI.pm HTML methods
      gitweb: Fix not marking signoff lines in "log" view
      gitweb: Add some installation notes in gitweb/INSTALL
      gitweb: Add example of config file and how to generate projects l=
ist to gitweb/INSTALL

James Bowes (2):
      Replace remaining instances of strdup with xstrdup.
      use xmalloc in git.c and help.c

Jim Meyering (1):
      user-manual.txt: fix a tiny typo.

Johannes Schindelin (5):
      xdiff/xutils.c(xdl_hash_record): factor out whitespace handling
      Add a HOWTO for setting up a standalone git daemon
      Provide some technical documentation for shallow clones
      t4118: be nice to non-GNU sed
      git-revert: Revert revert message to old behaviour

Johannes Sixt (1):
      Teach git-remote to list pushed branches.

Junio C Hamano (15):
      git-log --first-parent: show only the first parent log
      blame: micro-optimize cmp_suspect()
      blame: cmp_suspect is not "cmp" anymore.
      Teach tree_entry_interesting() that the tree entries are sorted.
      tree-diff: avoid strncmp()
      tree_entry_interesting(): allow it to say "everything is interest=
ing"
      git-rebase: make 'rebase HEAD branch' work as expected.
      git-apply: Do not free the wrong buffer when we convert the data =
for writeout
      checkout: report where the new HEAD is upon detaching HEAD
      git-bisect: typofix
      git-bisect.sh: properly dq $GIT_DIR
      Fix path-limited "rev-list --bisect" termination condition.
      git-am documentation: describe what is taken from where.
      Update README to point at a few key periodical messages to the li=
st
      GIT 1.5.1-rc2

Li Yang (1):
      gitweb: Change to use explicitly function call cgi->escapHTML()

Linus Torvalds (6):
      Fix loose object uncompression check.
      Don't ever return corrupt objects from "parse_object()"
      Be more careful about zlib return values
      Remove "pathlen" from "struct name_entry"
      Initialize tree descriptors with a helper function rather than by=
 hand.
      Switch over tree descriptors to contain a pre-parsed entry

Michael S. Tsirkin (2):
      fix typo in git-am manpage
      git-merge: Put FETCH_HEAD data in merge commit message

Nicolas Pitre (10):
      clean up the delta base cache size a bit
      use a LRU eviction policy for the delta base cache
      don't ever allow SHA1 collisions to exist by fetching a pack
      index-pack: use hash_sha1_file()
      index-pack: more validation checks and cleanups
      improve checkout message when asking for same branch
      minor git-prune optimization
      update HEAD reflog when branch pointed to by HEAD is directly mod=
ified
      make it more obvious that temporary files are temporary files
      write_sha1_from_fd() should make new objects read-only

Peter Eriksen (1):
      Documentation/pack-format.txt: Clear up description of types.

Santi B=C3=A9jar (1):
      git-fetch: Fix single_force in append_fetch_head

Shawn O. Pearce (1):
      contrib/continuous: a continuous integration build manager

Uwe Kleine-K=C3=B6nig (1):
      Bisect: convert revs given to good and bad to commits
