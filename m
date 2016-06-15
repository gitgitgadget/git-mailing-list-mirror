From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2013, #04; Wed, 13)
Date: Wed, 13 Mar 2013 13:27:12 -0700
Message-ID: <7vboan11wf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 21:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFsH3-0006e0-NX
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 21:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933938Ab3CMU1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 16:27:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933178Ab3CMU1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 16:27:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9EBBA8E4;
	Wed, 13 Mar 2013 16:27:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	Z91yG8U9pDOF+J/qD0cCGdbmdA=; b=GshEw+MQlzrCsSo9CTqNM7nFFPhyKaIuL
	2hmY8DmXuzso0qck0PszylYWgY5crJBbiJ0hJRWwgEUhysUOE1lFKXLH5Blt+OPi
	smyKny2rTPaSI4s4VM0A8UWy7XpCjxQKUowz2i7pxCFYovFOtvHOuJDFJUCAzZp5
	vOt1LNzYMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=yQa
	ZCGgHAEA2VoNn96wYHoRTLmbcpHID6ygnRlLs+SF+01xnL5rTPM3uQ89ZvFLAeq6
	eySnr1SV/gifsZvcCDIU0ybp5rtxn8DhRMntsYF9BTi6ne+upyIevLWe17yaLjI5
	bC44HAFTca0u/r5T13d+Em90DhPbetXs+hzhM8bo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BD7BA8E3;
	Wed, 13 Mar 2013 16:27:15 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50A7AA8DB; Wed, 13 Mar 2013
 16:27:14 -0400 (EDT)
X-master-at: 239222f587ed06f96d90dd71c66d80a2b1e3dc9f
X-next-at: 36b63d62840a512828134a9665bea5dcf8279464
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 643F35D6-8C1C-11E2-954F-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218088>

Here are the topics that have been cooking.  Commits prefixed with
'-' are only in 'pu' (proposed updates) while commits prefixed with
'+' are in 'next'.

The tip of the master is at v1.8.2.  We have already many topics
lined up for the next cycle, so after a few days to calm down, we
will see exciting changes on 'master' starting from next week.

You can find the changes described here in the integration branches
of the repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

--------------------------------------------------
[New Topics]

* ph/tag-force-no-warn-on-creation (2013-03-13) 1 commit
 - tag: --force does not have to warn when creating tags

 Will cook in 'next'.

--------------------------------------------------
[Stalled]

* po/help-guides (2013-03-03) 5 commits
 - help doc: include --guide option description
 - help.c: add list_common_guides_help() function
 - help.c: add --guide option
 - help.c: use OPT_COUNTUP
 - show 'git help <guide>' usage, with examples

 Give more visibility to "concept guides" to help "git help" users.

 Expecting a reroll.
 $gmane/217384


* hv/config-from-strbuf (2013-03-10) 4 commits
 - teach config parsing to read from strbuf
 - config: make parsing stack struct independent from actual data source
 - config: drop file pointer validity check in get_next_char()
 - config: factor out config file stack management

 Expecting a reroll.
 $gmane/217811


* mb/gitweb-highlight-link-target (2012-12-20) 1 commit
 - Highlight the link target line in Gitweb using CSS

 Expecting a reroll.
 $gmane/211935


* mb/remote-default-nn-origin (2012-07-11) 6 commits
 - Teach get_default_remote to respect remote.default.
 - Test that plain "git fetch" uses remote.default when on a detached HEAD.
 - Teach clone to set remote.default.
 - Teach "git remote" about remote.default.
 - Teach remote.c about the remote.default configuration setting.
 - Rename remote.c's default_remote_name static variables.

 When the user does not specify what remote to interact with, we
 often attempt to use 'origin'.  This can now be customized via a
 configuration variable.

 Expecting a reroll.
 $gmane/210151

 "The first remote becomes the default" bit is better done as a
 separate step.

--------------------------------------------------
[Cooking]

* nd/branch-show-rebase-bisect-state (2013-03-13) 6 commits
 - branch: show more information when HEAD is detached
 - status: show more info than "currently not on any branch"
 - wt-status: move wt_status_get_state() out to wt_status_print()
 - wt-status: split wt_status_state parsing function out
 - wt-status: move strbuf into read_and_strip_branch()
 - Merge branch 'jc/reflog-reverse-walk' into nd/branch-show-rebase-bisect-state
 (this branch uses jc/reflog-reverse-walk.)

 The changes look sound, but some patches need better description.


* kb/p4merge (2013-03-13) 2 commits
 - mergetools/p4merge: create a base if none available
 - mergetools/p4merge: swap LOCAL and REMOTE

 Looked reasonable.

 Will merge to 'next'.


* jc/maint-push-refspec-default-doc (2013-03-08) 1 commit
 - Documentation/git-push: clarify the description of defaults

 Clarify in the documentation "what" gets pushed to "where" when the
 command line to "git push" does not say these explicitly.

 Will merge to 'next'.


* jc/reflog-reverse-walk (2013-03-08) 3 commits
 - reflog: add for_each_reflog_ent_reverse() API
 - for_each_recent_reflog_ent(): simplify opening of a reflog file
 - for_each_reflog_ent(): extract a helper to process a single entry
 (this branch is used by nd/branch-show-rebase-bisect-state.)

 An internal function used to implement "git checkout @{-1}" was
 hard to use correctly.

 Will merge to 'next'.


* jk/alias-in-bare (2013-03-08) 3 commits
  (merged to 'next' on 2013-03-09 at 2f9d72a)
 + setup: suppress implicit "." work-tree for bare repos
 + environment: add GIT_PREFIX to local_repo_env
 + cache.h: drop LOCAL_REPO_ENV_SIZE

 An aliased command spawned from a bare repository that does not say
 it is bare with "core.bare = yes" is treated as non-bare by mistake.

 Will cook in 'next'.


* pw/p4-symlinked-root (2013-03-11) 3 commits
  (merged to 'next' on 2013-03-12 at 559b926)
 + git p4: avoid expanding client paths in chdir
 + git p4 test: should honor symlink in p4 client root
 + git p4 test: make sure P4CONFIG relative path works

 Will cook in 'next'.


* jc/add-2.0-delete-default (2013-03-08) 3 commits
 - git add <pathspec>... defaults to "-A"
 - git add: start preparing for "git add <pathspec>..." to default to "-A"
 - builtin/add.c: simplify boolean variables

 "git add dir/" updated modified files and added new files, but does
 not notice removed files, which may be "Huh?" to some users.  They
 can of course use "git add -A dir/", but why should they?

 There seemed to be some interest in this topic, so resurrected and
 rebased on top of recent documentation updates to propose a
 possible transition plan.

 Will merge to and cook in 'next' until Git 2.0.


* jc/add-2.0-u-A-sans-pathspec (2013-03-11) 1 commit
 - git add: -u/-A now affects the entire working tree

 "git add -u/-A" without pathspec has traditonally limited its
 operation to the current directory and its subdirectories, but in
 Git 1.8.2 we started encouraging users to be more explicit to
 specify "." when they mean it (and use ":/" to make it affect the
 entire working tree).  With this, we finally change the behaviour
 and make it affect the entire working tree in Git 2.0.

 Will merge to and cook in 'next' until Git 2.0.


* jk/empty-archive (2013-03-10) 2 commits
  (merged to 'next' on 2013-03-12 at 942e592)
 + archive: handle commits with an empty tree
 + test-lib: factor out $GIT_UNZIP setup

 "git archive" reports a failure when asked to create an archive out
 of an empty tree.  It would be more intuitive to give an empty
 archive back in such a case.

 Will cook in 'next'.


* jk/graph-c-expose-symbols-for-cgit (2013-03-03) 1 commit
  (merged to 'next' on 2013-03-04 at be35b12)
 + Revert "graph.c: mark private file-scope symbols as static"

 In the v1.8.0 era, we changed symbols that do not have to be global
 to file scope static, but a few functions in graph.c were used by
 CGit from sideways bypassing the entry points of the API the
 in-tree users use.

 Will cook in 'next'.


* we/submodule-update-prefix-output (2013-03-03) 1 commit
  (merged to 'next' on 2013-03-04 at 908df73)
 + submodule update: when using recursion, show full path

 Will cook in 'next'.


* jc/nobody-sets-src-peer-ref (2013-03-04) 1 commit
  (merged to 'next' on 2013-03-07 at 1910e21)
 + match_push_refs(): nobody sets src->peer_ref anymore

 Dead code removal.

 Will cook in 'next'.


* jc/push-follow-tag (2013-03-05) 4 commits
  (merged to 'next' on 2013-03-09 at 748fbed)
 + push: --follow-tags
 + commit.c: use clear_commit_marks_many() in in_merge_bases_many()
 + commit.c: add in_merge_bases_many()
 + commit.c: add clear_commit_marks_many()

 The new "--follow-tags" option tells "git push" to push relevant
 tags when pushing branches out.

 Will cook in 'next'.


* jc/maint-reflog-expire-clean-mark-typofix (2013-03-05) 1 commit
  (merged to 'next' on 2013-03-07 at 0a61cbb)
 + reflog: fix typo in "reflog expire" clean-up codepath

 Will cook in 'next'.


* aw/setup-prefix-pathspec (2013-03-09) 2 commits
  (merged to 'next' on 2013-03-12 at 31a4a5e)
 + setup.c: check that the pathspec magic ends with ")"
 + setup.c: stop prefix_pathspec() from looping past the end of string

 "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
 instead the parser kept reading beyond the end of the string.

 Will cook in 'next'.


* lf/bundle-verify-list-prereqs (2013-03-08) 2 commits
  (merged to 'next' on 2013-03-08 at 9e55d6d)
 + bundle: Add colons to list headings in "verify"
 + bundle: Fix "verify" output if history is complete

 Will cook in 'next'.


* ks/rfc2047-one-char-at-a-time (2013-03-09) 1 commit
  (merged to 'next' on 2013-03-09 at a12465e)
 + format-patch: RFC 2047 says multi-octet character may not be split

 When "format-patch" quoted a non-ascii strings on the header files,
 it incorrectly applied rfc2047 and chopped a single character in
 the middle of it.

 Will cook in 'next'.


* kb/name-hash (2013-02-27) 1 commit
  (merged to 'next' on 2013-03-05 at 7f7e5d4)
 + name-hash.c: fix endless loop with core.ignorecase=true

 The code to keep track of what directory names are known to Git on
 platforms with case insensitive filesystems can get confused upon
 a hash collision between these pathnames and looped forever.

 Will cook in 'next'.


* rs/zip-compresssed-size-with-export-subst (2013-02-27) 1 commit
  (merged to 'next' on 2013-03-03 at c1ac6d8)
 + archive-zip: fix compressed size for stored export-subst files

 When export-subst is used, "zip" output recorded incorrect
 size of the file.

 Will cook in 'next'.


* jc/describe (2013-02-28) 1 commit
  (merged to 'next' on 2013-03-05 at 6b353f3)
 + describe: --match=<pattern> must limit the refs even when used with --all

 The "--match=<pattern>" option of "git describe", when used with
 "--all" to allow refs that are not annotated tags to be used as a
 base of description, did not restrict the output from the command
 to those that match the given pattern.

 We may want to have a looser matching that does not restrict to tags,
 but that can be done as a follow-up topic; this step is purely a bugfix.

 Will cook in 'next'.


* jk/mailsplit-maildir-muttsort (2013-03-02) 1 commit
  (merged to 'next' on 2013-03-03 at d5f7735)
 + mailsplit: sort maildir filenames more cleverly

 Will cook in 'next'.


* pc/subtree-add-before-fetch (2013-02-28) 1 commit
 - contrib/subtree: allow addition of remote branch with name not locally present

 Will discard.
 Not getting enough reviews.


* tr/line-log (2013-02-28) 5 commits
 - log -L: :pattern:file syntax to find by funcname
 - Implement line-history search (git log -L)
 - Export rewrite_parents() for 'log -L'
 - blame: introduce $ as "end of file" in -L syntax
 - Refactor parse_loc

 Expecting a reroll.
 $gmane/217278


* jc/perl-cat-blob (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at 7c0079a)
 + Git.pm: fix cat_blob crashes on large files

 perl/Git.pm::cat_blob slurped everything in core only to write it
 out to a file descriptor, which was not a very smart thing to do.

 Will cook in 'next'.


* nd/doc-index-format (2013-02-23) 3 commits
  (merged to 'next' on 2013-02-26 at 4d3caea)
 + update-index: list supported idx versions and their features
 + read-cache.c: use INDEX_FORMAT_{LB,UB} in verify_hdr()
 + index-format.txt: mention of v4 is missing in some places

 Update the index format documentation to mention the v4 format.

 Will cook in 'next'.


* ap/maint-diff-rename-avoid-overlap (2013-03-06) 3 commits
  (merged to 'next' on 2013-03-06 at 3bc8dda)
 + tests: make sure rename pretty print works
  (merged to 'next' on 2013-02-26 at 19d70bf)
 + diff: prevent pprint_rename from underrunning input
  (merged to 'next' on 2013-02-25 at c9bd6d3)
 + diff: Fix rename pretty-print when suffix and prefix overlap

 The logic used by "git diff -M --stat" to shorten the names of
 files before and after a rename did not work correctly when the
 common prefix and suffix between the two filenames overlapped.

 Will cook in 'next'.


* ap/maint-update-index-h-is-for-help (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at f5f767c)
 + update-index: allow "-h" to also display options

 Will cook in 'next'.


* jc/color-diff-doc (2013-02-22) 1 commit
  (merged to 'next' on 2013-02-25 at c37541c)
 + diff-options: unconfuse description of --color

 Will cook in 'next'.


* nd/branch-error-cases (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at 1d0289f)
 + branch: segfault fixes and validation

 "git branch" had more cases where it did not bother to check
 nonsense command line parameters.

 Will cook in 'next'.


* rt/commit-cleanup-config (2013-02-23) 1 commit
  (merged to 'next' on 2013-02-25 at 8249b61)
 + t7502: perform commits using alternate editor in a subshell

 Fix tests that contaminated their environments and affected new
 tests introduced later in the sequence by containing their effects
 in their own subshells.

 Will cook in 'next'.


* wk/doc-pre-rebase (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-25 at a6ec310)
 + Documentation/githooks: Explain pre-rebase parameters

 Will cook in 'next'.


* da/downcase-u-in-usage (2013-02-24) 20 commits
  (merged to 'next' on 2013-02-26 at 977b67e)
 + contrib/mw-to-git/t/install-wiki.sh: use a lowercase "usage:" string
 + contrib/examples/git-remote.perl: use a lowercase "usage:" string
 + tests: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + Documentation/user-manual.txt: use a lowercase "usage:" string
 + templates/hooks--update.sample: use a lowercase "usage:" string
 + contrib/hooks/setgitperms.perl: use a lowercase "usage:" string
 + contrib/examples: use a lowercase "usage:" string
 + contrib/fast-import/import-zips.py: use spaces instead of tabs
 + contrib/fast-import/import-zips.py: fix broken error message
 + contrib/fast-import: use a lowercase "usage:" string
 + contrib/credential: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsimport: use a lowercase "usage:" string
 + git-cvsexportcommit: use a lowercase "usage:" string
 + git-archimport: use a lowercase "usage:" string
 + git-merge-one-file: use a lowercase "usage:" string
 + git-relink: use a lowercase "usage:" string
 + git-svn: use a lowercase "usage:" string
 + git-sh-setup: use a lowercase "usage:" string

 Will cook in 'next'.


* dm/ni-maxhost-may-be-missing (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at 93ec2c9)
 + git-compat-util.h: Provide missing netdb.h definitions

 Will cook in 'next'.


* gp/avoid-explicit-mention-of-dot-git-refs (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at ec42d98)
 + Fix ".git/refs" stragglers

 Will cook in 'next'.


* gp/describe-match-uses-glob-pattern (2013-02-24) 1 commit
  (merged to 'next' on 2013-02-26 at c9cc789)
 + describe: Document --match pattern format
 (this branch is used by gp/forbid-describe-all-match.)

 Will cook in 'next'.


* jk/common-make-variables-export-safety (2013-02-25) 1 commit
  (merged to 'next' on 2013-03-05 at 084ae43)
 + Makefile: make mandir, htmldir and infodir absolute

 Make the three variables safer to be exported to submakes by
 ensuring that they are full paths so that they can be used as
 installation location.

 Will cook in 'next'.


* jk/suppress-clang-warning (2013-02-25) 1 commit
 - fix clang -Wtautological-compare with unsigned enum

 Will merge to 'next'.


* mg/qnx6 (2013-02-25) 1 commit
 - QNX: newer QNX 6.x.x is not so crippled

 Still under discussion.
 Not ready for inclusion.


* mg/unsigned-time-t (2013-02-25) 2 commits
 - Fix time offset calculation in case of unsigned time_t
 - date.c: fix unsigned time_t comparison

 A few workarounds for systems with unsigned time_t.

 Will merge to 'next'.


* rj/msvc-build (2013-02-25) 5 commits
  (merged to 'next' on 2013-02-26 at 7493068)
 + msvc: avoid collisions between "tags" and "TAGS"
 + msvc: test-svn-fe: Fix linker "unresolved external" error
 + msvc: Fix build by adding missing symbol defines
 + msvc: git-daemon: Fix linker "unresolved external" errors
 + msvc: Fix compilation errors caused by poll.h emulation

 Will cook in 'next'.


* wk/user-manual-literal-format (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at d59ce38)
 + user-manual: Standardize backtick quoting

 Will cook in 'next'.


* jk/utf-8-can-be-spelled-differently (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-26 at c079525)
 + utf8: accept alternate spellings of UTF-8

 Will cook in 'next'.


* jk/pkt-line-cleanup (2013-02-24) 19 commits
  (merged to 'next' on 2013-02-25 at d83e970)
 + remote-curl: always parse incoming refs
 + remote-curl: move ref-parsing code up in file
 + remote-curl: pass buffer straight to get_remote_heads
 + teach get_remote_heads to read from a memory buffer
 + pkt-line: share buffer/descriptor reading implementation
 + pkt-line: provide a LARGE_PACKET_MAX static buffer
 + pkt-line: move LARGE_PACKET_MAX definition from sideband
 + pkt-line: teach packet_read_line to chomp newlines
 + pkt-line: provide a generic reading function with options
 + pkt-line: drop safe_write function
 + pkt-line: move a misplaced comment
 + write_or_die: raise SIGPIPE when we get EPIPE
 + upload-archive: use argv_array to store client arguments
 + upload-archive: do not copy repo name
 + send-pack: prefer prefixcmp over memcmp in receive_status
 + fetch-pack: fix out-of-bounds buffer offset in get_ack
 + upload-pack: remove packet debugging harness
 + upload-pack: do not add duplicate objects to shallow list
 + upload-pack: use get_sha1_hex to parse "shallow" lines

 Cleans up pkt-line API, implementation and its callers to make
 them more robust.

 Will cook in 'next'.


* ob/imap-send-ssl-verify (2013-02-20) 1 commit
  (merged to 'next' on 2013-02-25 at e897609)
 + imap-send: support Server Name Indication (RFC4366)

 Correctly connect to SSL/TLS sites that serve multiple hostnames on
 a single IP by including Server Name Indication in the client-hello.

 Will cook in 'next'.


* jc/format-patch (2013-02-21) 2 commits
 - format-patch: --inline-single
 - format-patch: rename "no_inline" field

 A new option to send a single patch to the standard output to be
 appended at the bottom of a message.  I personally have no need for
 this, but it was easy enough to cobble together.  Tests, docs and
 stripping out more MIMEy stuff are left as exercises to interested
 parties.

 Not ready for inclusion.


* tk/doc-filter-branch (2013-02-26) 2 commits
  (merged to 'next' on 2013-02-26 at bd4638b)
 + Documentation: filter-branch env-filter example
 + git-filter-branch.txt: clarify ident variables usage

 Will cook in 'next'.


* bc/commit-complete-lines-given-via-m-option (2013-02-19) 4 commits
  (merged to 'next' on 2013-02-19 at cf622b7)
 + Documentation/git-commit.txt: rework the --cleanup section
 + git-commit: only append a newline to -m mesg if necessary
 + t7502: demonstrate breakage with a commit message with trailing newlines
 + t/t7502: compare entire commit message with what was expected

 'git commit -m "$str"' when $str was already terminated with a LF
 now avoids adding an extra LF to the message.

 Will cook in 'next'.


* da/difftool-fixes (2013-02-21) 4 commits
  (merged to 'next' on 2013-02-25 at 687db1f)
 + t7800: "defaults" is no longer a builtin tool name
 + t7800: modernize tests
 + t7800: update copyright notice
 + difftool: silence uninitialized variable warning

 Minor maintenance updates to difftool, and updates to its tests.

 Will cook in 'next'.


* nd/read-directory-recursive-optim (2013-02-17) 1 commit
  (merged to 'next' on 2013-02-17 at 36ba9f4)
 + read_directory: avoid invoking exclude machinery on tracked files

 "git status" has been optimized by taking advantage of the fact
 that paths that are already known to the index do not have to be
 checked against the .gitignore mechanism under some conditions.

 Will cook in 'next'.


* mg/gpg-interface-using-status (2013-02-14) 5 commits
  (merged to 'next' on 2013-02-26 at 93f0e72)
 + pretty: make %GK output the signing key for signed commits
 + pretty: parse the gpg status lines rather than the output
 + gpg_interface: allow to request status return
 + log-tree: rely upon the check in the gpg_interface
 + gpg-interface: check good signature in a reliable way

 Call "gpg" using the right API when validating the signature on
 tags.

 Will cook in 'next'.


* jn/shell-disable-interactive (2013-03-09) 2 commits
 - shell: new no-interactive-login command to print a custom message
 - shell doc: emphasize purpose and security model

 Will merge to 'next'.


* jc/fetch-raw-sha1 (2013-02-07) 4 commits
  (merged to 'next' on 2013-02-14 at ffa3c65)
 + fetch: fetch objects by their exact SHA-1 object names
 + upload-pack: optionally allow fetching from the tips of hidden refs
 + fetch: use struct ref to represent refs to be fetched
 + parse_fetch_refspec(): clarify the codeflow a bit

 Allows requests to fetch objects at any tip of refs (including
 hidden ones).  It seems that there may be use cases even outside
 Gerrit (e.g. $gmane/215701).

 Will cook in 'next'.


* mn/send-email-works-with-credential (2013-02-27) 6 commits
  (merged to 'next' on 2013-02-27 at ee7ae0e)
 + git-send-email: use git credential to obtain password
 + Git.pm: add interface for git credential command
 + Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
 + Git.pm: refactor command_close_bidi_pipe to use _cmd_close
 + Git.pm: fix example in command_close_bidi_pipe documentation
 + Git.pm: allow command_close_bidi_pipe to be called as method

 Hooks the credential system to send-email.

 Will cook in 'next'.


* nd/count-garbage (2013-02-15) 4 commits
  (merged to 'next' on 2013-02-17 at b2af923)
 + count-objects: report how much disk space taken by garbage files
 + count-objects: report garbage files in pack directory too
 + sha1_file: reorder code in prepare_packed_git_one()
 + git-count-objects.txt: describe each line in -v output

 Will cook in 'next'.


* tz/credential-authinfo (2013-02-25) 1 commit
  (merged to 'next' on 2013-02-27 at 7a261cb)
 + Add contrib/credentials/netrc with GPG support

 A new read-only credential helper (in contrib/) to interact with
 the .netrc/.authinfo files.  Hopefully mn/send-email-authinfo topic
 can rebuild on top of something like this.

 Will cook in 'next'.


* jl/submodule-deinit (2013-03-04) 1 commit
  (merged to 'next' on 2013-03-05 at 097164e)
 + submodule: add 'deinit' command

 There was no Porcelain way to say "I no longer am interested in
 this submodule", once you express your interest in a submodule with
 "submodule init".  "submodule deinit" is the way to do so.

 Will cook in 'next'.


* jc/remove-export-from-config-mak-in (2013-03-05) 3 commits
  (merged to 'next' on 2013-03-05 at abaa3cb)
 + Fix `make install` when configured with autoconf
  (merged to 'next' on 2013-02-12 at eb8af04)
 + Makefile: do not export mandir/htmldir/infodir
  (merged to 'next' on 2013-02-07 at 33f7d4f)
 + config.mak.in: remove unused definitions

 config.mak.in template had an "export" line to cause a few
 common makefile variables to be exported; if they need to be
 expoted for autoconf/configure users, they should also be exported
 for people who write config.mak the same way.  Move the "export" to
 the main Makefile.  Also, stop exporting mandir that used to be
 exported (only) when config.mak.autogen was used.  It would have
 broken installation of manpages (but not other documentation
 formats).

 Will cook in 'next'.


* jc/remove-treesame-parent-in-simplify-merges (2013-01-17) 1 commit
  (merged to 'next' on 2013-01-30 at b639b47)
 + simplify-merges: drop merge from irrelevant side branch

 The --simplify-merges logic did not cull irrelevant parents from a
 merge that is otherwise not interesting with respect to the paths
 we are following.

 This touches a fairly core part of the revision traversal
 infrastructure; even though I think this change is correct, please
 report immediately if you find any unintended side effect.

 Will cook in 'next'.


* jc/push-2.0-default-to-simple (2013-01-16) 14 commits
  (merged to 'next' on 2013-01-16 at 23f5df2)
 + t5570: do not assume the "matching" push is the default
 + t5551: do not assume the "matching" push is the default
 + t5550: do not assume the "matching" push is the default
  (merged to 'next' on 2013-01-09 at 74c3498)
 + doc: push.default is no longer "matching"
 + push: switch default from "matching" to "simple"
 + t9401: do not assume the "matching" push is the default
 + t9400: do not assume the "matching" push is the default
 + t7406: do not assume the "matching" push is the default
 + t5531: do not assume the "matching" push is the default
 + t5519: do not assume the "matching" push is the default
 + t5517: do not assume the "matching" push is the default
 + t5516: do not assume the "matching" push is the default
 + t5505: do not assume the "matching" push is the default
 + t5404: do not assume the "matching" push is the default

 Will cook in 'next' until Git 2.0.


* bc/append-signed-off-by (2013-02-23) 13 commits
  (merged to 'next' on 2013-02-25 at 32f7ac2)
 + git-commit: populate the edit buffer with 2 blank lines before s-o-b
 + Unify appending signoff in format-patch, commit and sequencer
 + format-patch: update append_signoff prototype
 + t4014: more tests about appending s-o-b lines
 + sequencer.c: teach append_signoff to avoid adding a duplicate newline
 + sequencer.c: teach append_signoff how to detect duplicate s-o-b
 + sequencer.c: always separate "(cherry picked from" from commit body
 + sequencer.c: require a conforming footer to be preceded by a blank line
 + sequencer.c: recognize "(cherry picked from ..." as part of s-o-b footer
 + t/t3511: add some tests of 'cherry-pick -s' functionality
 + t/test-lib-functions.sh: allow to specify the tag name to test_commit
 + commit, cherry-pick -s: remove broken support for multiline rfc2822 fields
 + sequencer.c: rework search for start of footer to improve clarity

 Will cook in 'next'.


* gp/forbid-describe-all-match (2013-02-24) 1 commit
 - describe: make --all and --match=PATTERN mutually incompatible
 (this branch uses gp/describe-match-uses-glob-pattern.)

 "describe --match=<pattern> --all <commit>" ought to mean "use refs
 that match <pattern> to describe <commit>; you do not have to limit
 yourself to annotated tags."  But it doesn't.  Disable the
 combination.

 Will discard.

 jc/describe topic fixes the semantics of --match used with --all
 option.
