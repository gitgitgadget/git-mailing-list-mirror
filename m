From: Junio C Hamano <junio@pobox.com>
Subject: GIT 1.6.0-rc1
Date: Sun, 27 Jul 2008 17:09:38 -0700
Message-ID: <7vy73myim5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 02:10:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNGK7-000146-MJ
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 02:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756696AbYG1AJr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jul 2008 20:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756727AbYG1AJq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 20:09:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755730AbYG1AJp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jul 2008 20:09:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8864B421FC;
	Sun, 27 Jul 2008 20:09:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 78ABD421FB; Sun, 27 Jul 2008 20:09:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7B79F816-5C39-11DD-959C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90378>

Ok, so I tagged and pushed it out.  There still is the "git mv" bugfix
from Pasky that is parked in 'next' but other than that I think this is
pretty much "it" for 1.6.0 feature-wise.

Major parts of the changes since 1.6.0-rc0 consists of documentation an=
d
tests portability; there is nothing surprising nor scary.

Test tarballs and RPMs are also there.  Please give it a good beating.

----------------------------------------------------------------

Changes since v1.6.0-rc0 are as follows:

Abhijit Menon-Sen (2):
      git-gui: Look for gitk in $PATH, not $LIBEXEC/git-core
      Clarify that "git log x.c y.h" lists commits that touch either fi=
le

Alex Riesen (1):
      Allow pager of diff command be enabled/disabled

Alexander Gavrilov (4):
      Fix pre-commit hooks under MinGW/MSYS
      Add options to control the search for copies in blame.
      Kill the blame back-end on window close.
      Add a menu item to invoke full copy detection in blame.

Anders Melchiorsen (1):
      Documentation: fix diff.external example

Bj=C3=B6rn Steinbrink (2):
      index-pack.c: correctly initialize appended objects
      rev-parse: Add support for the ^! and ^@ syntax

Brad King (1):
      git-svn: teach dcommit about svn auto-props

Brandon Casey (7):
      t/: Replace diff [-u|-U0] with test_cmp to allow compilation with=
 old diff
      t4116-apply-reverse.sh: use $TAR rather than tar
      t3200,t7201: replace '!' with test_must_fail
      t7502-commit.sh: rearrange test to make more portable
      t/t4202-log.sh: add newline at end of file
      Teach fsck and prune about the new location of temporary objects
      perl/Makefile: update NO_PERL_MAKEMAKER section

Cesar Eduardo Barros (1):
      Documentation/git-submodule.txt: fix doubled word

Daniel Barkalow (1):
      In perforce, RCS keywords are case-sensitive

Jakub Narebski (1):
      gitweb: More about how gitweb gets 'owner' of repository

Johannes Schindelin (9):
      Rename .git/rebase to .git/rebase-apply
      Rename path_list to string_list
      Fix two leftovers from path_list->string_list
      Ignore dirty submodule states in "git pull --rebase"
      Add test to show that show-branch misses out the 8th column
      sort_in_topological_order(): avoid setting a commit flag
      builtin-commit: Two trivial style-cleanups
      git daemon: avoid waking up too often
      Avoid chdir() in list_commands_in_dir()

Johannes Sixt (12):
      rebase -i: When an 'edit' stops, mention the commit
      Makefile: Do not install a copy of 'git' in $(gitexecdir)
      Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
      Record the command invocation path early
      Fix relative built-in paths to be relative to the command invocat=
ion
      Allow the built-in exec path to be relative to the command invoca=
tion path
      Allow add_path() to add non-existent directories to the path
      Windows: Make $(gitexecdir) relative
      Windows: Make sure argv[0] has a path
      Windows: Do not compile git-shell
      git-gui: Fix "Stage/Unstage Line" with one line of context.
      git-gui: "Stage Line": Treat independent changes in adjacent line=
s better

Jonathan Nieder (3):
      git-diff(1): "--c" -> "--cc" typo fix
      document that git-tag can tag more than heads
      t6030 (bisect): work around Mac OS X "ls"

Junio C Hamano (13):
      Update my e-mail address
      Revert "make git-status use a pager"
      tests: do not rely on external "patch"
      stash save: fix parameter handling
      builtin-branch.c: remove unused code in append_ref() callback fun=
ction
      builtin-branch.c: optimize --merged and --no-merged
      Documentation: clarify diff --cc
      ignore non-existent refs in dwim_log()
      tests: propagate $(TAR) down from the toplevel Makefile
      Makefile: fix shell quoting
      Documentation: clarify how to disable elements in core.whitespace
      make sure parsed wildcard refspec ends with slash
      GIT 1.6.0-rc1

Lars Hjemli (3):
      builtin-branch: remove duplicated code
      builtin-branch: factor out merge_filter matching
      builtin-branch: fix -v for --[no-]merged

Lee Marlow (2):
      bash completion: Add long options for 'git rm'
      bash completion: Add completion for 'git help'

Miklos Vajna (2):
      builtin-merge: give a proper error message for invalid strategies=
 in config
      t7601: extend the 'merge picks up the best result' test

Nikolaj Schumacher (1):
      Don't cut off last character of commit descriptions.

Olivier Marin (4):
      git-am: remove dash from help message
      parse-options: fix segmentation fault when a required value is mi=
ssing
      git am --skip: clean the index while preserving local changes
      update test case to protect am --skip behaviour

P. Christeas (1):
      svnimport: newer libsvn wants us to ask for the root with "", not=
 "/"

Peter Valdemar M=C3=B8rch (1):
      send-email: find body-encoding correctly

Petr Baudis (4):
      git-filter-branch.sh: Allow running in bare repositories
      Documentation/git-filter-branch: teach "rm" instead of "update-in=
dex --remove"
      git-mv: Remove dead code branch
      git-mv: Keep moved index entries inact

Philippe Bruhat (1):
      mailinfo: better parse email adresses containg parentheses

Pierre Habouzit (4):
      builtin-merge: add missing structure initialization
      git-submodule: move ill placed shift.
      git-checkout: fix command line parsing.
      git-checkout: improve error messages, detect ambiguities.

Ren=C3=A9 Scharfe (5):
      archive: add write_archive()
      archive: move parameter parsing code to archive.c
      archive: define MAX_ARGS where it's needed
      archive: declare struct archiver where it's needed
      archive: allow --exec and --remote without equal sign

SZEDER G=C3=A1bor (2):
      checkout: mention '--' in the docs
      bash: offer only paths after '--' for 'git checkout'

Shawn O. Pearce (2):
      git-gui: Correct 'Visualize Branches' on Mac OS X to start gitk
      fsck: Don't require tmp_obj_ file names are 14 bytes in length

Stephan Beyer (7):
      git-am: Add colon before the subject that is printed out as being=
 applied
      am --abort: Add to bash-completion and mention in git-rerere docu=
mentation
      Make non-static functions, that may be static, static
      Move launch_editor() from builtin-tag.c to editor.c
      editor.c: Libify launch_editor()
      git-am: Mention --abort in usage string part of OPTIONS_SPEC
      git-reset: Let -q hush "locally modified" messages

Steve Haslam (2):
      Propagate -u/--upload-pack option of "git clone" to transport.
      Remove references to git-fetch-pack from "git clone" documentatio=
n.

Thomas Rast (2):
      git-completion.bash: provide completion for 'show-branch'
      bash completion: Add long options for 'git describe'
