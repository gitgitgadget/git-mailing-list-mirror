From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2010, #02; Sun, 07)
Date: Sun, 07 Feb 2010 18:19:00 -0800
Message-ID: <7vhbpswju3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 08 03:19:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeJE8-0004ui-NP
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 03:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab0BHCTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 21:19:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40768 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab0BHCTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 21:19:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E402B97EF8;
	Sun,  7 Feb 2010 21:19:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=NxtZ
	Q4shNLCBWwKolKsC205MUrA=; b=rusG+w9fBPxpeiGBNZyK62UWx7M8uy8SjesG
	mnIjIiS6tjt3XdS0nhMAF9KzoZ4GMeZMz1VP18ASbMaAs1pwfQ04HFUo43cdQXLd
	mV+Oo4WLQeeKl46LD2CDpo+oMOH+gRs9mxAqiK0F+psrLMB3b2EXWcVt3JZJUCbH
	GkOqoF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=WRP
	kWQFKKhbcQ8LxbCfT2ivM+xfe3RJOsw6xiqWNkOXtgiSa8dj72KF4CXdit7+eTVj
	3C8BmrEVGJyUpowinl2DCvGRwW10/dMAQBS9mSnfUQrWCsvjFsskLiwjsCX9hOWB
	j4U1uEv1dOl9xjbX1XMa2SlnwAKOVyLqwnOgSk0E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C84C097EF7;
	Sun,  7 Feb 2010 21:19:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C66A97EEF; Sun,  7 Feb
 2010 21:19:01 -0500 (EST)
X-master-at: 8051a030617cf7d083568cca223bdaa15052c33f
X-next-at: 2ac040d3d8b263430781e605b7b87a06cbc1e0f0
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 53ACB232-1458-11DF-86C2-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139275>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

There shouldn't be anything exciting to see here right now.  Please test
"master" branch to avoid giving regressions to end users; we are at
1.7.0-rc2 and I am hoping that we can release the 1.7.0 on the 10th.

--------------------------------------------------
[New Topics]

* sp/maint-push-sideband (2010-02-05) 6 commits
 - receive-pack: Send hook output over side band #2
 - receive-pack: Wrap status reports inside side-band-64k
 - receive-pack: Refactor how capabilities are shown to the client
 - send-pack: demultiplex a sideband stream with status data
 - run-command: support custom fd-set in async
 - run-command: Allow stderr to be a caller supplied pipe
 (this branch is used by sp/push-sideband.)

Based on 1.6.5 maintenance track

* sp/push-sideband (2010-02-05) 0 commits
 (this branch uses sp/maint-push-sideband.)

And my conflict resolution in #ifdef WINDOWS codepath (meaning: untested,
please check).

* ac/cvsimport-revision-mapping (2010-02-06) 1 commit
 - cvsimport: new -R option: generate .git/cvs-revisions mapping

* jc/maint-1.6.3-imap-send-bool-config-fix (2010-02-06) 1 commit
 - imap-send: fix longstanding configuration parser bug

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

* rs/git-dir-cleanup (2010-02-06) 2 commits
  (merged to 'next' on 2010-02-06 at ef8ab9b)
 + Resurrect "git grep --no-index"
 + setenv(GIT_DIR) clean-up

* jc/typo (2010-02-03) 1 commit
 - Typofixes outside documentation area

* jk/grep-double-dash (2010-02-06) 1 commit
  (merged to 'next' on 2010-02-07 at 2ac040d)
 + accept "git grep -- pattern"

--------------------------------------------------
[Cooking]

* jn/maint-makedepend (2010-01-26) 5 commits
 - Makefile: drop dependency on $(wildcard */*.h)
 - Makefile: clean up http-walker.o dependency rules
 - Makefile: remove wt-status.h from LIB_H
 - Makefile: make sure test helpers are rebuilt when headers change
 - Makefile: add missing header file dependencies
 (this branch is used by jn/makedepend and jn/master-makedepend.)

These look sensible clean-up that could go to maint later.

* jn/master-makedepend (2010-01-26) 0 commits
 (this branch uses jn/maint-makedepend; is used by jn/makedepend.)

This is to help merging the clean-up to "master".

* jn/makedepend (2010-01-31) 9 commits
 - Makefile: always remove .depend directories on 'make clean'
 - Makefile: tuck away generated makefile fragments in .depend
 - Teach Makefile to check header dependencies
 - Makefile: list standalone program object files in PROGRAM_OBJS
 - Makefile: lazily compute header dependencies
 - Makefile: list generated object files in OBJECTS
 - Makefile: disable default implicit rules
 - Makefile: rearrange dependency rules
 - Makefile: transport.o depends on branch.h now
 (this branch uses jn/maint-makedepend and jn/master-makedepend.)

And this is to build on top.  I don't want to touch build infrastructure
during the pre-release freeze too much to avoid the last minute hassles
that is only discovered when I try to cut RPMs; hence this will stay out
of 'master' until 1.7.0 ships.

* jc/checkout-detached (2010-01-29) 1 commit
 - Reword "detached HEAD" notification

* jc/maint-fix-test-perm (2010-01-30) 2 commits
 - lib-patch-mode.sh: Fix permission
 - t6000lib: Fix permission

* jh/gitweb-caching (2010-01-30) 1 commit
 - gitweb: Add an option to force version match

* jn/makefile-script-lib (2010-01-31) 1 commit
 - Do not install shell libraries executable

* mv/request-pull-modernize (2010-01-29) 1 commit
 - request-pull: avoid mentioning that the start point is a single commit

* cc/reset-keep (2010-01-19) 5 commits
 - reset: disallow using --keep when there are unmerged entries
 - reset: disallow "reset --keep" outside a work tree
 - Documentation: reset: describe new "--keep" option
 - reset: add test cases for "--keep" option
 - reset: add option "--keep" to "git reset"

* jh/notes (2010-01-27) 23 commits
 - builtin-notes: Add "add" subcommand for appending to note objects
 - builtin-notes: Add "list" subcommand for listing note objects
 - Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
 - builtin-notes: Add "prune" subcommand for removing notes for missing objects
 - Notes API: prune_notes(): Prune notes that belong to non-existing objects
 - t3305: Verify that removing notes triggers automatic fanout consolidation
 - builtin-notes: Add "remove" subcommand for removing existing notes
 - Teach builtin-notes to remove empty notes
 - Teach notes code to properly preserve non-notes in the notes tree
 - t3305: Verify that adding many notes with git-notes triggers increased fanout
 - t3301: Verify successful annotation of non-commits
 - Builtin-ify git-notes
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: write_notes_tree(): Store the notes tree in the database
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: remove_note(): Remove note objects from the notes tree structure
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Cosmetic fixes to notes.c

* jc/grep-author-all-match-implicit (2010-01-17) 1 commit
 - "log --author=me --grep=it" should find intersection, not union
