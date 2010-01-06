From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jan 2010, #02 draft; Wed, 06)
Date: Wed, 06 Jan 2010 14:22:20 -0800
Message-ID: <7vvdfenaar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 23:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSeGx-0005sl-V7
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 23:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821Ab0AFWW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 17:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730Ab0AFWW3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 17:22:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab0AFWW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 17:22:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 412098EB77;
	Wed,  6 Jan 2010 17:22:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=44se
	q2/AWhH4NPfarH+HEF0TIw8=; b=N38Q3dAekvtXHjgyBzlHm0ScZzvM5LwmyhEO
	LLNwXoxdpXNskZ7vZxHqP7xof9cmt+7+9/l0bEUC2/iEeBUa3dP4k+DywqJm4ngy
	pyJvqIMamgCy27aw4UktZpLy/QEyjdtSFf2Z7mBjz66tnCXZ+sXyJbHtg3lcyPS6
	Rjxm1y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ZKH
	rlmD2OFNLRcQb+p+lxXg2xr2QwHGZiXdtxI9M1k+CamhIB/UXNtK7itlJ1lYaFeK
	3Huj0dY/AMu/9sDLliObrr+jV10HdaFTHru3jPiVICbRi0cMX71sP0uzzMM70PQ4
	ZKSSQPFsuXsBOdap8nLV86Uy5oZbKaQimmNev54M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6D48EB75;
	Wed,  6 Jan 2010 17:22:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 482E48EB71; Wed,  6 Jan
 2010 17:22:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6D06798-FB11-11DE-8FEA-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136303>

I am experimenting with ideas to better manage the periodic "What's
cooking" messages, and here is one of such attempt based on the current
draft of the upcoming "2010 Jan, issue #02".

This is an incremental update (the full version will follow shortly) that
shows the changes since the previous issue, and was generated with a
custom diff driver.  One of the things to notice is that the ones that
only moved across sections (e.g. bg/maint-remote-update-default) without
any other changes are shown without the list of commits.

----------------------------------------------------------------

-What's cooking in git.git (Jan 2010, #01; Mon, 04)
+What's cooking in git.git (Jan 2010, #02 draft; Wed, 06)

--------------------------------------------------
Born topics

[New Topics]

 * jc/maint-1.6.1-checkout-m-custom-merge (2010-01-06) 1 commit
  - checkout -m path: fix recreating conflicts

 * jn/makefile (2010-01-06) 4 commits
  - Makefile: consolidate .FORCE-* targets
  - Makefile: learn to generate listings for targets requiring special flags
  - Makefile: use target-specific variable to pass flags to cc
  - Makefile: regenerate assembler listings when asked

--------------------------------------------------
Moved from [New Topics] to [Cooking]

 * da/difftool (2009-12-22) 2 commits
- - git-difftool: Add '--gui' for selecting a GUI tool
- - t7800-difftool: Set a bogus tool for use by tests
+  (merged to 'next' on 2010-01-06 at e957395)
+ + git-difftool: Add '--gui' for selecting a GUI tool
+ + t7800-difftool: Set a bogus tool for use by tests

 * jh/gitweb-cached (2010-01-03) 4 commits
  - gitweb: Makefile improvements
  - gitweb: Optionally add "git" links in project list page
  - gitweb: Add option to force version match
  - gitweb: Load checking
+
+Will merge to 'next', unless I hear objections within a few days.

 * tc/test-locate-httpd (2010-01-02) 1 commit
- - t/lib-http.sh: Restructure finding of default httpd location
+  (merged to 'next' on 2010-01-06 at 9d913e5)
+ + t/lib-http.sh: Restructure finding of default httpd location

 * jc/fix-tree-walk (2009-09-14) 7 commits
-Resurrected from "Ejected" category.
+Resurrected from "Ejected" category.  This is fix for a tricky codepath
+and testing and improving before it hits 'next' by brave souls is greatly
+appreciated.  I am not very happy about the solution myself.

--------------------------------------------------
Moved from [Cooking] to [Will graduate after a bit more cooking]

 * bg/maint-remote-update-default (2009-12-31) 1 commit

 * jk/maint-1.6.5-reset-hard (2009-12-30) 1 commit

 * jk/push-to-delete (2009-12-30) 1 commit

 * mm/config-path (2009-12-30) 1 commit

 * pm/cvs-environ (2009-12-30) 1 commit

 * so/cvsserver-update (2009-12-07) 1 commit

 * tr/maint-1.6.5-bash-prompt-show-submodule-changes (2009-12-31) 1 commit

 * js/filter-branch-prime (2009-12-15) 1 commit

 * mg/tag-d-show (2009-12-10) 1 commit

 * sb/maint-octopus (2009-12-11) 3 commits

 * bg/maint-add-all-doc (2009-12-07) 4 commits

 * mv/commit-date (2009-12-03) 2 commits

 * mo/bin-wrappers (2009-12-02) 3 commits

 * tr/http-updates (2009-12-28) 4 commits

 * nd/sparse (2009-12-30) 23 commits

--------------------------------------------------
Other topics

[Cooking]

-* cc/reset-more (2010-01-04) 6 commits
+* cc/reset-more (2010-01-05) 7 commits
+  (merged to 'next' on 2010-01-06 at 96639cb)
+ + Documentation: reset: add some missing tables
   (merged to 'next' on 2010-01-04 at 8802c2c)
  + Fix bit assignment for CE_CONFLICTED
   (merged to 'next' on 2010-01-03 at f83d4c6)
  + "reset --merge": fix unmerged case
  + reset: use "unpack_trees()" directly instead of "git read-tree"
  + reset: add a few tests for "git reset --merge"
  + Documentation: reset: add some tables to describe the different options
  + reset: improve mixed reset error message when in a bare repo

 * jc/branch-d (2009-12-29) 1 commit
  - branch -d: base the "already-merged" safety on the branch it merges with
+
+http://thread.gmane.org/gmane.comp.version-control.git/135837/focus=135863
+I am tempted to merge this to 'next', but please stop me if people see issues
+in it.

 * jk/run-command-use-shell (2010-01-01) 8 commits
  - t4030, t4031: work around bogus MSYS bash path conversion
- - t0021: use $SHELL_PATH for the filter script
  - diff: run external diff helper with shell
  - textconv: use shell to run helper
  - editor: use run_command's shell feature
  - run-command: optimize out useless shell calls
  - run-command: convert simple callsites to use_shell
+ - t0021: use $SHELL_PATH for the filter script
  - run-command: add "use shell" option
 
-   Xref: news.gmane.org gmane.comp.version-control.git:136128
-   * check t0021: drop one to t4030;
-   * reorder and move t0021 up, immediately after run-command: optimize
+Shuffled the commits in the topic, following J6t's suggestion in
+http://thread.gmane.org/gmane.comp.version-control.git/136128

 * tc/clone-v-progress (2009-12-26) 4 commits
  - clone: use --progress to force progress reporting
  - clone: set transport->verbose when -v/--verbose is used
  - git-clone.txt: reword description of progress behaviour
  - check stderr with isatty() instead of stdout when deciding to show progress
+
+Perhaps needs an entry in the Release Notes, but otherwise looked Ok.

 * tc/smart-http-restrict (2010-01-02) 4 commits
- - Smart-http tests: Test http-backend without curl or a webserver
- - Smart-http tests: Break test t5560-http-backend into pieces
- - Smart-http tests: Improve coverage in test t5560
- - Smart-http: check if repository is OK to export before serving it
+  (merged to 'next' on 2010-01-06 at 82736cb)
+ + Smart-http tests: Test http-backend without curl or a webserver
+ + Smart-http tests: Break test t5560-http-backend into pieces
+ + Smart-http tests: Improve coverage in test t5560
+ + Smart-http: check if repository is OK to export before serving it

 * jc/cache-unmerge (2009-12-25) 9 commits
  - rerere forget path: forget recorded resolution
  - rerere: refactor rerere logic to make it independent from I/O
  - rerere: remove silly 1024-byte line limit
  - resolve-undo: teach "update-index --unresolve" to use resolve-undo info
  - resolve-undo: "checkout -m path" uses resolve-undo information
  - resolve-undo: allow plumbing to clear the information
  - resolve-undo: basic tests
  - resolve-undo: record resolved conflicts in a new index extension section
  - builtin-merge.c: use standard active_cache macros
+
+Will wait a bit more before moving it to 'next'.

 * jh/commit-status (2009-12-07) 1 commit
  - [test?] Add commit.status, --status, and --no-status
+
+Needs tests.

 * jc/checkout-merge-base (2009-11-20) 2 commits
   (merged to 'next' on 2010-01-02 at 6a8f6fc)
  + "rebase --onto A...B" replays history on the merge base between A and B
  + "checkout A...B" switches to the merge base between A and B
+
+Users of "rebase -i" might want to teach this to the command.  Volunteers?

 * tr/http-push-ref-status (2009-12-24) 6 commits
  - transport-helper.c::push_refs(): emit "no refs" error message
  - transport-helper.c::push_refs(): ignore helper-reported status if ref is not to be pushed
  - transport.c::transport_push(): make ref status affect return value
  - refactor ref status logic for pushing
  - t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
  - t5541-http-push.sh: add tests for non-fast-forward pushes
+
+Peff: $gmane/136169, 136167, 136168
+RC: $gmane/136172

 * il/vcs-helper (2009-12-09) 8 commits
- - Remove special casing of http, https and ftp
- - Support remote archive from all smart transports
- - Support remote helpers implementing smart transports
- - Support taking over transports
- - Refactor git transport options parsing
- - Pass unknown protocols to external protocol handlers
- - Support mandatory capabilities
- - Add remote helper debug mode
+  (merged to 'next' on 2010-01-06 at 7c79f42)
+ + Remove special casing of http, https and ftp
+ + Support remote archive from all smart transports
+ + Support remote helpers implementing smart transports
+ + Support taking over transports
+ + Refactor git transport options parsing
+ + Pass unknown protocols to external protocol handlers
+ + Support mandatory capabilities
+ + Add remote helper debug mode

 * mm/diag-path-in-treeish (2009-12-07) 1 commit
- - Detailed diagnosis when parsing an object name fails.
+  (merged to 'next' on 2010-01-06 at 6b4201e)
+ + Detailed diagnosis when parsing an object name fails.

 * mh/rebase-fixup (2009-12-07) 2 commits
- - Add a command "fixup" to rebase --interactive
- - t3404: Use test_commit to set up test repository
+  (merged to 'next' on 2010-01-06 at c4779a7)
+ + Add a command "fixup" to rebase --interactive
+ + t3404: Use test_commit to set up test repository
  (this branch is used by ns/rebase-auto-squash.)
 

 * ns/rebase-auto-squash (2009-12-08) 2 commits
- - fixup! rebase -i --autosquash
- - rebase -i --autosquash: auto-squash commits
+  (merged to 'next' on 2010-01-06 at 91913ca)
+ + fixup! rebase -i --autosquash
+ + rebase -i --autosquash: auto-squash commits
  (this branch uses mh/rebase-fixup.)

 * jh/notes (2009-12-07) 11 commits
  - Refactor notes concatenation into a flexible interface for combining notes
  - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
  - Notes API: for_each_note(): Traverse the entire notes tree with a callback
  - Notes API: get_note(): Return the note annotating the given object
  - Notes API: add_note(): Add note objects to the internal notes tree structure
  - Notes API: init_notes(): Initialize the notes tree from the given notes ref
  - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
  - Minor style fixes to notes.c
   (merged to 'next' on 2010-01-02 at ae42130)
  + Add more testcases to test fast-import of notes
  + Rename t9301 to t9350, to make room for more fast-import tests
  + fast-import: Proper notes tree manipulation
+
+http://thread.gmane.org/gmane.comp.version-control.git/134738
+
+What's the status of the fourth and later patches on this topic?  Overall
+it looked reasonable, if I recall correctly what I thought when I reviewed
+it last time, and I am tempted to merge it to 'next' soonish.  Please
+file complaints before I do so if people have objections.
+
+http://mid.gmane.org/201001051231.43048.johan@herland.net Hold!

 * fc/opt-quiet-gc-reset (2009-12-02) 1 commit
- - General --quiet improvements
+  (merged to 'next' on 2010-01-06 at 03e00cd)
+ + General --quiet improvements

 * sr/gfi-options (2009-12-04) 7 commits
  - fast-import: add (non-)relative-marks feature
  - fast-import: allow for multiple --import-marks= arguments
  - fast-import: test the new option command
  - fast-import: add option command
  - fast-import: add feature command
  - fast-import: put marks reading in its own function
  - fast-import: put option parsing code in separate functions
+
+http://thread.gmane.org/gmane.comp.version-control.git/134540
+
+I haven't seen comments on this round, and I am tempted to merge it to
+'next' soonish.  Please file complaints before I do so if people have
+objections.
