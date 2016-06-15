From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2014, #01; Tue, 3)
Date: Tue, 03 Jun 2014 15:16:13 -0700
Message-ID: <xmqqzjhtvdua.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 00:16:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrx0R-0004tR-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jun 2014 00:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965676AbaFCWQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 18:16:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64454 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965672AbaFCWQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 18:16:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 21F6F1DD3A;
	Tue,  3 Jun 2014 18:16:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=g
	M/5gkpSqSV0j9eaCZ7Xxft0CHQ=; b=D9hYyZaAX7Yva7BMxmxchiAgLsyXAGsEk
	giinNg0CUbaeYULqwkbbaCfVAVY33dqtOznMjYMg/NFpd40RdIgcL3iIyRJX4gVW
	dRhWycPa29VJLdoDy9+n9xxPUv3MREfFurxCJzJazawYT21kVWJknZ/t39RGE6vx
	oJ/lFEu6qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=k88
	q9+7pfi/fC/QC3EeaT7+raIKFEhttjFTgZzd42vGb80ooHpHQVybjKXSxwgmqyln
	2vX0TRkIZC2Q/blzd+/atN4MiwbSQQGJuHG3Yp8Y/h4yWG51bz4HQ8pLFahmNy3f
	CzfOwspWzYmz0fb4Y2q1XVwC9laghIFaFwc7lj2M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16DF11DD39;
	Tue,  3 Jun 2014 18:16:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ECD591DD33;
	Tue,  3 Jun 2014 18:16:14 -0400 (EDT)
X-master-at: 79dcccc503ac228630ecf15dcf8e1d9455daef2d
X-next-at: cc83a7f2654514ddbeb91a63300d3b726f6df536
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD6CBFC0-EB6C-11E3-AE81-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250694>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The first batch of topics, all of which have been cooking for quite
a while on the 'next' branch, have been merged to 'master'.  I'll

 - merge another batch to 'master', then
 - rewind the tip of 'next' in preparation to start accepting new topics

sometime mid-next week.  I'll also update tinyurl.com/gitCal for this
cycle soonish.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[Graduated to "master"]

* as/grep-fullname-config (2014-03-20) 1 commit
  (merged to 'next' on 2014-03-28 at 810a076)
 + grep: add grep.fullName config variable

 Add a configuration variable to force --full-name to be default for
 "git grep".

 This may cause regressions on scripted users that do not expect
 this new behaviour.


* bg/strbuf-trim (2014-05-06) 2 commits
  (merged to 'next' on 2014-05-07 at 978f378)
 + api-strbuf.txt: add docs for _trim and _ltrim
 + strbuf: use _rtrim and _ltrim in strbuf_trim


* dt/api-doc-setup-gently (2014-04-30) 1 commit
  (merged to 'next' on 2014-05-07 at 6054b08)
 + docs: document RUN_SETUP_GENTLY and clarify RUN_SETUP


* ef/send-email-absolute-path-to-the-command (2014-04-23) 2 commits
  (merged to 'next' on 2014-04-23 at a657e5e)
 + send-email: windows drive prefix (e.g. C:) appears only at the beginning
  (merged to 'next' on 2014-04-21 at 43bebb5)
 + send-email: recognize absolute path on Windows


* ep/shell-command-substitution (2014-04-30) 41 commits
  (merged to 'next' on 2014-05-07 at e9952c7)
 + t5000-tar-tree.sh: use the $( ... ) construct for command substitution
 + t4204-patch-id.sh: use the $( ... ) construct for command substitution
 + t4119-apply-config.sh: use the $( ... ) construct for command substitution
 + t4116-apply-reverse.sh: use the $( ... ) construct for command substitution
 + t4057-diff-combined-paths.sh: use the $( ... ) construct for command substitution
 + t4038-diff-combined.sh: use the $( ... ) construct for command substitution
 + t4036-format-patch-signer-mime.sh: use the $( ... ) construct for command substitution
 + t4014-format-patch.sh: use the $( ... ) construct for command substitution
 + t4013-diff-various.sh: use the $( ... ) construct for command substitution
 + t4012-diff-binary.sh: use the $( ... ) construct for command substitution
 + t4010-diff-pathspec.sh: use the $( ... ) construct for command substitution
 + t4006-diff-mode.sh: use the $( ... ) construct for command substitution
 + t3910-mac-os-precompose.sh: use the $( ... ) construct for command substitution
 + t3905-stash-include-untracked.sh: use the $( ... ) construct for command substitution
 + t1050-large.sh: use the $( ... ) construct for command substitution
 + t1020-subdirectory.sh: use the $( ... ) construct for command substitution
 + t1004-read-tree-m-u-wf.sh: use the $( ... ) construct for command substitution
 + t1003-read-tree-prefix.sh: use the $( ... ) construct for command substitution
 + t1002-read-tree-m-u-2way.sh: use the $( ... ) construct for command substitution
 + t1001-read-tree-m-2way.sh: use the $( ... ) construct for command substitution
 + t1000-read-tree-m-3way.sh: use the $( ... ) construct for command substitution
 + t0300-credentials.sh: use the $( ... ) construct for command substitution
 + t0030-stripspace.sh: use the $( ... ) construct for command substitution
 + t0026-eol-config.sh: use the $( ... ) construct for command substitution
 + t0025-crlf-auto.sh: use the $( ... ) construct for command substitution
 + t0020-crlf.sh: use the $( ... ) construct for command substitution
 + t0010-racy-git.sh: use the $( ... ) construct for command substitution
 + t0001-init.sh: use the $( ... ) construct for command substitution
 + p5302-pack-index.sh: use the $( ... ) construct for command substitution
 + lib-gpg.sh: use the $( ... ) construct for command substitution
 + lib-cvs.sh: use the $( ... ) construct for command substitution
 + lib-credential.sh: use the $( ... ) construct for command substitution
 + git-web--browse.sh: use the $( ... ) construct for command substitution
 + git-stash.sh: use the $( ... ) construct for command substitution
 + git-rebase.sh: use the $( ... ) construct for command substitution
 + git-rebase--merge.sh: use the $( ... ) construct for command substitution
 + git-pull.sh: use the $( ... ) construct for command substitution
 + appp.sh: use the $( ... ) construct for command substitution
 + t7900-subtree.sh: use the $( ... ) construct for command substitution
 + test-gitmw-lib.sh: use the $( ... ) construct for command substitution
 + t9365-continuing-queries.sh: use the $( ... ) construct for command substitution

 Adjust shell scripts to use $(cmd) instead of `cmd`.


* ew/config-protect-mode (2014-05-06) 1 commit
  (merged to 'next' on 2014-05-07 at 8443093)
 + config: preserve config file permissions on edits


* fc/merge-default-to-upstream (2014-04-22) 1 commit
  (merged to 'next' on 2014-04-22 at 4f98483)
 + merge: enable defaulttoupstream by default

 "git merge" without argument, even when there is an upstream
 defined for the current branch, refused to run until
 merge.defaultToUpstream is set to true. Flip the default of that
 configuration variable to true.


* fc/mergetool-prompt (2014-04-24) 2 commits
  (merged to 'next' on 2014-05-02 at a554691)
 + mergetool: document the default for --[no-]prompt
  (merged to 'next' on 2014-04-22 at dcaec94)
 + mergetool: run prompt only if guessed tool

 mergetool.prompt used to default to 'true', always causing a confirmation
 "do you really want to run the tool on this path" to be shown.

 Among the two purposes the prompt serves, ignore the use case to
 confirm that the user wants to view particular path with the named
 tool, and make the prompt only to confirm the choice of the tool
 made by autodetection and defaulting.  For those who configured the
 tool explicitly, the prompt shown for the latter purpose is simply
 annoying.

 Strictly speaking, this is a backward incompatible change and the
 users need to explicitly set the variable to 'true' if they want to
 resurrect the now-ignored use case.


* fc/mergetools-vimdiff3 (2014-04-22) 1 commit
  (merged to 'next' on 2014-04-22 at d843e75)
 + mergetools: add vimdiff3 mode


* fc/rerere-conflict-style (2014-04-30) 1 commit
  (merged to 'next' on 2014-05-07 at bde7fd0)
 + rerere: fix for merge.conflictstyle

 "git rerere forget" did not work well when merge.conflictstyle
 was set to a non-default value.


* jc/apply-ignore-whitespace (2014-03-26) 1 commit
  (merged to 'next' on 2014-04-04 at 53779a7)
 + apply --ignore-space-change: lines with and without leading whitespaces do not match

 "--ignore-space-change" option of "git apply" ignored the
 spaces at the beginning of line too aggressively, which is
 inconsistent with the option of the same name "diff" and "git diff"
 have.


* jk/commit-date-approxidate (2014-05-02) 4 commits
  (merged to 'next' on 2014-05-07 at 7ec8f7d)
 + commit: accept more date formats for "--date"
 + commit: print "Date" line when the user has set date
 + pretty: make show_ident_date public
 + commit: use split_ident_line to compare author/committer

 "git commit --date=<date>" option learned to read from more
 timestamp formats, including "--date=now".


* jk/external-diff-use-argv-array (2014-04-21) 5 commits
  (merged to 'next' on 2014-04-22 at e6d92d7)
 + run_external_diff: refactor cmdline setup logic
 + run_external_diff: hoist common bits out of conditional
 + run_external_diff: drop fflush(NULL)
 + run_external_diff: clean up error handling
 + run_external_diff: use an argv_array for the environment

 Code clean-up (and a bugfix which has been merged for 2.0).


* jx/blame-align-relative-time (2014-04-23) 2 commits
  (merged to 'next' on 2014-04-23 at 858df39)
 + blame: dynamic blame_date_width for different locales
 + blame: fix broken time_buf paddings in relative timestamp

 "git blame" miscounted number of columns needed to show localized
 timestamps, resulting in jaggy left-side-edge of the source code
 lines in its output.


* ks/tree-diff-nway (2014-04-09) 20 commits
  (merged to 'next' on 2014-04-09 at c17228e)
 + mingw: activate alloca
  (merged to 'next' on 2014-04-08 at 6b74773)
 + combine-diff: speed it up, by using multiparent diff tree-walker directly
 + tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
 + Portable alloca for Git
  (merged to 'next' on 2014-03-31 at 16a7bd4)
 + tree-diff: reuse base str(buf) memory on sub-tree recursion
 + tree-diff: no need to call "full" diff_tree_sha1 from show_path()
 + tree-diff: rework diff_tree interface to be sha1 based
 + tree-diff: diff_tree() should now be static
 + tree-diff: remove special-case diff-emitting code for empty-tree cases
  (merged to 'next' on 2014-03-25 at cfcbdac)
 + tree-diff: simplify tree_entry_pathcmp
 + tree-diff: show_path prototype is not needed anymore
 + tree-diff: rename compare_tree_entry -> tree_entry_pathcmp
 + tree-diff: move all action-taking code out of compare_tree_entry()
 + tree-diff: don't assume compare_tree_entry() returns -1,0,1
  (merged to 'next' on 2014-03-21 at d872679)
 + tree-diff: consolidate code for emitting diffs and recursion in one place
 + tree-diff: show_tree() is not needed
 + tree-diff: no need to pass match to skip_uninteresting()
 + tree-diff: no need to manually verify that there is no mode change for a path
 + combine-diff: move changed-paths scanning logic into its own function
 + combine-diff: move show_log_first logic/action out of paths scanning

 Instead of running N pair-wise diff-trees when inspecting a
 N-parent merge, find the set of paths that were touched by walking
 N+1 trees in parallel.  These set of paths can then be turned into
 N pair-wise diff-tree results to be processed through rename
 detections and such.  And N=2 case nicely degenerates to the usual
 2-way diff-tree, which is very nice.


* lr/git-run-setup-gently (2014-04-22) 1 commit
  (merged to 'next' on 2014-04-22 at 5c2523f)
 + git.c: treat RUN_SETUP_GENTLY and RUN_SETUP as mutually exclusive


* mh/ref-transaction (2014-04-07) 27 commits
  (merged to 'next' on 2014-04-16 at a99f84d)
 + ref_transaction_commit(): work with transaction->updates in place
 + struct ref_update: add a type field
 + struct ref_update: add a lock field
 + ref_transaction_commit(): simplify code using temporary variables
 + struct ref_update: store refname as a FLEX_ARRAY
 + struct ref_update: rename field "ref_name" to "refname"
 + refs: remove API function update_refs()
 + update-ref --stdin: reimplement using reference transactions
 + refs: add a concept of a reference transaction
 + update-ref --stdin: harmonize error messages
 + update-ref --stdin: improve the error message for unexpected EOF
 + t1400: test one mistake at a time
 + update-ref --stdin -z: deprecate interpreting the empty string as zeros
 + update-ref.c: extract a new function, parse_next_sha1()
 + t1400: test that stdin -z update treats empty <newvalue> as zeros
 + update-ref --stdin: simplify error messages for missing oldvalues
 + update-ref --stdin: make error messages more consistent
 + update-ref --stdin: improve error messages for invalid values
 + update-ref.c: extract a new function, parse_refname()
 + parse_cmd_verify(): copy old_sha1 instead of evaluating <oldvalue> twice
 + update-ref --stdin: read the whole input at once
 + update_refs(): fix constness
 + refs.h: rename the action_on_err constants
 + t1400: add some more tests involving quoted arguments
 + parse_arg(): really test that argument is properly terminated
 + t1400: provide more usual input to the command
 + t1400: fix name and expected result of one test

 Update "update-ref --stdin [-z]" and then introduce a transactional
 support for (multi-)reference updates.


* mm/mediawiki-encoding-fix (2014-04-23) 2 commits
  (merged to 'next' on 2014-05-02 at 7744361)
 + git-remote-mediawiki: fix encoding issue for UTF-8 media files
 + git-remote-mediawiki: allow stop/start-ing the test server


* nd/index-pack-one-fd-per-thread (2014-04-16) 1 commit
  (merged to 'next' on 2014-04-16 at b38d5a9)
 + index-pack: work around thread-unsafe pread()

 Enable threaded index-pack on platforms without thread-safe
 pread() emulation.


* rs/ref-update-check-errors-early (2014-04-17) 2 commits
  (merged to 'next' on 2014-04-21 at acc62aa)
 + commit.c: check for lock error and return early
 + sequencer.c: check for lock failure and bail early in fast_forward_to


* sk/msvc-dynlink-crt (2014-05-06) 1 commit
  (merged to 'next' on 2014-05-07 at 20f4839)
 + MSVC: link dynamically to the CRT


* sk/svn-parse-datestamp (2014-04-17) 1 commit
  (merged to 'next' on 2014-04-21 at 5ff519f)
 + SVN.pm::parse_svn_date: allow timestamps with a single-digit hour

 "git svn" learned to cope with malformed timestamps with only one
 digit in the hour part, e.g. 2014-01-07T5:01:02.048176Z, emitted
 by some broken subversion server implementations.


* sk/tag-contains-wo-recursion (2014-04-25) 1 commit
  (merged to 'next' on 2014-04-25 at f320750)
 + git tag --contains: avoid stack overflow


* ym/fix-opportunistic-index-update-race (2014-04-10) 2 commits
  (merged to 'next' on 2014-04-16 at cb92f4f)
 + read-cache.c: verify index file before we opportunistically update it
 + wrapper.c: add xpread() similar to xread()

 Read-only operations such as "git status" that internally refreshes
 the index write out the refreshed index to the disk to optimize
 future accesses to the working tree, but this could race with a
 "read-write" operation that modify the index while it is running.
 Detect such a race and avoid overwriting the index.

 Duy raised a good point that we may need to do the same for the
 normal writeout codepath, not just the "opportunistic" update
 codepath.  While that is true, nobody sane would be running two
 simultaneous operations that are clearly write-oriented competing
 with each other against the same index file.  So in that sense that
 can be done as a less urgent follow-up for this topic.

--------------------------------------------------
[New Topics]

* bg/xcalloc-nmemb-then-size (2014-05-27) 12 commits
 - transport-helper.c: rearrange xcalloc arguments
 - remote.c: rearrange xcalloc arguments
 - reflog-walk.c: rearrange xcalloc arguments
 - pack-revindex.c: rearrange xcalloc arguments
 - notes.c: rearrange xcalloc arguments
 - imap-send.c: rearrange xcalloc arguments
 - http-push.c: rearrange xcalloc arguments
 - diff.c: rearrange xcalloc arguments
 - config.c: rearrange xcalloc arguments
 - commit.c: rearrange xcalloc arguments
 - builtin/remote.c: rearrange xcalloc arguments
 - builtin/ls-remote.c: rearrange xcalloc arguments

 Like calloc(3), xcalloc() takes nmemb and then size.

 Will merge to 'next'.


* jk/complete-merge-pull (2014-05-27) 2 commits
 - completion: add missing options for git-merge
 - completion: add a note that merge options are shared

 The completion code did not know about quite a few options that are
 common between "git merge" and "git pull", and a couple of options
 unique to "git merge".

 Will merge to 'next'.


* jl/remote-rm-prune (2014-05-27) 3 commits
 - remote prune: optimize "dangling symref" check/warning
 - remote: repack packed-refs once when deleting multiple refs
 - remote rm: delete remote configuration as the last

 "git remote rm" and "git remote prune" can involve removing many
 refs at once, which is not a very efficient thing to do when very
 many refs exist in the packed-refs file.

 Will merge to 'next'.


* jm/instaweb-apache-24 (2014-05-27) 1 commit
 - git-instaweb: add support for Apache 2.4

 Will merge to 'next'.


* jm/t9138-style-fix (2014-05-27) 1 commit
 - t9138-git-svn-authors-prog.sh fixups

 Will merge to 'next'.


* mc/git-p4-pre-are-p4-only (2014-05-27) 1 commit
  (merged to 'next' on 2014-05-27 at 71572fe)
 + git-p4: Do not include diff in spec file when just preparing p4

 Will merge to 'master'.


* nd/daemonize-gc (2014-05-27) 1 commit
 - gc --auto: do not lock refs in the background

 Will merge to 'next'.


* ow/config-mailmap-pathname (2014-05-27) 1 commit
 - config: respect '~' and '~user' in mailmap.file

 Will merge to 'next'.


* rh/prompt-tests (2014-05-30) 10 commits
 - t9904: new __git_ps1 tests for Zsh
 - lib-prompt-tests.sh: add variable for string that encodes percent in PS1
 - lib-prompt-tests.sh: put all tests inside a function
 - t9903: move prompt tests to a new lib-prompt-tests.sh file
 - t9903: move PS1 color code variable definitions to lib-bash.sh
 - t9903: include "Bash" in test names via new $shellname var
 - t9903: run pc mode tests again with PS1 expansion disabled
 - t9903: move test name prefix to a separate variable
 - t9903: put the Bash pc mode prompt test cases in a function
 - t9903: remove Zsh test from the suite of Bash prompt tests

 Will merge to 'next'.


* jm/doc-wording-tweaks (2014-05-28) 1 commit
 - Documentation: wording fixes in the user manual and glossary

 Will merge to 'next'.


* jn/gitweb-utf8-in-links (2014-05-27) 1 commit
 - gitweb: Harden UTF-8 handling in generated links

 Will merge to 'next'.


* mn/sideband-no-ansi (2014-06-02) 1 commit
 - sideband.c: do not use ANSI control sequence on non-terminal

 Will merge to 'next'.


* jc/fetch-push-refmap (2014-06-02) 9 commits
 - fetch: allow explicit --refmap to override configuration
 - fetch doc: add a section on configured remote-tracking branches
 - fetch doc: remove "short-cut" section
 - fetch doc: update refspec format description
 - fetch doc: on pulling multiple refspecs
 - fetch doc: remove notes on outdated "mixed layout"
 - fetch doc: update note on '+' in front of the refspec
 - fetch doc: move FETCH_HEAD material lower and add an example
 - fetch doc: update introductory part for clarity


* jc/shortlog-ref-exclude (2014-05-30) 1 commit
 - shortlog: allow --exclude=<glob> to be passed

 Needs rewording the proposed log message ($gmane/250469, 250475).


* lt/log-auto-decorate (2014-05-30) 1 commit
 - git log: support "auto" decorations

 Will merge to 'next'.


* lt/request-pull (2014-06-02) 1 commit
 - fix brown paper bag breakage in t5150-request-pull.sh

 Will merge to 'next'.


* na/no-http-test-in-the-middle (2014-05-30) 1 commit
 - t5538: move http push tests out to t5542

 Will merge to 'next'.


* pb/trim-trailing-spaces (2014-06-02) 1 commit
 - dir.c:trim_trailing_spaces(): fix for " \ " sequence

 Will merge to 'next'.


* rs/mailinfo-header-cmp (2014-06-02) 1 commit
 - mailinfo: use strcmp() for string comparison

 Will merge to 'next'.


* rs/pack-objects-no-unnecessary-realloc (2014-06-02) 1 commit
 - pack-objects: use free()+xcalloc() instead of xrealloc()+memset()

 Will merge to 'next'.


* ss/userdiff-update-csharp-java (2014-06-02) 2 commits
 - userdiff: support Java try keyword
 - userdiff: support C# async methods and correct C# keywords


* jk/error-resolve-conflict-advice (2014-06-03) 2 commits
 - error_resolve_conflict: drop quotations around operation
 - error_resolve_conflict: rewrap advice message

 Will merge to 'next'.


* rs/read-ref-at (2014-06-03) 1 commit
 - refs.c: change read_ref_at to use the reflog iterators

 Will merge to 'next'.


* sh/enable-preloadindex (2014-06-03) 1 commit
 - environment.c: enable core.preloadindex by default

 Will merge to 'next'.


* ta/string-list-init (2014-06-03) 1 commit
 - string-list: Add a value to string_list initializer lists

 Will merge to 'next'.

--------------------------------------------------
[Stalled]

* jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
 - commit -m: commit staged submodules regardless of ignore config
 - status/commit: show staged submodules regardless of ignore config

 There also are a few patches Ronald Weiss and Jens are working on
 polishing around this topic, and a patch from Jens each for gitk
 and git-gui.

 Waiting for the dust to settle until picking them up all.


* mh/lockfile (2014-04-15) 25 commits
 - trim_last_path_elm(): replace last_path_elm()
 - resolve_symlink(): take a strbuf parameter
 - resolve_symlink(): use a strbuf for internal scratch space
 - change lock_file::filename into a strbuf
 - commit_lock_file(): use a strbuf to manage temporary space
 - try_merge_strategy(): use a statically-allocated lock_file object
 - try_merge_strategy(): remove redundant lock_file allocation
 - struct lock_file: declare some fields volatile
 - lockfile: avoid transitory invalid states
 - commit_lock_file(): die() if called for unlocked lockfile object
 - commit_lock_file(): inline temporary variable
 - remove_lock_file(): call rollback_lock_file()
 - lock_file(): exit early if lockfile cannot be opened
 - write_packed_entry_fn(): convert cb_data into a (const int *)
 - prepare_index(): declare return value to be (const char *)
 - delete_ref_loose(): don't muck around in the lock_file's filename
 - cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
 - lockfile.c: document the various states of lock_file objects
 - lock_file(): always add lock_file object to lock_file_list
 - hold_lock_file_for_append(): release lock on errors
 - lockfile: unlock file if lockfile permissions cannot be adjusted
 - rollback_lock_file(): set fd to -1
 - rollback_lock_file(): do not clear filename redundantly
 - api-lockfile: expand the documentation
 - unable_to_lock_die(): rename function from unable_to_lock_index_die()

 Refactor and fix corner-case bugs in the lockfile API, all looked
 sensible.

 Expecting a reroll.


* bg/rebase-off-of-previous-branch (2014-04-16) 1 commit
 - git-rebase: print name of rev when using shorthand

 Teach "git rebase -" to report the concrete name of the branch
 (i.e. the previous one).

 But it stops short and does not do the same for "git rebase @{-1}".
 Expecting a reroll.


* tr/merge-recursive-index-only (2014-02-05) 3 commits
 - merge-recursive: -Xindex-only to leave worktree unchanged
 - merge-recursive: internal flag to avoid touching the worktree
 - merge-recursive: remove dead conditional in update_stages()
 (this branch is used by tr/remerge-diff.)

 Will hold.


* tr/remerge-diff (2014-02-26) 5 commits
 . log --remerge-diff: show what the conflict resolution changed
 . name-hash: allow dir hashing even when !ignore_case
 . merge-recursive: allow storing conflict hunks in index
 . revision: fold all merge diff variants into an enum merge_diff_mode
 . combine-diff: do not pass revs->dense_combined_merges redundantly
 (this branch uses tr/merge-recursive-index-only.)

 "log -p" output learns a new way to let users inspect a merge
 commit by showing the differences between the automerged result
 with conflicts the person who recorded the merge would have seen
 and the final conflict resolution that was recorded in the merge.

 Needs to be rebased, now kb/fast-hashmap topic is in.


* jk/makefile (2014-02-05) 16 commits
 . FIXUP
 . move LESS/LV pager environment to Makefile
 . Makefile: teach scripts to include make variables
 . FIXUP
 . Makefile: auto-build C strings from make variables
 . Makefile: drop *_SQ variables
 . FIXUP
 . Makefile: add c-quote helper function
 . Makefile: introduce sq function for shell-quoting
 . Makefile: always create files via make-var
 . Makefile: store GIT-* sentinel files in MAKE/
 . Makefile: prefer printf to echo for GIT-*
 . Makefile: use tempfile/mv strategy for GIT-*
 . Makefile: introduce make-var helper function
 . Makefile: fix git-instaweb dependency on gitweb
 . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS

 Simplify the Makefile rules and macros that exist primarily for
 quoting purposes, and make it easier to robustly express the
 dependency rules.

 Expecting a reroll.


* po/everyday-doc (2014-01-27) 1 commit
 - Make 'git help everyday' work

 This may make the said command to emit something, but the source is
 not meant to be formatted into a manual pages to begin with, and
 also its contents are a bit stale.  It may be a good first step in
 the right direction, but needs more work to at least get the
 mark-up right before public consumption.

 Will hold.


* jk/branch-at-publish-rebased (2014-01-17) 5 commits
 . t1507 (rev-parse-upstream): fix typo in test title
 . implement @{publish} shorthand
 . branch_get: provide per-branch pushremote pointers
 . branch_get: return early on error
 . sha1_name: refactor upstream_mark

 Give an easier access to the tracking branches from "other" side in
 a triangular workflow by introducing B@{publish} that works in a
 similar way to how B@{upstream} does.

 Meant to be used as a basis for whatever Ram wants to build on.

 Ejected from 'pu' to unclutter.


* fc/publish-vs-upstream (2014-04-21) 8 commits
 . sha1_name: add support for @{publish} marks
 . sha1_name: simplify track finding
 . sha1_name: cleanup interpret_branch_name()
 . branch: display publish branch
 . push: add --set-publish option
 . branch: add --set-publish-to option
 . Add concept of 'publish' branch
 . t5516 (fetch-push): fix test restoration

 Add branch@{publish}; it seems that this is somewhat different from
 Ram and Peff started working on.  At least the tip needs to be
 rerolled not to squat on @{p} which @{push} and possibly @{pull}
 may want to share.

 Ejected from 'pu' to unclutter.


* rb/merge-prepare-commit-msg-hook (2014-01-10) 4 commits
 - merge: drop unused arg from abort_commit method signature
 - merge: make prepare_to_commit responsible for write_merge_state
 - t7505: ensure cleanup after hook blocks merge
 - t7505: add missing &&

 Expose more merge states (e.g. $GIT_DIR/MERGE_MODE) to hooks that
 run during "git merge".  The log message stresses too much on one
 hook, prepare-commit-msg, but it would equally apply to other hooks
 like post-merge, I think.

 Waiting for a reroll.


* jl/submodule-recursive-checkout (2013-12-26) 5 commits
 - Teach checkout to recursively checkout submodules
 - submodule: teach unpack_trees() to update submodules
 - submodule: teach unpack_trees() to repopulate submodules
 - submodule: teach unpack_trees() to remove submodule contents
 - submodule: prepare for recursive checkout of submodules

 An RFCv2 exists ($gmane/241455) with sizable review comments.
 Expecting a reroll.


* jc/graph-post-root-gap (2013-12-30) 3 commits
 - WIP: document what we want at the end
 - graph: remove unused code a bit
 - graph: stuff the current commit into graph->columns[]

 This was primarily a RFH ($gmane/239580).


* np/pack-v4 (2013-09-18) 90 commits
 . packv4-parse.c: add tree offset caching
 . t1050: replace one instance of show-index with verify-pack
 . index-pack, pack-objects: allow creating .idx v2 with .pack v4
 . unpack-objects: decode v4 trees
 . unpack-objects: allow to save processed bytes to a buffer
 - ...

 Nico and Duy advancing the eternal vaporware pack-v4.  This is here
 primarily for wider distribution of the preview edition.

 Needs to be rebased, now the pack-bitmap series is in.


* tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
 - perf-lib: add test_perf_cleanup target
 - perf-lib: split starting the test from the execution

 Add test_perf_cleanup shell function to the perf suite, that allows
 the script writers to define a test with a clean-up action.

 Will hold.


* jc/show-branch (2014-03-24) 5 commits
 - show-branch: use commit slab to represent bitflags of arbitrary width
 - show-branch.c: remove "all_mask"
 - show-branch.c: abstract out "flags" operation
 - show-branch.c: lift all_mask/all_revs to a global static
 - show-branch.c: update comment style

 Waiting for the final step to lift the hard-limit before sending it out.

--------------------------------------------------
[Cooking]

* ep/shell-assign-and-export-vars (2014-05-23) 2 commits
  (merged to 'next' on 2014-05-23 at 7699c0e)
 + scripts: more "export VAR=VALUE" fixes
 + scripts: "export VAR=VALUE" construct is not portable

 Will merge to 'master'.


* jn/test-lint-unmoor (2014-05-23) 1 commit
  (merged to 'next' on 2014-05-23 at aa997bc)
 + test-lint: find unportable sed, echo, test, and export usage after &&

 Will merge to 'master'.


* jj/command-line-adjective (2014-05-21) 1 commit
  (merged to 'next' on 2014-05-23 at fe136c8)
 + Documentation: use "command-line" when used as a compound adjective, and fix other minor grammatical issues

 Will merge to 'master'.


* jk/daemon-tolower (2014-05-23) 1 commit
  (merged to 'next' on 2014-05-23 at 23c796d)
 + daemon/config: factor out duplicate xstrdup_tolower

 Will merge to 'master'.


* jk/strbuf-tolower (2014-05-23) 1 commit
  (merged to 'next' on 2014-05-23 at b172137)
 + strbuf: add strbuf_tolower function

 Will merge to 'master'.


* jk/http-errors (2014-05-27) 8 commits
 - http: default text charset to iso-8859-1
 - remote-curl: reencode http error messages
 - strbuf: add strbuf_reencode helper
 - http: optionally extract charset parameter from content-type
 - http: extract type/subtype portion of content-type
 - t5550: test display of remote http error messages
 - t/lib-httpd: use write_script to copy CGI scripts
 - test-lib: preserve GIT_CURL_VERBOSE from the environment

 Will merge to 'next'.


* jm/format-patch-mail-sig (2014-05-27) 2 commits
 - format-patch: add "--signature-file=<file>" option
 - format-patch: make newline after signature conditional

 Will merge to 'next'.


* sk/wincred (2014-05-14) 2 commits
  (merged to 'next' on 2014-05-21 at a3b9ca3)
 + wincred: avoid overwriting configured variables
 + wincred: add install target

 Will merge to 'master'.


* as/pretty-truncate (2014-05-21) 5 commits
  (merged to 'next' on 2014-05-23 at 94d4c51)
 + pretty.c: format string with truncate respects logOutputEncoding
 + t4205, t6006: add tests that fail with i18n.logOutputEncoding set
 + t4205 (log-pretty-format): use `tformat` rather than `format`
 + t4041, t4205, t6006, t7102: don't hardcode tested encoding value
 + t4205 (log-pretty-formats): don't hardcode SHA-1 in expected outputs

 Will merge to 'master'.


* cc/replace-graft (2014-05-19) 1 commit
  (merged to 'next' on 2014-05-21 at 7d90c4e)
 + replace: add --graft option
 (this branch uses cc/replace-edit.)

 Will eject from 'next' and replace with a newer reroll.


* jk/argv-array-for-child-process (2014-05-15) 7 commits
  (merged to 'next' on 2014-05-21 at 5b2fa64)
 + argv-array: drop "detach" code
 + get_importer: use run-command's internal argv_array
 + get_exporter: use argv_array
 + get_helper: use run-command's internal argv_array
 + git_connect: use argv_array
 + run_column_filter: use argv_array
 + run-command: store an optional argv_array

 Will merge to 'master'.


* jk/diff-files-assume-unchanged (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at 142d2c8)
 + run_diff_files: do not look at uninitialized stat data

 Will merge to 'master'.


* jk/report-fail-to-read-objects-better (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at 77c89fe)
 + open_sha1_file: report "most interesting" errno

 Will merge to 'master'.


* mt/rebase-i-keep-empty-test (2014-05-19) 1 commit
  (merged to 'next' on 2014-05-21 at d87d266)
 + rebase --keep-empty -i: add test

 Will merge to 'master'.


* nd/status-auto-comment-char (2014-05-19) 2 commits
  (merged to 'next' on 2014-05-21 at f762e62)
 + commit: allow core.commentChar=auto for character auto selection
 + config: be strict on core.commentChar

 Will merge to 'master'.


* rr/rebase-autostash-fix (2014-05-20) 2 commits
  (merged to 'next' on 2014-05-21 at ca4aa40)
 + rebase -i: test "Nothing to do" case with autostash
 + rebase -i: handle "Nothing to do" case with autostash

 Will merge to 'master'.


* sk/spawn-less-case-insensitively-from-grep-O-i (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at eb28305)
 + git grep -O -i: if the pager is 'less', pass the '-I' option

 Will merge to 'master'.


* sk/windows-unc-path (2014-05-20) 1 commit
  (merged to 'next' on 2014-05-21 at d1f1350)
 + Windows: Allow using UNC path for git repository

 Will merge to 'master'.


* jk/diff-follow-must-take-one-pathspec (2014-05-20) 1 commit
  (merged to 'next' on 2014-05-23 at 4653133)
 + move "--follow needs one pathspec" rule to diff_setup_done

 Will merge to 'master'.


* ab/add-interactive-show-diff-func-name (2014-05-12) 2 commits
 - SQUASH??? git-add--interactive: Preserve diff heading when splitting hunks
 - git-add--interactive: Preserve diff heading when splitting hunks

 Waiting for a reroll.


* jk/do-not-run-httpd-tests-as-root (2014-05-12) 1 commit
  (merged to 'next' on 2014-05-21 at 676392b)
 + t/lib-httpd: require SANITY prereq

 Will merge to 'master'.


* jk/index-pack-report-missing (2014-05-12) 1 commit
  (merged to 'next' on 2014-05-14 at 72d40e1)
 + index-pack: distinguish missing objects from type errors

 Will merge to 'master'.


* tb/unicode-6.3-zero-width (2014-05-12) 2 commits
  (merged to 'next' on 2014-05-14 at 08e0171)
 + utf8: make it easier to auto-update git_wcwidth()
 + utf8.c: use a table for double_width

 Update the logic to compute the display width needed for utf8
 strings and allow us to more easily maintain the tables used in
 that logic.

 We may want to let the users choose if codepoints with ambiguous
 widths are treated as a double or single width in a follow-up patch.

 Will merge to 'master'.


* mk/show-s-no-extra-blank-line-for-merges (2014-05-15) 1 commit
  (merged to 'next' on 2014-05-21 at 3b98b35)
 + git-show: fix 'git show -s' to not add extra terminator after merge commit

 Will merge to 'master'.


* wk/doc-clarify-upstream (2014-05-13) 1 commit
  (merged to 'next' on 2014-05-14 at 6c8fb52)
 + Documentation: mention config sources for @{upstream}

 Will merge to 'master'.


* dk/raise-core-deltabasecachelimit (2014-05-06) 1 commit
  (merged to 'next' on 2014-05-12 at 97ec92a)
 + Bump core.deltaBaseCacheLimit to 96m

 The original 16 MiB limit for the in-core delta-base-cache
 introduced in 18bdec11 (Limit the size of the new delta_base_cache,
 2007-03-19) is turning out to be too small.

 Will merge to 'master'.


* fc/status-printf-squelch-format-zero-length-warnings (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-12 at 6b04e23)
 + silence a bunch of format-zero-length warnings

 Will merge to 'master'.


* jk/grep-tell-run-command-to-cd-when-running-pager (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-12 at 065cb22)
 + grep: use run-command's "dir" option for --open-files-in-pager

 Will merge to 'master'.


* jk/squelch-compiler-warning-from-funny-error-macro (2014-05-06) 2 commits
  (merged to 'next' on 2014-05-12 at d9daf8d)
 + let clang use the constant-return error() macro
 + inline constant return from error() function

 Will merge to 'master'.


* rs/reflog-exists (2014-05-08) 2 commits
  (merged to 'next' on 2014-05-12 at 24a1d01)
 + checkout.c: use ref_exists instead of file_exist
 + refs.c: add new functions reflog_exists and delete_reflog

 Will merge to 'master'.


* tg/tag-state-tag-name-in-editor-hints (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-12 at 0b7db32)
 + builtin/tag.c: show tag name to hint in the message editor

 Will merge to 'master'.


* sk/submodules-absolute-path-on-windows (2014-05-08) 1 commit
  (merged to 'next' on 2014-05-14 at 83a05d9)
 + Revert "submodules: fix ambiguous absolute paths under Windows"

 Will merge to 'master'.


* jn/contrib-remove-diffall (2014-05-09) 1 commit
  (merged to 'next' on 2014-05-12 at 416009e)
 + contrib: remove git-diffall

 Spring cleaning of contrib/.

 Will merge to 'master'.


* jn/contrib-remove-vim (2014-05-09) 1 commit
  (merged to 'next' on 2014-05-12 at 9e727c8)
 + contrib: remove vim support instructions

 Spring cleaning of contrib/.

 Will merge to 'master'.


* ss/howto-manage-trunk (2014-05-28) 1 commit
  (merged to 'next' on 2014-05-28 at 5318336)
 + How to keep a project's canonical history correct.

 Will merge to 'master'.


* wg/svn-fe-style-fixes (2014-05-12) 1 commit
  (merged to 'next' on 2014-05-12 at 88c0e0d)
 + svn-fe: conform to pep8

 Will merge to 'master'.


* cb/byte-order (2014-05-30) 3 commits
  (merged to 'next' on 2014-05-30 at 857617e)
 + compat/bswap.h: fix endianness detection
  (merged to 'next' on 2014-05-07 at f55c040)
 + compat/bswap.h: restore preference __BIG_ENDIAN over BIG_ENDIAN
 + compat/bswap.h: detect endianness on more platforms that don't use BYTE_ORDER

 Compatibility enhancement for Solaris.

 Will merge to 'master'.


* dt/merge-recursive-case-insensitive (2014-05-08) 2 commits
  (merged to 'next' on 2014-05-12 at 820d524)
 + mv: allow renaming to fix case on case insensitive filesystems
 + merge-recursive.c: fix case-changing merge bug

 On a case insensitive filesystem, merge-recursive incorrectly
 deleted the file that is to be renamed to a name that is the same
 except for case differences.

 Will merge to 'master'.


* jc/coding-guidelines (2014-05-20) 9 commits
  (merged to 'next' on 2014-05-23 at bb351fc)
 + CodingGuidelines: avoid "test <cond> -a/-o <cond>"
  (merged to 'next' on 2014-05-12 at e1fcf62)
 + CodingGuidelines: on splitting a long line
 + CodingGuidelines: on comparison
 + CodingGuidelines: do not call the conditional statement "if()"
 + CodingGuidelines: give an example for shell function preamble
 + CodingGuidelines: give an example for control statements
 + CodingGuidelines: give an example for redirection
 + CodingGuidelines: give an example for case/esac statement
 + CodingGuidelines: once it is in, it is not worth the code churn

 Will merge to 'master'.


* jd/subtree (2014-05-13) 6 commits
  (merged to 'next' on 2014-05-14 at 977db74)
 + contrib/subtree: allow adding an annotated tag
  (merged to 'next' on 2014-05-07 at 81b375d)
 + contrib/subtree/Makefile: clean up rule for "clean"
 + contrib/subtree/Makefile: clean up rules to generate documentation
 + contrib/subtree/Makefile: s/libexecdir/gitexecdir/
 + contrib/subtree/Makefile: use GIT-VERSION-FILE
 + contrib/subtree/Makefile: scrap unused $(gitdir)

 Will merge to 'master'.


* mm/pager-less-sans-S (2014-05-07) 1 commit
  (merged to 'next' on 2014-05-07 at 66ce999)
 + pager: remove 'S' from $LESS by default

 Will merge to 'master'.


* cc/replace-edit (2014-05-19) 10 commits
  (merged to 'next' on 2014-05-19 at fcdd83f)
 + Documentation: replace: describe new --edit option
 + replace: add --edit to usage string
 + replace: add tests for --edit
 + replace: die early if replace ref already exists
 + replace: refactor checking ref validity
 + replace: make sure --edit results in a different object
  (merged to 'next' on 2014-05-12 at 71449bf)
 + replace: add --edit option
 + replace: factor object resolution out of replace_object
 + replace: use OPT_CMDMODE to handle modes
 + replace: refactor command-mode determination
 (this branch is used by cc/replace-graft.)

 "git replace" learns a new "--edit" option.

 Will merge to 'master'.


* da/imap-send-use-credential-helper (2014-04-29) 1 commit
  (merged to 'next' on 2014-05-12 at b0698a5)
 + imap-send: use git-credential

 "git imap-send" learns to ask the credential helper for
 authentication material.

 Will merge to 'master'.


* dk/blame-reorg (2014-04-28) 1 commit
  (merged to 'next' on 2014-05-14 at 354a0e3)
 + blame: large-scale performance rewrite

 Will merge to 'master'.


* je/pager-do-not-recurse (2014-04-28) 1 commit
  (merged to 'next' on 2014-05-12 at 32de470)
 + pager: do allow spawning pager recursively

 We used to unconditionally disabled the pager in the pager process
 we spawn to feed out output, but that prevents people who want to
 run less within less from doing so.

 Will merge to 'master'.


* jk/commit-C-pick-empty (2014-04-28) 1 commit
  (merged to 'next' on 2014-05-12 at c187e1e)
 + commit: do not complain of empty messages from -C

 "git commit --allow-empty-message -C $commit" did not work when the
 commit did not have any log message.

 Will merge to 'master'.


* jk/utf8-switch-between-nfd-and-nfc (2014-04-29) 1 commit
  (merged to 'next' on 2014-05-12 at 948823c)
 + t3910: show failure of core.precomposeunicode with decomposed filenames

 Document a known breakage with a test.

 Will merge to 'master'.


* mt/send-email-cover-to-cc (2014-04-29) 2 commits
  (merged to 'next' on 2014-05-12 at b696006)
 + test/send-email: to-cover, cc-cover tests
 + git-send-email: two new options: to-cover, cc-cover

 Will merge to 'master'.


* nd/split-index (2014-06-02) 34 commits
 - fixup! read-cache: new API write_locked_index instead of write_index/write_cache
 - SQUASH???
 - t1700: new tests for split-index mode
 - t2104: make sure split index mode is off for the version test
 - read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
 - read-tree: note about dropping split-index mode or index version
 - read-tree: force split-index mode off on --index-output
 - rev-parse: add --shared-index-path to get shared index path
 - update-index --split-index: do not split if $GIT_DIR is read only
 - update-index: new options to enable/disable split index mode
 - split-index: strip pathname of on-disk replaced entries
 - split-index: do not invalidate cache-tree at read time
 - split-index: the reading part
 - split-index: the writing part
 - read-cache: mark updated entries for split index
 - read-cache: save deleted entries in split index
 - read-cache: mark new entries for split index
 - read-cache: split-index mode
 - read-cache: save index SHA-1 after reading
 - entry.c: update cache_changed if refresh_cache is set in checkout_entry()
 - cache-tree: mark istate->cache_changed on prime_cache_tree()
 - cache-tree: mark istate->cache_changed on cache tree update
 - cache-tree: mark istate->cache_changed on cache tree invalidation
 - unpack-trees: be specific what part of the index has changed
 - resolve-undo: be specific what part of the index has changed
 - update-index: be specific what part of the index has changed
 - read-cache: be specific what part of the index has changed
 - read-cache: be strict about "changed" in remove_marked_cache_entries()
 - read-cache: store in-memory flags in the first 12 bits of ce_flags
 - read-cache: relocate and unexport commit_locked_index()
 - read-cache: new API write_locked_index instead of write_index/write_cache
 - sequencer: do not update/refresh index if the lock cannot be held
 - ewah: delete unused ewah_read_mmap_native declaration
 - ewah: fix constness of ewah_read_mmap

 The tip two remind us the need for a minor reroll.  If I find time
 I could try to squash them myself, but it is low priority for me.


* tl/relax-in-poll-emulation (2014-04-29) 1 commit
  (merged to 'next' on 2014-05-12 at 9369b08)
 + compat/poll: sleep 1 millisecond to avoid busy wait

 Will merge to 'master'.


* bc/blame-crlf-test (2014-05-08) 1 commit
  (merged to 'next' on 2014-05-14 at b819505)
 + blame: correctly handle files regardless of autocrlf

 If a file contained CRLF line endings in a repository with
 core.autocrlf=input, then blame always marked lines as "Not
 Committed Yet", even if they were unmodified.

 Will merge to 'master'.


* ib/test-selectively-run (2014-05-21) 4 commits
 - t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
 - test-lib: '--run' to run only specific tests
 - test-lib: tests skipped by GIT_SKIP_TESTS say so
 - test-lib: Document short options in t/README

 Allow specifying only certain individual test pieces to be run
 using a range notation (e.g. "t1234-test.sh --run='1-4 6 8 9-'").


* fc/remote-helper-refmap (2014-04-21) 8 commits
  (merged to 'next' on 2014-04-22 at fb5a4c2)
 + transport-helper: remove unnecessary strbuf resets
 + transport-helper: add support to delete branches
 + fast-export: add support to delete refs
 + fast-import: add support to delete refs
 + transport-helper: add support to push symbolic refs
 + transport-helper: add support for old:new refspec
 + fast-export: add new --refspec option
 + fast-export: improve argument parsing

 Allow remote-helper/fast-import based transport to rename the refs
 while transferring the history.


* jl/git-gui-show-added-submodule-changes (2014-04-15) 1 commit
 - git-gui: show staged submodules regardless of ignore config

 Tentatively queued what I expect to receive via Pat Thoyts.


* jl/gitk-show-added-submodule-changes (2014-04-15) 3 commits
 - gitk: show staged submodules regardless of ignore config
 - gitk: Merge branch 'new' of https://github.com/vnwildman/gitk
 - l10n: Init Vietnamese translation

 Tentatively queued what I expect to receive via Paul Mackerras.


* jh/submodule-tests (2014-04-17) 1 commit
 - t7410: 210 tests for various 'git submodule update' scenarios


* mt/patch-id-stable (2014-05-06) 6 commits
  (merged to 'next' on 2014-05-07 at 6ade68e)
 + test doc: test_write_lines does not split its arguments
  (merged to 'next' on 2014-05-02 at cfa251b)
 + t4204-patch-id.sh: default is now stable
 + patch-id: change default to stable
  (merged to 'next' on 2014-05-02 at b69326a)
 + patch-id-test: test stable and unstable behaviour
 + test: add test_write_lines helper
 + patch-id: make it stable against hunk reordering

 Introduce a new way to compute patch-id for a patch that is not
 affected by the order of the paths that appear in the input.

 Will merge to 'master'.


* nd/multiple-work-trees (2014-03-25) 28 commits
 - count-objects: report unused files in $GIT_DIR/repos/...
 - gc: support prune --repos
 - gc: style change -- no SP before closing bracket
 - prune: strategies for linked checkouts
 - checkout: detach if the branch is already checked out elsewhere
 - checkout: clean up half-prepared directories in --to mode
 - checkout: support checking out into a new working directory
 - use new wrapper write_file() for simple file writing
 - wrapper.c: wrapper to open a file, fprintf then close
 - setup.c: support multi-checkout repo setup
 - setup.c: detect $GIT_COMMON_DIR check_repository_format_gently()
 - setup.c: convert check_repository_format_gently to use strbuf
 - setup.c: detect $GIT_COMMON_DIR in is_git_directory()
 - setup.c: convert is_git_directory() to use strbuf
 - git-stash: avoid hardcoding $GIT_DIR/logs/....
 - *.sh: avoid hardcoding $GIT_DIR/hooks/...
 - git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
 - $GIT_COMMON_DIR: a new environment variable
 - commit: use SEQ_DIR instead of hardcoding "sequencer"
 - fast-import: use git_path() for accessing .git dir instead of get_git_dir()
 - reflog: avoid constructing .lock path with git_path
 - *.sh: respect $GIT_INDEX_FILE
 - git_path(): be aware of file relocation in $GIT_DIR
 - path.c: group git_path(), git_pathdup() and strbuf_git_path() together
 - path.c: rename vsnpath() to do_git_path()
 - git_snpath(): retire and replace with strbuf_git_path()
 - path.c: make get_pathname() call sites return const char *
 - path.c: make get_pathname() return strbuf instead of static buffer

 A replacement for contrib/workdir/git-new-workdir that does not
 rely on symbolic links and make sharing of objects and refs safer
 by making the borrowee and borrowers aware of each other.

 Will hold.


* cc/interpret-trailers (2014-05-28) 11 commits
 - Documentation: add documentation for 'git interpret-trailers'
 - trailer: add tests for commands in config file
 - trailer: execute command from 'trailer.<name>.command'
 - trailer: add tests for "git interpret-trailers"
 - trailer: add interpret-trailers command
 - trailer: put all the processing together and print
 - trailer: parse trailers from file or stdin
 - trailer: process command line trailer arguments
 - trailer: read and process config information
 - trailer: process trailers from input message and arguments
 - trailer: add data structures and basic functions

 A new filter to programatically edit the tail end of the commit log
 messages.

--------------------------------------------------
[Discarded]

* jc/format-patch (2013-04-22) 2 commits
 . format-patch: --inline-single
 . format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.


* mt/rebase-i-ack (2014-05-19) 6 commits
 . git-ack: record an ack
 . rebase: test ack
 . git-rebase: document ack
 . rebase -i: add ack action
 + test: add test_write_lines helper
 + patch-id: make it stable against hunk reordering
 (this branch is tangled with mt/patch-id-stable.)

 Will be rerolled post 2.0


* rs/ref-transaction (2014-04-29) 27 commits
 . refs.c: make lock_ref_sha1 static
 . refs.c: make write_ref_sha1 static
 . walker.c: use ref transaction for ref updates
 . fast-import.c: use a ref transaction when dumping tags
 . receive-pack.c: use a reference transaction for updating the refs
 . fetch.c: use a single ref transaction for all ref updates
 . fetch.c: change s_update_ref to use a ref transaction
 . fetch.c: clear errno before calling functions that might set it
 . refs.c: ref_transaction_commit should not free the transaction
 . refs.c: free the transaction before returning when number of updates is 0
 . refs.c: change update_ref to use a transaction
 . branch.c: use ref transaction for all ref updates
 . fast-import.c: change update_branch to use ref transactions
 . sequencer.c: use ref transactions for all ref updates
 . commit.c: use ref transactions for updates
 . replace.c: use the ref transaction functions for updates
 . tag.c: use ref transactions when doing updates
 . refs.c: ref_transaction_delete to check for error and return status
 . refs.c: change ref_transaction_create to do error checking and return status
 . refs.c: change ref_transaction_update() to do error checking and return status
 . refs.c: remove the onerr argument to ref_transaction_commit
 . refs.c: make update_ref_write update a strbuf on failure
 . update-ref.c: log transaction error from the update_ref
 . refs.c: make ref_update_reject_duplicates take a strbuf argument for errors
 . refs.c: add a strbuf argument to ref_transaction_commit for error logging
 . refs.c: allow passing NULL to ref_transaction_free
 . refs.c: constify the sha arguments for ref_transaction_create|delete|update
 (this branch uses mh/ref-transaction; is tangled with rs/ref-transaction-2.)

 Temporarily dropped; there are a lot of conflicts with topics in
 flight, and the topic is still being worked on with frequent
 rerolls.  Will pick up a reroll once things settle down a bit after
 the release.
