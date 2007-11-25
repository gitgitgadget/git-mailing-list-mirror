From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sun, 25 Nov 2007 12:45:18 -0800
Message-ID: <7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 21:45:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOMP-0001mN-Sq
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756370AbXKYUpb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755222AbXKYUpb
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:45:31 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48386 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755186AbXKYUpa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2007 15:45:30 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A4B082F0;
	Sun, 25 Nov 2007 15:45:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F20299AE3;
	Sun, 25 Nov 2007 15:45:47 -0500 (EST)
X-maint-at: f0c4881facabc0aa76f4b51871bd70c45effb508
X-master-at: 92b7ba16b7605f70cac845d4a8d0162392ac0223
In-Reply-To: <7vy7cwsi3p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 17 Nov 2007 13:00:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65992>

There are quite a few backported fixes on 'maint' and it might make
sense to cut 1.5.3.7 soon.

On 'master' front, many topics that have been cooking in 'next' have
graduated.  Notably:

 - git-bisect learns "skip";

 - git-rebase --skip does not need "reset --hard" beforehand;

 - git-clean is now in C;

 - git-push is much more careful reporting errors and updateing trackin=
g
   refs.

 - git-push learns --mirror option.

Also contains the 0.9.0 series of git-gui with i18n.

----------------------------------------------------------------
* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (3):
  git-commit.sh: Fix usage checks regarding paths given when they do
      not make sense
  t7005-editor.sh: Don't invoke real vi when it is in GIT_EXEC_PATH
  git-commit: Add tests for invalid usage of -a/--interactive with path=
s

Brian Downing (2):
  config: correct core.loosecompression documentation
  config: clarify compression defaults

J. Bruce Fields (3):
  git-remote.txt: fix example url
  user-manual: mention "..." in "Generating diffs", etc.
  Documentation: Fix references to deprecated commands

Jeff King (1):
  send-email: add transfer encoding header with content-type

Johannes Schindelin (1):
  bundle create: keep symbolic refs' names instead of resolving them

Junio C Hamano (10):
  format-patch -s: add MIME encoding header if signer's name requires s=
o
  test format-patch -s: make sure MIME content type is shown as needed
  ce_match_stat, run_diff_files: use symbolic constants for readability
  git-add: make the entry stat-clean after re-adding the same contents
  t2200: test more cases of "add -u"
  grep -An -Bm: fix invocation of external grep command
  GIT 1.5.3.6
  Make test scripts executable.
  Fix sample pre-commit hook
  git-checkout: describe detached head correctly

Linus Torvalds (1):
  Fix rev-list when showing objects involving submodules

Matthieu Moy (1):
  Doc fix for git-reflog: mention @{...} syntax, and <ref> in synopsys.

R=C3=A9mi Vanicat (1):
  Make GIT_INDEX_FILE apply to git-commit

Steffen Prohaska (1):
  user-manual: Add section "Why bisecting merge commits can be harder .=
=2E."


----------------------------------------------------------------
* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (4):
  More updates and corrections to the russian translation of git-gui
  Updated russian translation of git-gui
  Add a test checking if send-pack updated local tracking branches
      correctly
  Update the tracking references only if they were succesfully
      updated on remote

Andy Whitcroft (5):
  Teach send-pack a mirror mode
  git-push: plumb in --mirror mode
  Add tests for git push'es mirror mode
  git-push: add documentation for the newly added --mirror mode
  git-quiltimport.sh fix --patches handling

Anton Gyllenberg (1):
  gitview: import only one of gtksourceview and gtksourceview2

Ask Bj=C3=B8rn Hansen (1):
  send-email: Don't add To: recipients to the Cc: header

Christian Couder (4):
  Bisect reset: remove bisect refs that may have been packed.
  Bisect visualize: use "for-each-ref" to list all good refs.
  Bisect: use "$GIT_DIR/BISECT_NAMES" to check if we are bisecting.
  Bisect reset: do nothing when not bisecting.

Christian Stimming (12):
  Mark strings for translation.
  Makefile rules for translation catalog generation and installation.
  Add glossary that can be converted into a po file for each
      language.
  Add glossary translation template into git.
  German translation for git-gui
  German glossary for translation
  git-gui: Add more words to translation glossary
  git-gui: Update German glossary according to mailing list
      discussion
  git-gui: Incorporate glossary changes into existing German
      translation
  git-gui: Update German translation, including latest glossary
      changes
  git-gui: Add more terms to glossary.
  git-gui: Update German translation

Daniel Barkalow (5):
  Miscellaneous const changes and utilities
  Build-in peek-remote, using transport infrastructure.
  Use built-in send-pack.
  Build-in send-pack, with an API for other programs to call.
  Build in ls-remote

David D Kilzer (3):
  git-svn log: fix ascending revision ranges
  git-svn log: include commit log for the smallest revision in a
      range
  git-svn log: handle unreachable revisions like "svn log"

David D. Kilzer (4):
  git-send-email: show all headers when sending mail
  git-svn: extract reusable code into utility functions
  git-svn info: implement info command
  git-svn: info --url [path]

David Reiss (1):
  git-svn: Fix a typo and add a comma in an error message in git-svn

David Symonds (2):
  git-checkout: Support relative paths containing "..".
  git-checkout: Test for relative path use.

Eric Wong (3):
  git-svn: add tests for command-line usage of init and clone
      commands
  t9106: fix a race condition that caused svn to miss modifications
  git-svn: allow `info' command to work offline

Guido Ostkamp (1):
  Use compat mkdtemp() on Solaris boxes

Harri Ilari Tapio Liusvaara (1):
  git-gui: Disambiguate "commit"

Irina Riesen (1):
  git-gui: initial version of russian translation

Jakub Narebski (3):
  gitweb: Style all tables using CSS
  gitweb: Put project README in div.readme, fix its padding
  autoconf: Add tests for memmem, strtoumax and mkdtemp functions

Jeff King (11):
  more terse push output
  receive-pack: don't mention successful updates
  send-pack: require --verbose to show update of tracking refs
  send-pack: track errors for each ref
  send-pack: check ref->status before updating tracking refs
  send-pack: assign remote errors to each ref
  make "find_ref_by_name" a public function
  send-pack: tighten remote error reporting
  send-pack: fix "everything up-to-date" message
  avoid "defined but not used" warning for fetch_objs_via_walker
  send-pack: cluster ref status reporting

Johannes Schindelin (9):
  Add po/git-gui.pot
  Ignore po/*.msg
  git-gui: Deiconify startup wizard so it raises to the top
  git-gui: add a simple msgfmt replacement
  po2msg: ignore entries marked with "fuzzy"
  po2msg: ignore untranslated messages
  po2msg: actually output statistics
  Close files opened by lock_file() before unlinking.
  rebase -i: move help to end of todo file

Johannes Sixt (14):
  git-gui: Change main window layout to support wider screens
  Give git-am back the ability to add Signed-off-by lines.
  t5300-pack-object.sh: Split the big verify-pack test into smaller
      parts.
  t7501-commit.sh: Not all seds understand option -i
  t5302-pack-index: Skip tests of 64-bit offsets if necessary.
  Skip t3902-quoted.sh if the file system does not support funny
      names.
  Use is_absolute_path() in sha1_file.c.
  Move #include <sys/select.h> and <sys/ioctl.h> to
      git-compat-util.h.
  builtin run_command: do not exit with -1.
  Allow a relative builtin template directory.
  Introduce git_etc_gitconfig() that encapsulates access of
      ETC_GITCONFIG.
  Allow ETC_GITCONFIG to be a relative path.
  fetch-pack: Prepare for a side-band demultiplexer in a thread.
  Flush progress message buffer in display().

Junio C Hamano (20):
  git-gui po/README: Guide to translators
  git-gui: Update Japanese strings (part 2)
  scripts: Add placeholders for OPTIONS_SPEC
  git-rev-parse --parseopt
  git-sh-setup: fix parseopt `eval` string underquoting
  send-pack: segfault fix on forced push
  git-am: -i does not take a string parameter.
  git-bisect: war on "sed"
  git-bisect: use update-ref to mark good/bad commits
  git-bisect: modernize branch shuffling hack
  Draft release notes: fix clean.requireForce description
  Update draft release notes for 1.5.4
  git-clean: Fix error message if clean.requireForce is not set.
  git-compat-util.h: auto-adjust to compiler support of FLEX_ARRAY a
      bit better
  Fix "quote" misconversion for rewrite diff output.
  Make test scripts executable.
  Addendum to "MaintNotes"
  t4119: correct overeager war-on-whitespace
  Deprecate peek-remote
  Update draft release notes for 1.5.4

Kirill (1):
  Updated Russian translation.

Konstantin V. Arkhipov (1):
  git-svn's dcommit must use subversion's config

Linus Torvalds (6):
  Simplify topo-sort logic
  Add "--early-output" log flag for interactive GUI use
  Enhance --early-output format
  revision walker: mini clean-up
  Fix rev-list when showing objects involving submodules
  Fix parent rewriting in --early-output

Michele Ballabio (4):
  git-gui: remove dots in some UI strings
  git-gui: add some strings to translation
  git-gui: fix typo in lib/blame.tcl
  git-gui: update Italian translation

Mike Hommey (1):
  Do git reset --hard HEAD when using git rebase --skip

Miklos Vajna (1):
  Hungarian translation of git-gui

Nanako Shiraishi (2):
  Japanese translation of git-gui
  git-gui: Update Japanese strings

Nicolas Pitre (1):
  rehabilitate some t5302 tests on 32-bit off_t machines

Paolo Ciarrocchi (1):
  Italian translation of git-gui

Pierre Habouzit (17):
  Add a parseopt mode to git-rev-parse to bring parse-options to
      shell scripts.
  Update git-sh-setup(1) to allow transparent use of git-rev-parse
      --parseopt
  Migrate git-clean.sh to use git-rev-parse --parseopt.
  Migrate git-clone to use git-rev-parse --parseopt
  Migrate git-am.sh to use git-rev-parse --parseopt
  Migrate git-merge.sh to use git-rev-parse --parseopt
  Migrate git-instaweb.sh to use git-rev-parse --parseopt
  Migrate git-checkout.sh to use git-rev-parse --parseopt
      --keep-dashdash
  Migrate git-quiltimport.sh to use git-rev-parse --parseopt
  Migrate git-repack.sh to use git-rev-parse --parseopt
  sh-setup: don't let eval output to be shell-expanded.
  parse-options new features.
  Use OPT_SET_INT and OPT_BIT in builtin-branch
  Use OPT_BIT in builtin-for-each-ref
  Use OPT_BIT in builtin-pack-refs
  Make the diff_options bitfields be an unsigned with explicit masks.
  Reorder diff_opt_parse options more logically per topics.

Shawn Bohrer (2):
  Make git-clean a builtin
  Teach git clean to use setup_standard_excludes()

Shawn O. Pearce (57):
  git-gui: Locate the library directory early during startup
  git-gui: Initialize Tcl's msgcat library for internationalization
  git-gui: Update po/README as symlink process is not necessary
  git-gui: Correct stock message for 'Invalid font specified in %s'
  git-gui: Quiet the msgfmt part of the make process
  git-gui: Ensure msgfmt failure stops GNU make
  git-gui: Mark revision chooser tooltip for translation
  git-gui: Localize commit/author dates when displaying them
  git-gui: Support context-sensitive i18n
  git-gui: Document the new i18n context support
  git-gui: Make the tree browser also use lightgray selection
  git-gui: Paper bag fix missing translated strings
  git-gui: Fix missing i18n markup in push/fetch windows
  git-gui: Support native Win32 Tcl/Tk under Cygwin
  git-gui: Refactor some UI init to occur earlier
  git-gui: Allow users to choose/create/clone a repository
  git-gui: Avoid console scrollbars unless they are necessary
  git-gui: Don't bother showing OS error message about hardlinks
  git-gui: Keep the UI responsive while counting objects in clone
  git-gui: Copy objects/info/alternates during standard clone
  git-gui: Don't delete console window namespaces too early
  git-gui: Don't delete scrollbars in console windows
  git-gui: Switch the git-gui logo to Henrik Nyh's logo
  git-gui: Make the status bar easier to read in the setup wizard
  git-gui: Use Henrik Nyh's git logo icon on Windows systems
  git-gui: Support a native Mac OS X application bundle
  git-gui: Refer to ourselves as "Git Gui" and not "git-gui"
  git-gui: Allow forced push into remote repository
  git-gui: Refactor Henrik Nyh's logo into its own procedure
  git-gui: Refactor about dialog code into its own module
  git-gui: Include our Git logo in the about dialog
  git-gui: Use progress meter in the status bar during index updates
  git-gui: Consolidate the Fetch and Push menus into a Remote menu
  git-gui: Bind Cmd-, to Preferences on Mac OS X
  git-gui: Shorten the staged/unstaged changes title bar text
  git-gui: Updated po strings based on current sources
  git-gui: Move load_config procedure below git-version selection
  git-gui: Refactor git-config --list parsing
  git-gui: Support LFs embedded in config file values
  git-gui: Change repository browser radio buttons to hyperlinks
  git-gui: Offer repository management features in menu bar
  git-gui: Fix bind errors when switching repository chooser panels
  git-gui: Disable the text widget in the repository chooser
  git-gui: Bind n/c/o accelerators in repository chooser
  git-gui: Ensure copyright message is correctly read as UTF-8
  git-gui: Use proper Windows shortcuts instead of bat files
  git-gui: Support cloning Cygwin based work-dirs
  git-gui: Collapse $env(HOME) to ~/ in recent repositories on
      Windows
  git-gui: Honor a config.mak in git-gui's top level
  git-gui: Paper bag fix the global config parsing
  git-gui: Make sure we get errors from git-update-index
  git-gui: Protect against bad translation strings
  git-gui: Allow users to set font weights to bold
  Reteach builtin-ls-remote to understand remotes
  git-gui: Bind Meta-T for "Stage To Commit" menu action
  Fix warning about bitfield in struct ref
  git-gui 0.9.0

Shun Kei Leung (1):
  git-p4: Fix typo in --detect-labels

Simon Hausmann (1):
  git-p4: Fix direct import from perforce after fetching changes
      through git from origin

Steffen Prohaska (4):
  git-gui: add directory git-gui is located in to PATH (on Windows)
  git-gui: set NO_MSGFMT to force using pure tcl replacement in
      msysgit
  git-gui: add mingw specific startup wrapper
  git-gui: offer a list of recent repositories on startup

Thomas Harning (1):
  git-merge-ours: make it a builtin.

Wincent Colaiuta (3):
  Further clarify clean.requireForce changes
  Authenticate only once in git-send-email
  Refactor patch_update_cmd

Xudong Guan (2):
  Initial Chinese translation for git-gui
  git-gui: Added initial version of po/glossary/zh_cn.po
