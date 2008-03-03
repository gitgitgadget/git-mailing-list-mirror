From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 02 Mar 2008 18:06:30 -0800
Message-ID: <7vod9wlfx5.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
 <7vablloqqe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 03:07:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW05H-0004XT-Fp
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 03:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbYCCCGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2008 21:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbYCCCGm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 21:06:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49324 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbYCCCGl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2008 21:06:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E37DA2860;
	Sun,  2 Mar 2008 21:06:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D768F24DD; Sun,  2 Mar 2008 21:06:35 -0500 (EST)
X-maint-at: 84989bd820119260c4fcd0dd5ee8a50bc8ff0d2c
X-master-at: 34cd62eb91600109378c8121c1fecd924a9af177
In-Reply-To: <7vablloqqe.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Feb 2008 16:43:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75866>

The 'master' has, aside from trivial fixes and enhancements, the follow=
ing
topics that have been cooking:

 * "verify-pack" improvements;

 * "describe" that warns about a tag whose name and path contradict;

 * "describe --long" to show an tagged commit as $tag-0-$sha1;

 * "cvsimport -M" can be given more than once;

 * "gitweb" grep-search improvements;

A handful of the topics are meant also for 'maint'; after seeing no
complaints for a while they will be merged to 'maint' as part of the ne=
xt
maintenance release v1.5.4.4.

----------------------------------------------------------------
* The 'maint' branch has these fixes since the last announcement.

Daniel Barkalow (1):
  Correct name of diff_flush() in API documentation

Gerrit Pape (1):
  templates/Makefile: don't depend on local umask setting

Junio C Hamano (1):
  Start preparing for 1.5.4.4

Mike Ralphson (1):
  Documentation cherry-pick: Fix cut-and-paste error

R=C3=A9mi Vanicat (1):
  git.el: find the git-status buffer whatever its name is

Shawn O. Pearce (1):
  git-gui: Paper bag fix info dialog when no files are staged at commit

----------------------------------------------------------------
* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Fix builtin checkout crashing when given an invalid path

Christian Stimming (2):
  git-gui: (i18n) Add newly added translation strings to template.
  git-gui: Update German translation.

Clemens Buchacher (2):
  http-push: push <remote> :<branch> deletes remote branch
  http-push: add regression tests

Daniel Barkalow (3):
  Always use the current connection's remote ref list in git protocol
  Use diff_tree() directly in making cover letter
  Write index file on any checkout of files

Denis Cheng (1):
  cleanup: remove unused git_checkout_config

=46rank Lichtenheld (1):
  gc: Add --quiet option

Jakub Narebski (4):
  gitweb: Change parse_commits signature to allow for multiple options
  gitweb: Simplify fixed string search
  Documentation: Remove --{min,max}-age option from git-log(1)
  gitweb: Mark first match when searching commit messages

Jean-Luc Herren (1):
  fast-import: exit with proper message if not a git dir

Jeff King (3):
  use build-time SHELL_PATH in test scripts
  rename: warn user when we have turned off rename detection
  allow git-am to run in a subdirectory

Johannes Schindelin (4):
  completion: support format-patch's --cover-letter option
  Fix make_absolute_path() for parameters without a slash
  format-patch: use the diff options for the cover letter, too
  format-patch: wrap cover-letter's shortlog sensibly

Johannes Sixt (2):
  daemon: send more error messages to the syslog
  daemon: ensure that base-path is an existing directory

Junio C Hamano (11):
  git-remote: do not complain on multiple URLs for a remote
  Fix "git log --merge --left-right"
  format-patch: remove a leftover debugging message
  tests: introduce test_must_fail
  Update draft release notes for 1.5.5
  t6024: move "git reset" to prepare for a test inside the test itself
  CodingGuidelines: spell out how we use grep in our scripts
  find_unique_abbrev(): redefine semantics
  Clean up find_unique_abbrev() callers
  diff-lib.c: constness strengthening
  diff: make sure work tree side is shown as 0{40} when different

Martin Koegler (10):
  add generic, type aware object chain walker
  builtin-fsck: move away from object-refs to fsck_walk
  Remove unused object-ref code
  builtin-fsck: reports missing parent commits
  builtin-fsck: move common object checking code to fsck.c
  add common fsck error printing function
  unpack-object: cache for non written objects
  unpack-objects: prevent writing of inconsistent objects
  index-pack: introduce checking mode
  receive-pack: use strict mode for unpacking objects

Michele Ballabio (1):
  git-gui: fix typo in lib/spellcheck.tcl

Mike Hommey (4):
  Set proxy override with http_init()
  Add test for git rebase --abort
  Documentation/git-rebase.txt: Add --strategy to synopsys
  git rebase --abort: always restore the right commit

Miklos Vajna (1):
  Improve t6029 to check the real "subtree" case

Nicolas Pitre (4):
  factorize revindex code out of builtin-pack-objects.c
  make verify_one_pack() a bit less wrong wrt packed_git structure
  fix unimplemented packed_object_info_detail() features
  add storage size output to 'git verify-pack -v'

Petr Baudis (1):
  gitweb: Clearly distinguish regexp / exact match searches

Philippe Bruhat (BooK (3):
  cvsimport: have default merge regex allow for dashes in the branch na=
me
  cvsimport: allow for multiple -M options
  cvsimport: document that -M can be used multiple times

Ralf Wildenhues (1):
  Fix doc typos.

Santi B=C3=A9jar (2):
  git-describe: --long shows the object name even for a tagged commit
  clone: support cloning full bundles

Sebastian Noack (1):
  git-svn: Don't prompt for client cert password everytime.

Shawn O. Pearce (7):
  git-gui: Ensure all spellchecker 'class' variables are initialized
  git-gui: Remove explicit references to 'aspell' in message strings
  git-gui: Only bind the spellcheck popup suggestion hook once
  git-gui: Catch and display aspell startup failures to the user
  git-gui: Gracefully display non-aspell version errors to users
  git-gui: Shorten Aspell version strings to just Aspell version number
  Teach git-describe to verify annotated tag names before output

Uwe Kleine-K=C3=B6nig (1):
  rev-list: add --branches, --tags and --remotes

