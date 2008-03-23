From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 23 Mar 2008 03:08:19 -0700
Message-ID: <7veja192i4.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
 <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
 <7v8x0wie56.fsf@gitster.siamese.dyndns.org>
 <7v4pbhv87i.fsf@gitster.siamese.dyndns.org>
 <7vfxv0npis.fsf@gitster.siamese.dyndns.org>
 <7vod9hr7p1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 23 11:09:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdN8o-00036G-NZ
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 11:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbYCWKI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 06:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758882AbYCWKI2
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 06:08:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753795AbYCWKI0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 06:08:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4066029C5;
	Sun, 23 Mar 2008 06:08:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 178FE29C4; Sun, 23 Mar 2008 06:08:21 -0400 (EDT)
X-maint-at: 81d66500c1e47d19c18d643ef074e0475dc90eb1
X-master-at: bc6100087cfac0293e6ccbea95a24223b724d072
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77876>

With a few late topics came quite a few regression fixes to make us rea=
dy
for -rc1.

 * gitk, git-gui and git-p4 have been updated.

 * "git gc --auto" annoyance is hopefully reduced away.

 * Breakage in automated tag following by git-fetch rewritten in C has
   hopefully been fixed.

 * Quite a few portability improvements from Solaris porting efforts.

 * "git remote show" does not talk about symrefs anymore.

 * "git help" updates to plug in more backends.

 * "git submodule summary" to show symmetric differences between commit=
s
   in submodules.

---

* The 'maint' branch has these fixes since the last announcement.

Bernt Hansen (1):
  git-new-workdir: Share SVN meta data between work dirs and the reposi=
tory

Eric Wong (1):
  git-svn: don't blindly append '*' to branch/tags config

Jonas Fonseca (1):
  Make man page building quiet when DOCBOOK_XSL_172 is defined

Junio C Hamano (3):
  format-patch: generate MIME header as needed even when there is
    format.header
  rebase -m: do not trigger pre-commit verification
  Start draft ReleaseNotes for 1.5.4.5

Linus Torvalds (1):
  rev-parse: fix meaning of rev~ vs rev~0.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  git-gui: update russian translation

Brandon Casey (2):
  builtin-gc.c: allow disabling all auto-gc'ing by assigning 0 to gc.au=
to
  t/t7003-filter-branch.sh: use test_must_fail rather than '!'

Christian Couder (5):
  help: add "man.viewer" config var to use "woman" or "konqueror"
  Documentation: help: describe 'man.viewer' config variable
  help: implement multi-valued "man.viewer" config option
  Documentation: help: explain 'man.viewer' multiple values
  help: warn if specified 'man.viewer' is unsupported, instead of error=
ing
    out

Daniel Barkalow (4):
  Write diff output to a file in struct diff_options
  Tighten refspec processing
  Fix t3200 config
  Fix tag following

David Aguilar (1):
  gitk: Don't show local changes when we there is no work tree

Eyvind Bernhardsen (2):
  fast-import: Allow "reset" to delete a new branch without error
  fast-import: Document the effect of "merge" with no "from" in a commi=
t

Jeff King (15):
  gitk: make autoselect optional
  tr portability fixes
  t0050: perl portability fix
  more tr portability test script fixes
  grep portability fix: don't use "-e" or "-q"
  remove use of "tail -n 1" and "tail -1"
  add test_cmp function for test scripts
  t4020: don't use grep -a
  t6000lib: tr portability fix
  add NO_EXTERNAL_GREP build option
  filter-branch: don't use xargs -0
  filter-branch: use $SHELL_PATH instead of 'sh'
  t9112: add missing #!/bin/sh header
  t7505: use SHELL_PATH in hook
  t6000lib: re-fix tr portability

Johannes Schindelin (1):
  remote show: do not show symbolic refs

Johannes Sixt (1):
  git-submodule summary: fix that some "wc" flavors produce leading spa=
ces

Jonas Fonseca (1):
  shortlog: do not require to run from inside a git repository

Junio C Hamano (15):
  Makefile: DIFF_OBJS is not special at all these days
  Makefile: flatten enumeration of headers, objects and programs
  Documentation/git-help: typofix
  Redo "add test_cmp function for test scripts"
  git-gui: Improve directions regarding POT update in po/README
  Resurrect git-rerere to contrib/examples
  Update draft release notes for 1.5.5
  t1000: use "test_must_fail git frotz", not "! git frotz"
  git-merge-one-file: fix longstanding stupid thinko
  Test: catch if trash cannot be removed
  Add tests to catch problems with un-unlinkable symlinks
  Fix read-tree not to discard errors
  remote.c: Fix overtight refspec validation
  gc --auto: raise default auto pack limit from 20 to 50
  GIT 1.5.5-rc1

Kevin Ballard (4):
  Add --reverse to the git-rev-list usage string
  Document the sendemail.smtpserverport config variable
  Don't try and percent-escape existing percent escapes in git-svn URIs
  Make git-svn tests behave better on OS X

Kristian H=C3=B8gsberg (1):
  wt-status.c: no need for dup() dance anymore

Linus Torvalds (4):
  Fix recent 'unpack_trees()'-related changes breaking 'git stash'
  Don't update unchanged merge entries
  Fix possible Solaris problem in 'checkout_entry()'
  Make revision limiting more robust against occasional bad commit date=
s

Marius Storm-Olsen (1):
  git-p4: Optimize the fetching of data from perforce.

Michele Ballabio (4):
  gitk: Mark another string for translation
  git-gui: update Italian translation
  gitk: initial Italian translation
  git-gui: remove spurious "fuzzy" attributes in po/it.po

Miklos Vajna (3):
  Update Hungarian translation. 100% completed.
  git-gui: Updated Hungarian translation (e5fba18)
  Documentation/git-merge: document subtree strategy.

Nanako Shiraishi (2):
  git-gui: Update Japanese translation
  git-gui: Update Japanese translation

Nicolas Pitre (1):
  make it easier for people who just want to get rid of 'git gc --auto'

Paul Mackerras (3):
  gitk: Only restore window size from ~/.gitk, not position
  gitk: Avoid Tcl error when switching views
  gitk: Default to using po2msg.sh if msgfmt doesn't grok --tcl, -l and=
 -d

Pekka Kaitaniemi (1):
  gitk: Add horizontal scrollbar to the diff view

Peter Karlsson (2):
  git-gui: Regenerated po template and merged translations with it
  git-gui: updated Swedish translation

Ping Yin (5):
  git-submodule summary: code framework
  git-submodule summary: show commit summary
  git-submodule summary: limit summary size
  git-submodule summary: documentation
  git-submodule summary: test

Ralf Wildenhues (1):
  Improve description of git filter-branch.

Shawn Bohrer (2):
  git-p4: Unset P4DIFF environment variable when using 'p4 -du diff'
  git-p4: Use P4EDITOR environment variable when set

Shawn O. Pearce (2):
  git-gui: Don't translate the special Apple menu
  git-gui: Adjusted Japanese translation to updated POT

Yann Dirson (1):
  Add an --argscmd flag to get the list of refs to show
