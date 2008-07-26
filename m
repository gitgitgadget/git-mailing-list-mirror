From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jul 2008, issue #08; Sat, 26)
Date: Sat, 26 Jul 2008 00:36:24 -0700
Message-ID: <7vprp1jdvr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 09:37:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMeLM-00050N-75
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 09:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYGZHgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jul 2008 03:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbYGZHgc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 03:36:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbYGZHgb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jul 2008 03:36:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0DD3B43D61;
	Sat, 26 Jul 2008 03:36:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 206CF43D60; Sat, 26 Jul 2008 03:36:27 -0400 (EDT)
X-maint-at: bfce5087ee01fdead5cdc52180c8eef22adbbd71
X-master-at: b0320eaf6a25fbc4adf35d611c27006e6d853aa8
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8FF8BDFE-5AE5-11DD-8B71-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90194>

There are quite a bunch of changes to 'master' but they are mostly fix-=
ups
to the new codepaths introduced recently; iow, exactly the kind of patc=
hes
we would want to see before and during the -rc period.

* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  index-pack.c: correctly initialize appended objects

Junio C Hamano (2):
  tests: propagate $(TAR) down from the toplevel Makefile
  Makefile: fix shell quoting

Peter Valdemar M=C3=B8rch (1):
  send-email: find body-encoding correctly

Pierre Habouzit (1):
  git-checkout: fix command line parsing.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Allow pager of diff command be enabled/disabled

Brad King (1):
  git-svn: teach dcommit about svn auto-props

Brandon Casey (7):
  t/: Replace diff [-u|-U0] with test_cmp to allow compilation with old
    diff
  t4116-apply-reverse.sh: use $TAR rather than tar
  t3200,t7201: replace '!' with test_must_fail
  t7502-commit.sh: rearrange test to make more portable
  t/t4202-log.sh: add newline at end of file
  Teach fsck and prune about the new location of temporary objects
  perl/Makefile: update NO_PERL_MAKEMAKER section

Daniel Barkalow (1):
  In perforce, RCS keywords are case-sensitive

Johannes Schindelin (8):
  Rename .git/rebase to .git/rebase-apply
  Rename path_list to string_list
  Fix two leftovers from path_list->string_list
  Ignore dirty submodule states in "git pull --rebase"
  Add test to show that show-branch misses out the 8th column
  sort_in_topological_order(): avoid setting a commit flag
  builtin-commit: Two trivial style-cleanups
  git daemon: avoid waking up too often

Johannes Sixt (10):
  rebase -i: When an 'edit' stops, mention the commit
  Makefile: Do not install a copy of 'git' in $(gitexecdir)
  Makefile: Normalize $(bindir) and $(gitexecdir) before comparing
  Record the command invocation path early
  Fix relative built-in paths to be relative to the command invocation
  Allow the built-in exec path to be relative to the command invocation
    path
  Allow add_path() to add non-existent directories to the path
  Windows: Make $(gitexecdir) relative
  Windows: Make sure argv[0] has a path
  Windows: Do not compile git-shell

Jonathan Nieder (2):
  git-diff(1): "--c" -> "--cc" typo fix
  document that git-tag can tag more than heads

Junio C Hamano (9):
  Update my e-mail address
  Revert "make git-status use a pager"
  tests: do not rely on external "patch"
  stash save: fix parameter handling
  builtin-branch.c: remove unused code in append_ref() callback functio=
n
  builtin-branch.c: optimize --merged and --no-merged
  Documentation: clarify diff --cc
  ignore non-existent refs in dwim_log()
  Documentation: clarify how to disable elements in core.whitespace

Lee Marlow (1):
  bash completion: Add long options for 'git rm'

Miklos Vajna (2):
  builtin-merge: give a proper error message for invalid strategies in
    config
  t7601: extend the 'merge picks up the best result' test

Nikolaj Schumacher (1):
  Don't cut off last character of commit descriptions.

Olivier Marin (4):
  git-am: remove dash from help message
  parse-options: fix segmentation fault when a required value is missin=
g
  git am --skip: clean the index while preserving local changes
  update test case to protect am --skip behaviour

P. Christeas (1):
  svnimport: newer libsvn wants us to ask for the root with "", not "/"

Petr Baudis (2):
  git-filter-branch.sh: Allow running in bare repositories
  Documentation/git-filter-branch: teach "rm" instead of "update-index
    --remove"

Philippe Bruhat (1):
  mailinfo: better parse email adresses containg parentheses

Pierre Habouzit (3):
  builtin-merge: add missing structure initialization
  git-submodule: move ill placed shift.
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

Stephan Beyer (7):
  git-am: Add colon before the subject that is printed out as being app=
lied
  am --abort: Add to bash-completion and mention in git-rerere
    documentation
  Make non-static functions, that may be static, static
  Move launch_editor() from builtin-tag.c to editor.c
  editor.c: Libify launch_editor()
  git-am: Mention --abort in usage string part of OPTIONS_SPEC
  git-reset: Let -q hush "locally modified" messages

Steve Haslam (2):
  Propagate -u/--upload-pack option of "git clone" to transport.
  Remove references to git-fetch-pack from "git clone" documentation.

Thomas Rast (1):
  git-completion.bash: provide completion for 'show-branch'
