From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Nov 2008, #03; Sat, 15)
Date: Sat, 15 Nov 2008 14:12:37 -0800
Message-ID: <7v7i7463l6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 15 23:14:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1TP7-0000BK-6J
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 23:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbYKOWMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2008 17:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752228AbYKOWMy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 17:12:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYKOWMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 17:12:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DE68916C60;
	Sat, 15 Nov 2008 17:12:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E75B216C59; Sat, 15 Nov 2008 17:12:40 -0500 (EST)
X-maint-at: 9e77353e0ea6e9e6d88ad1943570afb526d54a16
X-master-at: ea4f2bd39dcfabb23e86b2f79149c6c4038ff3cd
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B7709AE-B362-11DD-8D16-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101093>

Consider that the tip of 'master' is 1.6.1-rc0, although I haven't tagg=
ed
it as such.  There are a handful more topics cooking in 'next' and they
are worthy of being in 1.6.1 final.


* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (1):
  revision.c: use proper data type in call to sizeof() within xrealloc

Christian Couder (1):
  Documentation: fix links to "everyday.html"

Jan Kr=C3=BCger (1):
  Documentation: git-svn: fix example for centralized SVN clone

Linus Torvalds (1):
  date/time: do not get confused by fractional seconds


* The 'master' branch has these since the last announcement
  in addition to the above.

Alexander Gavrilov (14):
  gitk: Allow forcing branch creation if it already exists
  gitk: Fix file list context menu for merge commits
  gitk: Allow starting gui blame for a specific line
  gitk: Add Return and Escape bindings to dialogs
  gitk: Make gitk dialog windows transient
  gitk: Make cherry-pick call git-citool on conflicts
  gitk: Implement a user-friendly Edit View dialog
  git-gui: Fix focus transition in the blame viewer.
  git-gui: Add the Show SSH Key item to the clone dialog.
  git-gui: Request blame metadata in utf-8.
  gitk: Add accelerators to frequently used menu commands
  gitk: Fix transient windows on Win32 and MacOS
  gitk: Fix commit encoding support
  Documentation: New GUI configuration and command-line options.

Brandon Casey (10):
  t7700: demonstrate mishandling of objects in packs with a .keep file
  packed_git: convert pack_local flag into a bitfield and add pack_keep
  pack-objects: new option --honor-pack-keep
  repack: don't repack local objects in packs with .keep file
  repack: do not fall back to incremental repacking with [-a|-A]
  builtin-gc.c: use new pack_keep bitfield to detect .keep file existen=
ce
  t7700: demonstrate mishandling of loose objects in an alternate ODB
  sha1_file.c: split has_loose_object() into local and non-local
    counterparts
  pack-objects: extend --local to mean ignore non-local loose objects t=
oo
  t7700: test that 'repack -a' packs alternate packed objects

Brian Gernhardt (1):
  Avoid using non-portable `echo -n` in tests.

David M. Syzdek (4):
  Build: add NO_UINTMAX_T to support ancient systems
  Add Makefile check for FreeBSD 4.9-SECURITY
  Make Pthread link flags configurable
  Add autoconf tests for pthreads

Davide Libenzi (1):
  xdiff: give up scanning similar lines early

Deskin Miller (2):
  git-svn: proper detection of bare repositories
  git-svn: proper detection of bare repositories

Eric Wong (4):
  git-svn: don't escape tilde ('~') for http(s) URLs
  git-svn: respect i18n.commitencoding config
  git-svn: don't escape tilde ('~') for http(s) URLs
  git-svn: respect i18n.commitencoding config

Giuseppe Bilotta (3):
  gitweb: make the supported snapshot formats array global
  gitweb: retrieve snapshot format from PATH_INFO
  gitweb: embed snapshot format parameter in PATH_INFO

Jakub Narebski (1):
  gitweb: Better processing format string in custom links in navbar

Jeff King (11):
  diff: add missing static declaration
  document the diff driver textconv feature
  refactor userdiff textconv code
  userdiff: require explicitly allowing textconv
  only textconv regular files
  wt-status: load diff ui config
  add userdiff textconv tests
  enable textconv for diff in verbose status/commit
  t5516: refactor oddball tests
  receive-pack: detect push to current branch of non-bare repo
  commit: Fix stripping of patch in verbose mode.

Junio C Hamano (3):
  t5303: work around printf breakage in dash
  t5303: fix printf format string for portability
  Update draft release notes to 1.6.1

Linus Torvalds (4):
  Add a 'source' decorator for commits
  revision: make tree comparison functions take commits rather than tre=
es
  Make '--decorate' set an explicit 'show_decorations' flag
  revision traversal: '--simplify-by-decoration'

Marten Svanfeldt (dev) (2):
  Git.pm: Make _temp_cache use the repository directory
  git-svn: Update git-svn to use the ability to place temporary files
    within repository directory

Martin Koegler (1):
  git push: Interpret $GIT_DIR/branches in a Cogito compatible way

Miklos Vajna (4):
  Implement git remote rename
  remote: add a new 'origin' variable to the struct
  git-remote rename: migrate from remotes/ and branches/
  git-remote: document the migration feature of the rename subcommand

Nanako Shiraishi (2):
  Document "git log --source"
  Document "git log --simplify-by-decoration"

Nicolas Pitre (9):
  close another possibility for propagating pack corruption
  better validation on delta base object offsets
  make unpack_object_header() non fatal
  make packed_object_info() resilient to pack corruptions
  make check_object() resilient to pack corruptions
  make find_pack_revindex() aware of the nasty world
  pack-objects: allow "fixing" a corrupted pack without a full repack
  extend test coverage for latest pack corruption resilience improvemen=
ts
  pack-objects: don't leak pack window reference when splitting packs

Paul Mackerras (8):
  gitk: Fix some off-by-one errors in computing which line to blame
  gitk: Add a menu item to show where a given line comes from
  gitk: Make the background color of marked lines configurable
  gitk: Unify handling of merge diffs with normal 2-way diffs
  gitk: Make "show origin of this line" work on fake commits
  gitk: Cope with unmerged files in local changes
  gitk: Improve cherry-pick error handling
  gitk: Fix linehtag undefined error with file highlighting

Samuel Tardieu (2):
  tag: Check that options are only allowed in the appropriate mode
  tag: Add more tests about mixing incompatible modes and options

Santi B=C3=A9jar (1):
  rev-list documentation: clarify the two parts of history simplificati=
on
