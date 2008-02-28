From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 27 Feb 2008 16:43:21 -0800
Message-ID: <7vablloqqe.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
 <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 01:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWsn-00077N-Q1
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758407AbYB1Ani (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758926AbYB1Anh
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:43:37 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758346AbYB1Ang (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:43:36 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A9B2725BC;
	Wed, 27 Feb 2008 19:43:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6C0E425BA; Wed, 27 Feb 2008 19:43:29 -0500 (EST)
X-maint-at: 0f497e75f05cdf0c0c1278eaba898cda6f118d71
X-master-at: 6d21667206c4c2b10aad99eca1530a4f17c4e61d
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75333>

For the next maintenance release v1.5.4.4, I made a few
cherry-picks from 'master' and also a merge down of a topic
branch that has been cooking there, to 'maint'.

On the 'master' front, many topics have been merged.  With a few
more topics that are still in 'next', we are pretty much done
feature-wise for the next feature release v1.5.5.

----------------------------------------------------------------
* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (1):
  builtin-reflog.c: don't install new reflog on write failure

Bryan Donlan (1):
  Documentation/git-am.txt: Pass -r in the example invocation of rm -f
    .dotest

Caio Marcelo de Oliveira Filho (1):
  filter-branch documentation: non-zero exit status in command abort the
    filter

Carl Worth (1):
  Eliminate confusing "won't bisect on seeked tree" failure

Daniel Barkalow (2):
  Use a single implementation and API for copy_file()
  Don't use GIT_CONFIG in t5505-remote

Jay Soffian (2):
  rev-parse: fix potential bus error with --parseopt option spec handling
  send-email: fix In-Reply-To regression

Johan Herland (2):
  Add testcase for 'git cvsexportcommit -w $cvsdir ...' with relative
    $GIT_DIR
  Fix 'git cvsexportcommit -w $cvsdir ...' when used with relative $GIT_DIR

Johannes Schindelin (3):
  http-push: avoid invalid memory accesses
  http-push: do not get confused by submodules
  http-push: avoid a needless goto

Jonathan del Strother (1):
  Prompt to continue when editing during rebase --interactive

Miklos Vajna (2):
  Documentation/git-filter-branch: add a new msg-filter example
  Documentation/git svn log: add a note about timezones.

Steven Drake (1):
  timezone_names[]: fixed the tz offset for New Zealand.


----------------------------------------------------------------
* The 'master' branch has these since the last announcement
  in addition to the above.

Alexandre Julliard (1):
  git.el: Do not display empty directories.

Andreas Ericsson (1):
  pack-objects: Add runtime detection of online CPU's

Brandon Casey (2):
  builtin-reflog.c: don't install new reflog on write failure
  pack-objects: Print a message describing the number of threads for packing

Carl Worth (1):
  Eliminate confusing "won't bisect on seeked tree" failure

Daniel Barkalow (26):
  Allow callers of unpack_trees() to handle failure
  Add flag to make unpack_trees() not print errors.
  Send unpack-trees debugging output to stderr
  Discard "deleted" cache entries after using them to update the working tree
  Add "skip_unmerged" option to unpack_trees.
  Build-in merge-recursive
  Move create_branch into a library file
  Use diff -u instead of diff in t7201
  Library function to check for unmerged index entries
  Move code to clean up after a branch change to branch.c
  Build in checkout
  Clean up reporting differences on branch switch
  Add more tests for format-patch
  Improve message-id generation flow control for format-patch
  Export some email and pretty-printing functions
  Use ALLOC_GROW in remote.{c,h}
  Add a --cover-letter option to format-patch
  Add tests for extra headers in format-patch
  Fix format.headers not ending with a newline
  Combine To: and Cc: headers
  Support a --cc=<email> option in format-patch
  Resolve value supplied for no-colon push refspecs
  builtin-checkout.c: Remove unused prefix arguments in switch_branches path
  Add support for url aliases in config files
  Add API access to shortlog
  Improve collection of information for format-patch --cover-letter

Gerrit Pape (1):
  hash-object: cleanup handling of command line options

Jakub Narebski (2):
  gitweb: Better cutting matched string and its context
  Add '--fixed-strings' option to "git log --grep" and friends

Jay Soffian (3):
  builtin-checkout.c: fix possible usage segfault
  branch: optionally setup branch.*.merge from upstream local branches
  doc: documentation update for the branch track changes

Jeff King (3):
  help: use parseopt
  make alias lookup a public, procedural function
  help: respect aliases

Jim Meyering (1):
  Avoid unnecessary "if-before-free" tests.

Johannes Schindelin (2):
  xdl_merge(): make XDL_MERGE_ZEALOUS output simpler
  xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM

Johannes Sixt (2):
  start_command(), .in/.out/.err = -1: Callers must close the file descriptor
  start_command(), if .in/.out > 0, closes file descriptors, not the callers

Junio C Hamano (12):
  diff --relative: output paths as relative to the current subdirectory
  diff --relative: help working in a bare repository
  checkout: notice when the switched branch is behind or forked
  checkout: tone down the "forked status" diagnostic messages
  checkout: work from a subdirectory
  checkout: updates to tracking report
  Add merge-subtree back
  checkout: show progress when checkout takes long time while switching
    branches
  checkout: error out when index is unmerged even with -m
  url rewriting: take longest and first match
  git-apply --whitespace=fix: fix off by one thinko
  Revert "pack-objects: Print a message describing the number of threads
    for packing"

Sebastian Noack (1):
  git-svn: Don't prompt for client cert password everytime.

Shawn O. Pearce (5):
  Optimize peel_ref for the current ref of a for_each_ref callback
  Teach git-describe to use peeled ref information when scanning tags
  Avoid accessing non-tag refs in git-describe unless --all is requested
  Teach git-describe --exact-match to avoid expensive tag searches
  Use git-describe --exact-match in bash prompt on detached HEAD

Simon Hausmann (4):
  git-p4: Remove --log-substitutions feature.
  git-p4: Clean up git-p4 submit's log message handling.
  git-p4: Removed git-p4 submit --direct.
  git-p4: git-p4 submit cleanups.

Steffen Prohaska (2):
  t4014: Replace sed's non-standard 'Q' by standard 'q'
  Add tests for filesystem challenges (case and unicode normalization)

Tommy Thorn (1):
  git-p4: support exclude paths

Tor Arvid Lund (1):
  git-p4: Support usage of perforce client spec
