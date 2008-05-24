From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 23 May 2008 18:32:08 -0700
Message-ID: <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 24 03:33:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzidF-00048u-2C
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 03:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172AbYEXBcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 21:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbYEXBcW
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 21:32:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755004AbYEXBcU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 21:32:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 74BE93F86;
	Fri, 23 May 2008 21:32:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EAA7D3F85; Fri, 23 May 2008 21:32:15 -0400 (EDT)
X-maint-at: 77599cc0bbd0a08defc3bfa80ca52d931d8dc786
X-master-at: 182fb4df9120257c2e6b041dd58eef3de5b530d2
In-Reply-To: <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 14 May 2008 15:35:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F644D44-2931-11DD-AE03-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82788>

Quite a many topics have graduated to 'master' and hopefully we can tag
1.5.6-rc0 this weekend.  At about the same time I'll do 1.5.5.2 out of
'maint' branch, as it has accumulated quite a few fixes as well.

* The 'maint' branch has these fixes since the last announcement.

Heikki Orsila (1):
  Add missing "short" alternative to --date in rev-list-options.txt

Jeff King (2):
  doc/git-daemon: s/uploadarchive/uploadarch/
  git-am: fix typo in usage message

Johannes Sixt (1):
  rev-parse --symbolic-full-name: don't print '^' if SHA1 is not a ref

Jon Loeliger (2):
  git-filter-branch: Clarify file removal example.
  git-show.txt: Not very stubby these days.

Shawn O. Pearce (1):
  Clarify repack -n documentation


* The 'master' branch has these since the last announcement
  in addition to the above.

Adam Simpkins (4):
  revision API: split parent rewriting and parent printing options
  Add history graph API
  log and rev-list: add --graph option
  graph API: eliminate unnecessary indentation

Alex Riesen (7):
  Make the exit code of add_file_to_index actually useful
  Extend interface of add_files_to_cache to allow ignore indexing errors
  Add --ignore-errors to git-add to allow it to skip files with read errors
  Add a test for git-add --ignore-errors
  Add a config option to ignore errors for git-add
  Ensure that a test is run in the trash directory
  Fix t3701 if core.filemode disabled

Anders Waldenborg (1):
  gitweb: Convert string to internal form before chopping in chop_str

Brandon Casey (4):
  repack: modify behavior of -A option to leave unreferenced objects
    unpacked
  git-gc: always use -A when manually repacking
  builtin-gc.c: deprecate --prune, it now really has no effect
  t/Makefile: "trash" directory was renamed recently

Chris Frey (2):
  Documentation/git-prune.txt: document unpacked logic
  Documentation/git-repack.txt: document new -A behaviour

Chris Parsons (1):
  Updated status to show 'Not currently on any branch' in red

Christian Couder (1):
  Documentation: rev-parse: add a few "--verify" and "--default" examples

Christian Stimming (3):
  git-gui: Update German translation
  gitk: Update German translation
  gitk: German translation again updated

Dmitry Potapov (1):
  git-init: autodetect core.ignorecase

Dustin Sallings (1):
  Allow tracking branches to set up rebase by default.

Gerrit Pape (1):
  gitk: Makefile/install: force permissions when installing files and dirs

Gustaf Hendeby (1):
  Documentation: Add missing git svn commands

Heikki Orsila (1):
  Add log.date config variable

Horst H. von Brand (1):
  Fix recipient santitization

Imran M Yousuf (1):
  Use '-f' option to point to the .gitmodules file

Jeff King (2):
  send-email: specify content-type of --compose body
  send-email: rfc2047-quote subject lines with non-ascii characters

Johannes Schindelin (2):
  submodule update: add convenience option --init
  pull --rebase: exit early when the working directory is dirty

Johannes Sixt (1):
  git-gui: Report less precise object estimates for database compression

Lars Hjemli (1):
  revision.c: really honor --first-parent

Marcel Koeppen (2):
  Replace in-place sed in t7502-commit
  Fix prepare-commit-msg hook and replace in-place sed

Michele Ballabio (1):
  gitk: Disable "Reset %s branch to here" when on a detached head

Mike Ralphson (1):
  Makefile: update the default build options for AIX

Miklos Vajna (2):
  git-fast-import: rename cmd_*() functions to parse_*()
  git-merge: exclude unnecessary options from OPTIONS_SPEC

Nicolas Pitre (9):
  pack-objects: small cleanup
  pack-objects: remove some double negative logic
  pack-objects: simplify the condition associated with --all-progress
  pack-objects: clean up write_object() a bit
  pack-objects: move compression code in a separate function
  pack-objects: allow for early delta deflating
  pack-objects: fix early eviction for max depth delta objects
  add a force_object_loose() function
  let pack-objects do the writing of unreachable objects as loose objects

Paolo Bonzini (1):
  add special "matching refs" refspec

Paul Mackerras (37):
  gitk: Use git log without --topo-order and reorganize the commits
    ourselves
  gitk: Fix bug in assigning row numbers to arcs
  gitk: Fix bug in parsing multiple revision arguments
  gitk: Compute row numbers and order tokens lazily
  gitk: Fix a couple of bugs
  gitk: Fix more bugs resulting in Tcl "no such element in array" errors
  gitk: More bug fixes and cleanups
  gitk: Implement date mode in the new framework
  gitk: Fix another collection of bugs
  gitk: Don't try to show local changes from a head that isn't shown
  gitk: Keep the same commits visible as other commits come in
  gitk: Fix some corner cases in the targetid/targetrow stuff
  gitk: Fix a couple of bugs in the find function
  gitk: Fix potential bug with fake commit IDs in renumbervarc
  gitk: Index [fnvr]highlights by id rather than row
  gitk: Fix handling of flag arguments
  gitk: Fix a bug in make_disporder
  gitk: Select head of current branch by default
  gitk: Select something appropriate on cherry-pick, branch reset and
    checkout
  gitk: Fix bug where editing an existing view would cause an infinite loop
  gitk: Fix bug causing Tcl error when no commits are selected
  gitk: Fix cherry-picking to insert a real row not a fake row
  gitk: Cope better with getting commits that we have already seen
  gitk: Fix bug where arcs could get lost
  gitk: Handle updating with path limiting better
  gitk: Fix problems with target row stuff
  gitk: Don't filter view arguments through git rev-parse
  gitk: Correct a few strings and comments to say "git log"
  gitk: Fix some corner cases in computing vrowmod and displayorder
  gitk: Avoid a crash in selectline if commitinfo($id) isn't set
  gitk: Fix problem with target row not being in scroll region
  gitk: Reorganize processing of arguments for git log
  gitk: Fix handling of tree file list with special chars in names
  gitk: Make updates go faster
  gitk: Synchronize highlighting in file view for 'f' and 'b' commands
  gitk: Show current row number and total number of rows
  gitk: Add a progress bar for checking out a head

Peter Karlsson (1):
  gitk: Initial Swedish translation.

Santiago Gala (1):
  gitk: Spanish translation of gitk

Shawn O. Pearce (3):
  git-gui: Don't use '$$cr master' with aspell earlier than 0.60
  git-gui: Setup branch.remote,merge for shorthand git-pull
  git-gui: Delete branches with 'git branch -D' to clear config

Steffen Prohaska (4):
  t0050: Test autodetect core.ignorecase
  t0050: Set core.ignorecase case to activate case insensitivity
  t0050: Add test for case insensitive add
  t0050: Fix merge test on case sensitive file systems

Stephen R. van den Berg (1):
  Simplify and fix --first-parent implementation

Teemu Likonen (1):
  Documentation/git-web--browse.txt: fix small typo

Thomas Arcila (1):
  gitk: Allow users to view diffs in external diff viewer

Trent Piepho (1):
  cvsexportcommit: Create config option for CVS dir
