From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 14 May 2008 15:35:42 -0700
Message-ID: <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:36:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwPaW-0004dT-64
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 00:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbYENWfx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2008 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753794AbYENWfw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 18:35:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbYENWfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 May 2008 18:35:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F06AA2862;
	Wed, 14 May 2008 18:35:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C71142861; Wed, 14 May 2008 18:35:46 -0400 (EDT)
X-maint-at: a473445ac256f4a6ca5c66f83f33b85eec0e0c48
X-master-at: 4b172de81b878cdc8b10803fd0cd79b3ca66a621
In-Reply-To: <7vhcdchr80.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 05 May 2008 23:38:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 19D7C966-2206-11DD-BFEE-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82156>

The largest change to 'master' in this round is Linus's case insensitiv=
ity
changes.  I wanted to get feedback and fixes (if needed) from case
insensitive folks while the topic was still in 'next', but it did not
happen, but this should at least not harm sane filesystems, so let's se=
e
how it goes.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

A Large Angry SCM (1):
  git-repack: re-enable parsing of -n command line option

Dustin Sallings (1):
  Documentation/config.txt: Mention branch.<name>.rebase applies to "gi=
t
    pull"

Ian Hilt (1):
  Documentation/git-describe.txt: make description more readable

Jeff King (1):
  doc: clarify definition of "update" for git-add -u

Johannes Sixt (1):
  wt-status.h: declare global variables as extern

Sitaram Chamarty (1):
  builtin-commit.c: add -u as short name for --untracked-files


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Improve reporting of errors in config file routines

Brandon Casey (1):
  compat/fopen.c: avoid clobbering the system defined fopen macro

Bryan Donlan (10):
  git-rebase.sh: Fix --merge --abort failures when path contains whites=
pace
  config.c: Escape backslashes in section names properly
  git-send-email.perl: Handle shell metacharacters in $EDITOR properly
  test-lib.sh: Add a test_set_editor function to safely set $VISUAL
  Use test_set_editor in t9001-send-email.sh
  test-lib.sh: Fix some missing path quoting
  lib-git-svn.sh: Fix quoting issues with paths containing shell
    metacharacters
  Don't use the 'export NAME=3Dvalue' in the test scripts.
  Fix tests breaking when checkout path contains shell metacharacters
  Rename the test trash directory to contain spaces.

Caio Marcelo de Oliveira Filho (1):
  git-format-patch: add --no-binary to omit binary changes in the patch=
=2E

Christian Couder (12):
  help: use man viewer path from "man.<tool>.path" config var
  documentation: help: add "man.<tool>.path" config variable
  help: use "man.<tool>.cmd" as custom man viewer command
  documentation: help: add info about "man.<tool>.cmd" config var
  documentation: web--browse: add a note about konqueror
  Documentation: rename "hooks.txt" to "githooks.txt" and make it a man
    page
  Documentation: improve "add", "pull" and "format-patch" examples
  Documentation: bisect: add a few "git bisect run" examples
  bisect: print an error message when "git rev-list --bisect-vars" fail=
s
  rev-parse: add test script for "--verify"
  rev-parse: fix using "--default" with "--verify"
  rev-parse --verify: do not output anything on error

Dan McGee (1):
  Allow cherry-pick (and revert) to add signoff line

Daniel Barkalow (2):
  Make walker.fetch_ref() take a struct ref.
  Make ls-remote http://... list HEAD, like for git://...

Dustin Sallings (1):
  Allow tracking branches to set up rebase by default.

Eric Wong (1):
  git-svn: fix cloning of HTTP URLs with '+' in their path

Gerrit Pape (1):
  git-bisect.sh: don't accidentally override existing branch "bisect"

Gustaf Hendeby (1):
  Documentation/config.txt: Add git-gui options

Jakub Narebski (1):
  gitweb: Use feed link according to current view

Jeff King (7):
  add merge.renamelimit config option
  bump rename limit defaults
  diff: make "too many files" rename warning optional
  fix bsd shell negation
  t5000: tar portability fix
  clone: bsd shell portability fix
  filter-branch: fix variable export logic

Johannes Sixt (1):
  compat-util: avoid macro redefinition warning

Junio C Hamano (3):
  diff: a submodule not checked out is not modified
  diff-lib.c: rename check_work_tree_entity()
  is_racy_timestamp(): do not check timestamp for gitlinks

Krzysztof Kowalczyk (1):
  alloc_ref_from_str(): factor out a common pattern of alloc_ref from
    string

Linus Torvalds (12):
  Make unpack_trees_options bit flags actual bitfields
  Move name hashing functions into a file of its own
  Make "index_name_exists()" return the cache_entry it found
  Make hash_name_lookup able to do case-independent lookups
  Add 'core.ignorecase' option
  Make branch merging aware of underlying case-insensitive filsystems
  Make unpack-tree update removed files before any updated files
  When adding files to the index, add support for case-independent matc=
hes
  Make git-add behave more sensibly in a case-insensitive environment
  Optimize match_pathspec() to avoid fnmatch()
  Avoid some unnecessary lstat() calls
  Optimize symlink/directory detection

Mark Hills (1):
  Be more careful with objects directory permissions on clone

Miklos Vajna (3):
  git-format-patch: add a new format.cc configuration variable
  git-send-email: add a new sendemail.cc configuration variable
  Add tests for sendemail.cc configuration variable

Ping Yin (2):
  t4027: test diff for submodule with empty directory
  Add t7506 to test submodule related functions for git-status

SZEDER G=C3=A1bor (5):
  doc: moved merge.* config variables into separate merge-config.txt
  merge, pull: introduce '--(no-)stat' option
  add 'merge.stat' config variable
  fmt-merge-msg: add '--(no-)log' options and 'merge.log' config variab=
le
  merge, pull: add '--(no-)log' command line option

Santi B=C3=A9jar (3):
  Preparation to call determine_author_info from prepare_to_commit
  commit: Show author if different from committer
  commit: Show committer if automatic

Sebastian Schuberth (1):
  mergetool: Make ECMerge use the settings as specified by the user in =
the
    GUI

Steven Grimm (1):
  Add svn-compatible "blame" output format to git-svn
