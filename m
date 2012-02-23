From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2012, #08; Wed, 22)
Date: Wed, 22 Feb 2012 18:34:32 -0800
Message-ID: <7vfwe26zwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 03:34:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0OW2-00016V-PU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 03:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab2BWCeh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 21:34:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab2BWCeg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 21:34:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 444187B25;
	Wed, 22 Feb 2012 21:34:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=2ibY12Wmj95UkO47czigvR/c4
	7w=; b=yKi3LaTQOMznmlvwz44MJKgB1NsexkCHGdF65EShsCwLxSfsQaRfqUZVJ
	rT62GfvDao/MYbrJ3Nmc4gbTLhkHK6/iIC0HxVuUIgSJSx0FzyygW+NEvFvfWjwA
	I1Rgn3yHFySdN2+6aBdZZX7qKPZKKkB4/jqVoCcvwj68bjQiKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=c/u658KZT0gJZTte+gz
	JV9bfV1oZZSrjDIa5OyY88cetVPxcUsxpuyXojrP5/iSYFaPxuZ1QX49V3809qBY
	y5YgHRlg+xwM6X0cVV7SPoOFOmV0l+twycekFYcNsMA7fZItJ1U6cC2/Aq4HvHe0
	yD9/bMdNVPpUqTJBdRY97wP0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B8517B24;
	Wed, 22 Feb 2012 21:34:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 387D07B23; Wed, 22 Feb 2012
 21:34:34 -0500 (EST)
X-master-at: f1f1b96e99fa064ed9f0da263d4b4eb0407b3ceb
X-next-at: b4472eeb9efa715ecf088c254868d80ebfa252fd
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC0409D6-5DC6-11E1-B888-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191323>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' (proposed updates) while commits prefixed with '+' are in =
'next'.

You can find the changes described here in the integration branches of =
the
repositories listed at

    http://git-blame.blogspot.com/p/git-public-repositories.html

But I seem to be getting this from the github:

  ERROR: Permission to git/git.git denied to gitster.
  fatal: The remote end hung up unexpectedly

so https://github.com/git/git/ is not updated.  All others are OK.

--------------------------------------------------
[New Topics]

* jb/filter-ignore-sigpipe (2012-02-21) 1 commit
 - Ignore SIGPIPE when running a filter driver

Looked sane.
Will merge to "next".

* jc/pickaxe-ignore-case (2012-02-21) 1 commit
 - pickaxe: allow -i to search in patch case-insensitively

* jc/doc-merge-options (2012-02-22) 1 commit
 - Documentation/merge-options.txt: group "ff" related options together

Documentation for "git merge" had "--ff-only" far away from other optio=
ns
related to the handling of fast-forward merges.

* ph/cherry-pick-advice-refinement (2012-02-22) 1 commit
 - cherry-pick: No advice to commit if --no-commit

* pj/completion-remote-set-url-branches (2012-02-22) 2 commits
 - completion: normalize increment/decrement style
 - completion: remote set-* <name> and <branch>

* th/git-diffall (2012-02-22) 1 commit
 - contrib: added git-diffall

--------------------------------------------------
[Graduated to "master"]

* jk/diff-highlight (2012-02-13) 5 commits
  (merged to 'next' on 2012-02-20 at ba040ae)
 + diff-highlight: document some non-optimal cases
 + diff-highlight: match multi-line hunks
 + diff-highlight: refactor to prepare for multi-line hunks
 + diff-highlight: don't highlight whole lines
 + diff-highlight: make perl strict and warnings fatal

Updates diff-highlight (in contrib/).

* jn/gitweb-unborn-head (2012-02-17) 1 commit
  (merged to 'next' on 2012-02-20 at 80e3ff2)
 + gitweb: Fix "heads" view when there is no current branch

"gitweb" compared non-existent value of HEAD with the names of commit
objects at tips of branches, triggering runtime warnings.

--------------------------------------------------
[Stalled]

* jl/maint-submodule-relative (2012-02-09) 2 commits
 - submodules: always use a relative path from gitdir to work tree
 - submodules: always use a relative path to gitdir

The second one looked iffy.

* hv/submodule-recurse-push (2012-02-13) 3 commits
 - push: teach --recurse-submodules the on-demand option
 - Refactor submodule push check to use string list instead of integer
 - Teach revision walking machinery to walk multiple times sequencially

The bottom one was not clearly explained and needs a reroll.

* zj/diff-stat-dyncol (2012-02-15) 6 commits
 . diff --stat: use less columns for change counts
 - (squash to the previous -- replace the last line of the log with the=
 following)
 - diff --stat: use the full terminal width
 - (squash to the previous -- replace the log message with this)
 - diff --stat: tests for long filenames and big change counts
 - Merge branches zj/decimal-width and zj/term-columns

I am beginning to think that the last one should wait until the dust fr=
om
the earlier part settles.

* jc/advise-push-default (2011-12-18) 1 commit
 - push: hint to use push.default=3Dupstream when appropriate

Peff had a good suggestion outlining an updated code structure so that
somebody new can try to dip his or her toes in the development. Any
takers?

* ss/git-svn-prompt-sans-terminal (2012-01-04) 3 commits
 - fixup! 15eaaf4
 - git-svn, perl/Git.pm: extend Git::prompt helper for querying users
 - perl/Git.pm: "prompt" helper to honor GIT_ASKPASS and SSH_ASKPASS

The bottom one has been replaced with a rewrite based on comments from
=C3=86var. The second one needs more work, both in perl/Git.pm and prom=
pt.c, to
give precedence to tty over SSH_ASKPASS when terminal is available.

* jc/split-blob (2012-01-24) 6 commits
 - chunked-object: streaming checkout
 - chunked-object: fallback checkout codepaths
 - bulk-checkin: support chunked-object encoding
 - bulk-checkin: allow the same data to be multiply hashed
 - new representation types in the packstream
 - varint-in-pack: refactor varint encoding/decoding

Not ready.

I finished the streaming checkout codepath, but as explained in 127b177
(bulk-checkin: support chunked-object encoding, 2011-11-30), these are
still early steps of a long and painful journey. At least pack-objects =
and
fsck need to learn the new encoding for the series to be usable locally=
,
and then index-pack/unpack-objects needs to learn it to be used remotel=
y.

Given that I heard a lot of noise that people want large files, and tha=
t I
was asked by somebody at GitTogether'11 privately for an advice on how =
to
pay developers (not me) to help adding necessary support, I am somewhat
dissapointed that the original patch series that was sent almost two
months ago still remains here without much comments and updates from th=
e
developer community. I even made the interface to the logic that decide=
s
where to split chunks easily replaceable, and I deliberately made the
logic in the original patch extremely stupid to entice others, especial=
ly
the "bup" fanboys, to come up with a better logic, thinking that giving
people an easy target to shoot for, they may be encouraged to help
out. The plan is not working :-(.

* nd/columns (2012-02-08) 15 commits
 . column: Fix some compiler and sparse warnings
 . column: add a corner-case test to t3200
 . columns: minimum coding style fixes
 . tag: add --column
 . column: support piping stdout to external git-column process
 . status: add --column
 . branch: add --column
 . help: reuse print_columns() for help -a
 . column: add column.ui for default column output settings
 . column: support columns with different widths
 . column: add columnar layout
 . Stop starting pager recursively
 . Add git-column and column mode parsing
 . column: add API to print items in columns
 . Save terminal width before setting up pager

Expecting a reroll on top of zj/term-columns topic.

--------------------------------------------------
[Cooking]

* fc/push-prune (2012-02-22) 4 commits
 - push: add '--prune' option
 - remote: refactor code into alloc_delete_ref()
 - remote: reorganize check_pattern_match()
 - remote: use a local variable in match_push_refs()

Rerolled and looked sane.
Will merge to "next".

* jc/add-refresh-unmerged (2012-02-17) 1 commit
  (merged to 'next' on 2012-02-21 at 09f8721)
 + refresh_index: do not show unmerged path that is outside pathspec

"git add --refresh <pathspec>" warned about unmerged paths outside the
given pathspec.

* jc/diff-ignore-case (2012-02-19) 6 commits
 - diff -i
 - diff: --ignore-case
 - xdiff: introduce XDF_IGNORE_CASE
 - xdiff: introduce XDF_INEXACT_MATCH
 - xdiff: PATIENCE/HISTOGRAM are not independent option bits
 - xdiff: remove XDL_PATCH_* macros

"git diff" learns "--ignore-case" option.

* jn/gitweb-hilite-regions (2012-02-19) 5 commits
 - gitweb: Use esc_html_match_hl() in 'grep' search
 - gitweb: Highlight matched part of shortened project description
 - gitweb: Highlight matched part of project description when searching=
 projects
 - gitweb: Highlight matched part of project name when searching projec=
ts
 - gitweb: Introduce esc_html_hl_regions
 (this branch uses jn/gitweb-search-optim.)

Not reviewed and do not know what this is about yet ;-).

* jn/gitweb-search-optim (2012-02-19) 3 commits
 - gitweb: Faster project search
 - gitweb: Option for filling only specified info in fill_project_list_=
info
 - gitweb: Refactor checking if part of project info need filling
 (this branch is used by jn/gitweb-hilite-regions.)

The API introduced in the second step still has yucky design, but at le=
ast
it is more clear than the previous rounds what this is trying to do.

* js/configure-libintl (2012-02-20) 1 commit
  (merged to 'next' on 2012-02-21 at 79d7ccc)
 + configure: don't use -lintl when there is no gettext support

Build fix for autoconf, meant for 'maint' track.

* pj/remote-set-branches-usage-fix (2012-02-19) 1 commit
  (merged to 'next' on 2012-02-21 at cb71d0e)
 + remote: fix set-branches usage and documentation

Documentation fix.

* tr/perftest (2012-02-17) 3 commits
  (merged to 'next' on 2012-02-20 at 4c75ba9)
 + Add a performance test for git-grep
 + Introduce a performance testing framework
 + Move the user-facing test library to test-lib-functions.sh

* jb/required-filter (2012-02-17) 1 commit
 - Add a setting to require a filter to be successful

A content filter used to be a way to make the recorded contents "more
useful", but this defines a way to optionally mark a filter "required".
Will merge to "next" after waiting for a few more days for comments.

* jk/config-include (2012-02-17) 10 commits
  (merged to 'next' on 2012-02-20 at 7b150b7)
 + config: add include directive
 + config: eliminate config_exclusive_filename
 + config: stop using config_exclusive_filename
 + config: provide a version of git_config with more options
 + config: teach git_config_rename_section a file argument
 + config: teach git_config_set_multivar_in_file a default path
 + config: copy the return value of prefix_filename
 + t1300: add missing &&-chaining
 + docs/api-config: minor clarifications
 + docs: add a basic description of the config API

An assignment to the include.path pseudo-variable causes the named file
to be included in-place when Git looks up configuration variables.

Reverted the earlier round from 'next' and then fixed up further.

* ld/git-p4-expanded-keywords (2012-02-14) 1 commit
  (merged to 'next' on 2012-02-16 at a9004c5)
 + git-p4: add initial support for RCS keywords

Teach git-p4 to unexpand $RCS$-like keywords that are embedded in
tracked contents in order to reduce unnecessary merge conflicts.

Waiting for follow-up fix-up patches.
