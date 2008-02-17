From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 16 Feb 2008 19:56:58 -0800
Message-ID: <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 04:58:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQafG-0006S7-Dt
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 04:58:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbYBQD5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 22:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYBQD5a
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 22:57:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382AbYBQD52 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Feb 2008 22:57:28 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 573486321;
	Sat, 16 Feb 2008 22:57:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 EA3BA6320; Sat, 16 Feb 2008 22:57:21 -0500 (EST)
X-maint-at: 965053b09a2de5687b9098cb05edc9bfbf1d26b3
X-master-at: f8732c5596eb58d0daafdd61355e59831a95ae2e
In-Reply-To: <7vd4r24ox6.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Feb 2008 23:25:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74092>

I'll hopefully soon apply the RPM spec patch from Kristian
H=C3=B8gsberg to 'maint' and cut 1.5.4.2.  It will have bunch of
config parser related fixes among others.

On the 'master' front, a handful topics have graduated:

 - Brian Downing's compat/qsort;
 - Crhstian Couder's browser wrapper;
 - Paolo Bonzini's prepare-commit-msg hook;
 - Steffen Prohaska's safe-crlf;
 - "foo/" in .gitignore matches directory "foo".

Also, updated versions of gitk and git-gui are included.

Have fun.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Christian Couder (8):
  config: add test cases for empty value and no value config variables.
  diff.c: replace a 'strdup' with 'xstrdup'.
  diff.c: remove useless check for value !=3D NULL
  config: add 'git_config_string' to refactor string config variables.
  Add "const" qualifier to "char *pager_program".
  Add "const" qualifier to "char *editor_program".
  Add "const" qualifier to "char *excludes_file".
  diff.c: add "const" qualifier to "char *cmd" member of "struct
    ll_diff_driver"

Daniel Barkalow (1):
  Validate nicknames of remote branches to prohibit confusing ones

Gerrit Pape (1):
  cvsimport: have default merge regex also match beginning of commit
    message

Jay Soffian (1):
  mailinfo: feed only one line to handle_filter() for QP input

Jeff King (2):
  status: suggest "git rm --cached" to unstage for initial commit
  commit: discard index after setting up partial commit

Johannes Schindelin (1):
  bisect: use verbatim commit subject in the bisect log

Johannes Sixt (1):
  upload-pack: Initialize the exec-path.

Junio C Hamano (6):
  Revert "pack-objects: only throw away data during memory pressure"
  Protect get_author_ident_from_commit() from filenames in work tree
  diff.c: fixup garding of config parser from value=3DNULL
  diff: Fix miscounting of --check output
  filter-branch: handle filenames that need quoting
  Documentation/git-reset:

Miklos Vajna (1):
  git clone -s documentation: force a new paragraph for the NOTE

Pieter de Bie (2):
  Documentation/git-reset: don't mention --mixed for selected-paths res=
et
  Documentation/git-reset: Add an example of resetting selected paths

Sergei Organov (1):
  git-cvsimport.txt: fix '-M' description.

Shawn O. Pearce (1):
  fast-import: check return value from unpack_entry()

Stelian Pop (1):
  hg-to-git: fix parent analysis

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Brian Downing (1):
  compat: Add simplified merge sort implementation from glibc

Christian Couder (7):
  help: make 'git-help--browse' usable outside 'git-help'.
  help--browse: add '--config' option to check a config option for a
    browser.
  Rename 'git-help--browse.sh' to 'git-web--browse.sh'.
  instaweb: use 'git-web--browse' to launch browser.
  Documentation: instaweb: add 'git-web--browse' information.
  web--browse: Add a few quotes in 'init_browser_path'.
  Documentation: add 'git-web--browse.txt' and simplify other docs.

Christian Stimming (2):
  git-gui: (i18n) Fix a bunch of still untranslated strings.
  git-gui: Update German translation.

Dmitry Potapov (1):
  git-web--browse: do not start the browser with nohup

Gerrit Pape (1):
  gitk: properly deal with tag names containing / (slash)

Jay Soffian (3):
  git-gui: support Git Gui.app under OS X 10.5
  git-help--browse: improve browser support under OS X
  git-web--browse: fix misplaced quote in init_browser_path()

Jeff King (2):
  allow suppressing of global and system config
  fix config reading in tests

Johan Herland (2):
  Add testcase for 'git cvsexportcommit -w $cvsdir ...' with relative
    $GIT_DIR
  Fix 'git cvsexportcommit -w $cvsdir ...' when used with relative $GIT=
_DIR

Johannes Schindelin (1):
  Adjust .gitignore for 5884f1(Rename 'git-help--browse.sh'...)

Johannes Sixt (1):
  gitk: Heed the lines of context in merge commits

Junio C Hamano (7):
  Documentation/SubmittingPatches: Instruct how to use [PATCH] Subject
    header
  Documentation/SubmittingPatches: discuss first then submit
  Documentation/SubmittingPatches: What's Acked-by and Tested-by?
  gitignore(5): Allow "foo/" in ignore list to match directory "foo"
  gitignore: lazily find dtype
  .mailmap: adjust to a recent patch application glitch.
  Documentation/SubmittingPatches - a suggested patch flow

Linus Torvalds (1):
  gitk: learn --show-all output

Michele Ballabio (1):
  gitk: Fix "Key bindings" message

Paolo Bonzini (4):
  git-commit: support variable number of hook arguments
  git-commit: set GIT_EDITOR=3D: if editor will not be launched
  git-commit: Refactor creation of log message.
  git-commit: add a prepare-commit-msg hook

Shawn O. Pearce (7):
  git-gui: Automatically spell check commit messages as the user types
  git-gui: Paper bag fix bad string length call in spellchecker
  git-gui: Correct size of dictionary name widget in options dialog
  Include annotated tags in fast-import crash reports
  Include the fast-import marks table in crash reports
  Finish current packfile during fast-import crash handler
  Update fast-import documentation to discuss crash reports

Steffen Prohaska (2):
  safecrlf: Add mechanism to warn about irreversible crlf conversions
  gitk: Add checkbutton to ignore space changes
