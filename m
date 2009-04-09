From: Junio C Hamano <junio@pobox.com>
Subject: What's in git.git (Apr 2009, #01; Thu, 09)
Date: Thu, 09 Apr 2009 02:11:05 -0700
Message-ID: <7vmyaq2nva.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 11:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrqK2-0002Is-8i
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 11:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760756AbZDIJLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 05:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758400AbZDIJLt
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 05:11:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758572AbZDIJLr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 05:11:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9691DA9B16;
	Thu,  9 Apr 2009 05:11:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AD98EA9B15; Thu,
  9 Apr 2009 05:11:30 -0400 (EDT)
X-maint-at: db12d97542762cdb54d332ea047122f1071132b5
X-master-at: e37347bba651f051998f23a3701b555f1a194557
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FE2FB9E-24E6-11DE-BD34-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116158>

We have quite a few documentation fixes accumulated on the maint branch=
;
perhaps a new maintenance release 1.6.2.3 mid next week.

On the 'master' front, there are currently 6 topics cooking in 'next', =
all
of which look quite good.  I'll probably tag 1.6.3-rc0 this weekend wit=
h
most of these topics and keep cooking the rest for 1.6.4 cycle.

* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  process_{tree,blob}: Remove useless xstrdup calls

Brandon Casey (7):
  t7700-repack: add two new tests demonstrating repacking flaws
  git-repack.sh: don't use --kept-pack-only option to pack-objects
  pack-objects: only repack or loosen objects residing in "local" packs
  Remove --kept-pack-only option and associated infrastructure
  git-branch: display "was sha1" on branch deletion rather than just "s=
ha1"
  t7700: demonstrate repack flaw which may loosen objects unnecessarily
  pack-objects: don't loosen objects available in alternate or kept pac=
ks

Dan McGee (1):
  git-repack: use non-dashed update-server-info

David J. Mellor (12):
  Documentation: minor grammatical fixes in git-archive.txt.
  Documentation: reword the "Description" section of git-bisect.txt.
  Documentation: minor grammatical fixes in git-blame.txt.
  Documentation: minor grammatical fixes in git-branch.txt.
  Documentation: reworded the "Description" section of git-bisect.txt.
  Documentation: reword example text in git-bisect.txt.
  Documentation: remove some uses of the passive voice in git-bisect.tx=
t
  Documentation: minor grammatical fixes and rewording in git-bundle.tx=
t
  Documentation: minor grammatical fixes in git-cat-file.txt
  Documentation: minor grammatical fixes in git-check-attr.txt
  Documentation: minor grammatical fix in git-check-ref-format.txt
  Documentation: Remove spurious uses of "you" in git-bisect.txt.

Holger Wei=C3=9F (1):
  Documentation: Remove an odd "instead"

Jari Aalto (1):
  Change double quotes to single quotes in message

Jason Merrill (1):
  Documentation: clarify .gitattributes search

Jeff King (3):
  fix portability problem with IS_RUN_COMMAND_ERR
  t1301: loosen test for forced modes
  commit: abort commit if interactive add failed

Johan Herland (1):
  Move chmod(foo, 0444) into move_temp_to_file()

Johannes Schindelin (2):
  Smudge the files fed to external diff and textconv
  mailmap: resurrect lower-casing of email addresses

Johannes Sixt (1):
  Propagate --exec-path setting to external commands via GIT_EXEC_PATH

Julien Danjou (1):
  git submodule: fix usage line

Junio C Hamano (13):
  git-repack: resist stray environment variable
  has_sha1_pack(): refactor "pretend these packs do not exist" interfac=
e
  has_sha1_kept_pack(): take "struct rev_info"
  Consolidate ignore_packed logic more
  Simplify is_kept_pack()
  is_kept_pack(): final clean-up
  blame: read custom grafts given by -S before calling setup_revisions(=
)
  diff --cached: do not borrow from a work tree when a path is marked a=
s
    assume-unchanged
  "core.sharedrepository =3D 0mode" should set, not loosen
  move_temp_to_file(): do not forget to chmod() in "Coda hack" codepath
  set_shared_perm(): sometimes we know what the final mode bits should =
look
    like
  GIT 1.6.2.2
  Start 1.6.2.3 preparation

Markus Heidelberg (1):
  doc/git-pack-refs: fix two grammar issues

Matthieu Moy (3):
  git-checkout.txt: fix incorrect statement about HEAD and index
  git-checkout.txt: clarify that <branch> applies when no path is given=
=2E
  git-pull.sh: better warning message for "git pull" on detached head.

Thomas Rast (1):
  Documentation: format-patch --root clarifications


* The 'master' branch has these since the last announcement
  in addition to the above.

Ali Gholami Rudi (2):
  builtin-clone.c: make junk_pid static
  builtin-clone.c: no need to strdup for setenv

Bj=C3=B6rn Steinbrink (2):
  Mailmap: Allow empty email addresses to be mapped
  tree_entry_interesting: a pathspec only matches at directory boundary

Chris Johnsen (11):
  Documentation/Makefile: make most operations "quiet"
  Documentation/Makefile: break up texi pipeline
  Documentation: move callouts.xsl to manpage-{base,normal}.xsl
  Documentation: use parametrized manpage-base.xsl with
    manpage-{1.72,normal}.xsl
  Documentation: rename docbook-xsl-172 attribute to git-asciidoc-no-ro=
ff
  Documentation: move quieting params into manpage-base.xsl
  Documentation: move "spurious .sp" code into manpage-base.xsl
  Documentation: asciidoc.conf: always use <literallayout> for [blockte=
xt]
  Documentation: asciidoc.conf: fix verse block with block titles
  Documentation: option to render literal text as bold for manpages
  Documentation: use "spurious .sp" XSLT if DOCBOOK_SUPPRESS_SP is set

Christian Couder (2):
  log-tree: fix patch filename computation in "git format-patch"
  bisect: improve error message when branch checkout fails

Clemens Buchacher (3):
  add tests for merging with submodules
  update cache for conflicting submodule entries
  simplify output of conflicting merge

Erik Faye-Lund (4):
  test-suite: adding a test for fast-export with tag variants
  builtin-fast-export.c: turn error into warning
  builtin-fast-export.c: fix crash on tagged trees
  builtin-fast-export.c: handle nested tags

=46elipe Contreras (3):
  user-manual: remove some git-foo usage
  docbook: change css style
  user-manual: the name of the hash function is SHA-1, not sha1

Heiko Voigt (2):
  Cleanup warning about known issues in cvsimport documentation
  Add configuration variable for sign-off to format-patch

Jay Soffian (5):
  send-email: don't attempt to prompt if tty is closed
  send-email: ask_default should apply to all emails, not just the firs=
t
  send-email: correct two tests which were going interactive
  send-email: ensure quoted addresses are rfc2047 encoded
  send-email: fix nasty bug in ask() function

Jeff King (1):
  tests: remove exit after test_done call

Johannes Schindelin (1):
  Fix 'git checkout <submodule>' to update the index

Junio C Hamano (10):
  Rename interpret/substitute nth_last_branch functions
  strbuf_branchname(): a wrapper for branch name shorthands
  check-ref-format --branch: give Porcelain a way to grok branch shorth=
and
  Fix branch -m @{-1} newname
  strbuf_check_branch_ref(): a helper to check a refname for a branch
  check_ref_format(): tighten refname rules
  match_tree_entry(): a pathspec only matches at directory boundaries
  Update draft release notes to 1.6.3
  Update draft release notes to 1.6.3
  Speed up reflog pruning of unreachable commits

Kjetil Barvik (1):
  stat_tracking_info(): only count real commits

Linus Torvalds (1):
  Clean up reflog unreachability pruning decision

Markus Heidelberg (1):
  add --html-path to get the location of installed HTML docs

Martin Storsj=C3=B6 (1):
  Allow curl to rewind the read buffers

Matthieu Moy (2):
  git-send-email.txt: clarify which options take an argument.
  git-rev-list.txt: make ascii markup uniform with other pages.

Michael Hendricks (1):
  format-patch: add arbitrary email headers

Michael J Gruber (2):
  Test for local branches being followed with --track
  Make local branches behave like remote branches when --tracked

Santi B=C3=A9jar (1):
  Documentation: branch.*.merge can also affect 'git-push'

Shawn O. Pearce (1):
  Don't permit ref/branch names to end with ".lock"

Simon Arlott (1):
  git-svn: add a double quiet option to hide git commits

Stephen Boyd (7):
  pretty.c: add %f format specifier to format_commit_message()
  format-patch: construct patch filename in one function
  format-patch: pass a commit to reopen_stdout()
  format-patch: move get_patch_filename() into log-tree
  format-patch: --attach/inline uses filename instead of SHA1
  format-patch: --numbered-files and --stdout aren't mutually exclusive
  format_sanitized_subject: Don't trim past initial length of strbuf

Todd Zullinger (1):
  bash completion: Update 'git am' options

Wesley J. Landaker (1):
  Documentation: git-svn: fix trunk/fetch svn-remote key typo
