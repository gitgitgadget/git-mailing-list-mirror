From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sat, 06 Sep 2008 23:11:15 -0700
Message-ID: <7vtzcso58c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 08:13:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcDWH-0004Dv-FF
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 08:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbYIGGLW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Sep 2008 02:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYIGGLW
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 02:11:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbYIGGLV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Sep 2008 02:11:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BD6A5F15C;
	Sun,  7 Sep 2008 02:11:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 310875F15B; Sun,  7 Sep 2008 02:11:18 -0400 (EDT)
X-maint-at: aaefbfa66c348a461b3081873ef42819c8b38dac
X-master-at: ec3a4ba519c0012d58584d23f407c302e7b80eb6
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CA16D37E-7CA3-11DD-804E-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95118>

Quite a many minor fixes appeared on 'maint'.  1.6.0.2 needs to happen
soon.  Any favorite fixes (not feature enhancements) not on the list he=
re?

On the 'master' front, gitk, git-gui and git-svn subsystems had moderat=
e
amount of updates.  Among other things:

 - From gitk you can ask git-gui to show blame, and from git-gui's blam=
e
   you can ask gitk to show the commit and history;

 - "log --simplify-merges";

 - "commit --author=3D$name" does not require "A U Thor <author@email.x=
z>"
   in full; abbreviated request will look for a matching one in the
   existing history;

 - "pack-objects" is safer against disc corruption;



* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (1):
  Fix use of hardlinks in "make install"

Alexander Gavrilov (1):
  git-gui: Fix string escaping in po2msg.sh

Alexandre Bourget (2):
  git-gui: Update french translation
  git-gui: update all remaining translations to French.

Andreas F=C3=A4rber (1):
  Makefile: always provide a fallback when hardlinks fail

Ask Bj=C3=B8rn Hansen (1):
  Document sendemail.envelopesender configuration

Bj=C3=B6rn Steinbrink (1):
  for-each-ref: Allow a trailing slash in the patterns

Clemens Buchacher (2):
  git gui: show diffs with a minimum of 1 context line
  clone: fix creation of explicitly named target directory

Gustaf Hendeby (1):
  Document clarification: gitmodules, gitattributes

Heikki Orsila (2):
  Start conforming code to "git subcmd" style
  Improve documentation for --dirstat diff option

Jeff King (2):
  pretty=3Dformat: respect date format options
  checkout: fix message when leaving detached HEAD

Johan Herland (1):
  Bring local clone's origin URL in line with that of a remote clone

Jonas Fonseca (1):
  Fix passwd(5) ref and reflect that commit doens't use commit-tree

Junio C Hamano (11):
  shell: do not play duplicated definition games to shrink the executab=
le
  Fix example in git-name-rev documentation
  git-apply: Loosen "match_beginning" logic
  gitattributes: -crlf is not binary
  'git foo' program identifies itself without dash in die() messages
  Start 1.6.0.2 maintenance cycle
  diff --cumulative is a sub-option of --dirstat
  "blame -c" should be compatible with "annotate"
  Mention the fact that 'git annotate' is only for backward compatibili=
ty.
  stash: refresh the index before deciding if the work tree is dirty
  Update draft release notes for 1.6.0.2

Linus Torvalds (1):
  Fix '--dirstat' with cross-directory renaming

Miklos Vajna (1):
  Makefile: add merge_recursive.h to LIB_H

Nanako Shiraishi (4):
  tests: use "git xyzzy" form (t0000 - t3599)
  tests: use "git xyzzy" form (t3600 - t6999)
  tests: use "git xyzzy" form (t7000 - t7199)
  tests: use "git xyzzy" form (t7200 - t9001)

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  diff*: fix worktree setup
  grep: fix worktree setup
  read-tree: setup worktree if merge is required
  update-index: fix worktree setup
  setup_git_directory(): fix move to worktree toplevel directory

Nicolas Pitre (2):
  discard revindex data when pack list changes
  improve handling of sideband message display

Paolo Bonzini (1):
  make git-shell paranoid about closed stdin/stdout/stderr

Paolo Ciarrocchi (1):
  tutorial: gentler illustration of Alice/Bob workflow using gitk

Petr Baudis (1):
  bash completion: Hide more plumbing commands

SZEDER G=C3=A1bor (3):
  Documentation: fix reference to a for-each-ref option
  Documentation: fix disappeared lines in 'git stash' manpage
  Documentation: minor cleanup in a use case in 'git stash' manual

Shawn O. Pearce (2):
  pack-objects: Allow missing base objects when creating thin packs
  git-gui: Fix diff parsing for lines starting with "--" or "++"

Teemu Likonen (1):
  config.txt: Add missing colons after option name

Yann Dirson (1):
  Document gitk --argscmd flag.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (5):
  Remove calculation of the longest command name from where it is not u=
sed
  Remove useless memset of static command name lists in builtin-merge.c
  Make main_cmds and other_cmds local to builtin-help.c
  Allow git help work without PATH set
  list_commands: only call git_exec_path if it is needed

Alexander Gavrilov (14):
  git-gui: Support starting gitk from Gui Blame
  git-gui: Support passing blame to a parent commit.
  git-gui: Better positioning in Blame Parent Commit
  git-gui: Allow specifying an initial line for git gui blame.
  gitk: Add option to specify the default commit on command line
  gitk: Add menu item for calling git gui blame
  git-gui: Support resolving conflicts via the diff context menu.
  git-gui: Support calling merge tools.
  git-gui: Don't allow staging files with conflicts.
  git-gui: Support more merge tools.
  git-gui: Support conflict states _U & UT.
  git-gui: Reimplement and enhance auto-selection of diffs.
  git-gui: Make F5 reselect a diff, if an untracked file is selected.
  git-gui: Show special diffs for complex conflict cases.

Brandon Casey (1):
  dir.c: Avoid c99 array initialization

Christian Stimming (1):
  git-gui: Mark forgotten strings for translation.

David Soria Parra (1):
  cast pid_t's to uintmax_t to improve portability

Eric Wong (2):
  git-svn: check error code of send_txstream
  t9124: clean up chdir usage

=46lorian Weimer (3):
  git-svn: extract base blob in generate_diff
  git-svn: Introduce SVN::Git::Editor::_chg_file_get_blob
  git-svn: Send deltas during commits

Giuseppe Bilotta (1):
  gitweb: ref markers link to named shortlogs

Gustaf Hendeby (1):
  git-gui: Teach git gui about file type changes

Junio C Hamano (11):
  revision.c: whitespace fix
  revision traversal: show full history with merge simplification
  Topo-sort before --simplify-merges
  revision --simplify-merges: use decoration instead of commit->util fi=
eld
  revision --simplify-merges: do not leave commits unprocessed
  revision --simplify-merges: make it a no-op without pathspec
  daemon.c: minor style fixup
  git commit --author=3D$name: look $name up in existing commits
  Update draft release notes for 1.6.1
  log --author/--committer: really match only with name part
  Update draft release notes for 1.6.1

Matthias Kestenholz (1):
  bash-completion: Add all submodule subcommands to the completion list

Nicolas Pitre (5):
  pack-objects: improve returned information from write_one()
  improve reliability of fixup_pack_header_footer()
  pack-objects: use fixup_pack_header_footer()'s validation mode
  index-pack: use fixup_pack_header_footer()'s validation mode
  fixup_pack_header_footer(): use nicely aligned buffer sizes

Paul Talacko (1):
  git-svn: set auto_props when renaming files

Romain Francoise (1):
  builtin-help: fallback to GIT_MAN_VIEWER before man

Stephen R. van den Berg (4):
  git-daemon: call logerror() instead of error()
  git-daemon: use LOG_PID, simplify logging code
  git-daemon: Simplify dead-children reaping logic
  git-daemon: rewrite kindergarden, new option --max-connections

Thomas Rast (13):
  filter-branch: Extend test to show rewriting bug
  filter-branch: fix ref rewriting with --subdirectory-filter
  filter-branch: use --simplify-merges
  Documentation: rev-list-options: move --simplify-merges documentation
  git svn: catch lack of upstream info for dcommit earlier
  git svn info: tests: let 'init' test run with SVN 1.5
  git svn info: tests: do not use set -e
  git svn info: tests: use test_cmp instead of git-diff
  git svn info: tests: fix ptouch argument order in setup
  git svn info: make info relative to the current directory
  git svn info: always quote URLs in 'info' output
  git-svn: match SVN 1.5 behaviour of info' on unknown item
  git-svn: fix 'info' tests for unknown items

Tor Arvid Lund (1):
  git-p4: Fix checkout bug when using --import-local.
