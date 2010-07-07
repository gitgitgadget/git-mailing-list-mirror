From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jul 2010, #01; Wed, 7)
Date: Wed, 07 Jul 2010 16:51:47 -0700
Message-ID: <7vlj9msve4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 08 01:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWePJ-0003B0-QL
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 01:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab0GGXv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 19:51:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38107 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab0GGXvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 19:51:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 241C2C22BE;
	Wed,  7 Jul 2010 19:51:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=NpHA
	oA/0qxdTNYkRDV8yKZrtXMc=; b=idd6Kvr/0LNYlh/fcVzqPBrbMdzZ6U5D4R6f
	o6M0ufZHQefjclz8i7jCNTQYrTBobd2GLHqppZbsvaV9VeWuIzg3XpCOAmnY8T7p
	e3KIVkwBN1GNOmDmcewR9FJLVmJtctPCYHrZBwtSekhza5c6sCPAQ+SZpEVum2Ew
	PmpXRWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=lj7
	CF8CC/9sqp8RwKZj3SwMFfz15Pv4X9AGVoyWylGFMIctUuAavDC5vMnCeBcWS1we
	kcnqw0V8rNb6K3cntt+pBMSpXh1gMuITjsMH+Jixs0U/yo3znhfmECwLyFRxOLz9
	jpbMdBs/vUaKvJSO6dlElShMU/Lc4fsr057+Txiw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F754C22BD;
	Wed,  7 Jul 2010 19:51:51 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB693C22BC; Wed,  7 Jul
 2010 19:51:48 -0400 (EDT)
X-master-at: 9918285fb10d81af9021dae99c5f4de88ded497c
X-next-at: d2de19aa28e5ced283c67ce145b26a327a88acd4
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9CE7AE1C-8A22-11DF-BAE4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150515>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* ab/tap (2010-06-28) 7 commits
  (merged to 'next' on 2010-06-29 at c73dc30)
 + t/t9700/test.pl: don't access private object members, use public access methods
  (merged to 'next' on 2010-06-27 at a761d14)
 + t9700: Use Test::More->builder, not $Test::Builder::Test
 + tests: Say "pass" rather than "ok" on empty lines for TAP
 + tests: Skip tests in a way that makes sense under TAP
 + test-lib: output a newline before "ok" under a TAP harness
 + test-lib: Make the test_external_* functions TAP-aware
 + test-lib: Adjust output to be valid TAP format

* ar/decorate-color (2010-06-29) 5 commits
  (merged to 'next' on 2010-06-30 at 2d72999)
 + Add test for correct coloring of git log --decoration
 + Allow customizable commit decorations colors
 + log --decorate: Colorize commit decorations
 + log-tree.c: Use struct name_decoration's type for classifying decoration
 + commit.h: add 'type' to struct name_decoration

* as/maint-completion-set-u-fix (2010-06-17) 1 commit
  (merged to 'next' on 2010-06-27 at 24ce8c2)
 + bash-completion: Fix __git_ps1 to work with "set -u"

* cc/cherry-pick-stdin (2010-06-14) 4 commits
  (merged to 'next' on 2010-06-29 at ee7a28a)
 + revert: do not rebuild argv on heap
 + Merge commit 'v1.7.2-rc0~6^2' into cc/cherry-pick-stdin
  (merged to 'next' on 2010-06-27 at 3af0bba)
 + revert: accept arbitrary rev-list options
 + t3508 (cherry-pick): futureproof against unmerged files

* jk/url-decode (2010-06-24) 1 commit
  (merged to 'next' on 2010-06-28 at 5144a8f)
 + url_decode: URL scheme ends with a colon and does not require a slash

* jl/maint-diff-ignore-submodules (2010-06-25) 3 commits
  (merged to 'next' on 2010-06-25 at d75dbf1)
 + t4027,4041: Use test -s to test for an empty file
  (merged to 'next' on 2010-06-23 at 057acb7)
 + Add optional parameters to the diff option "--ignore-submodules"
 + git diff: rename test that had a conflicting name

* jl/maint-submodule-ignore-dirty-submodules (2010-06-25) 1 commit
 + git submodule: ignore dirty submodules for summary and status

* jl/status-ignore-submodules (2010-06-25) 1 commit
  (merged to 'next' on 2010-06-28 at bd9ae9e)
 + Add the option "--ignore-submodules" to "git status"

* jp/string-list-api-cleanup (2010-06-26) 6 commits
  (merged to 'next' on 2010-06-27 at b1e8b97)
 + string_list: Fix argument order for string_list_append
 + string_list: Fix argument order for string_list_lookup
 + string_list: Fix argument order for string_list_insert_at_index
 + string_list: Fix argument order for string_list_insert
 + string_list: Fix argument order for for_each_string_list
 + string_list: Fix argument order for print_string_list

* mg/doc-rev-parse-treepath-syntax (2010-06-28) 2 commits
  (merged to 'next' on 2010-06-30 at be16ac8)
 + git-rev-parse.txt: Add more examples for caret and colon
 + git-rev-parse.txt: Document ":path" specifier

* mg/rev-parse-tests (2010-05-14) 2 commits
  (merged to 'next' on 2010-06-27 at 3336145)
 + t6018: make sure all tested symbolic names are different revs
 + t6018: add tests for rev-list's --branches and --tags

* tr/rev-list-count (2010-06-17) 2 commits
  (merged to 'next' on 2010-06-27 at 0525b63)
 + bash completion: Support "divergence from upstream" messages in __git_ps1
 + rev-list: introduce --count option

--------------------------------------------------
[New Topics]

* jn/paginate-fix (2010-06-26) 4 commits
 - git --paginate: do not commit pager choice too early
 - tests: local config file should be honored from subdirs of toplevel
 - t7006: test pager configuration for several git commands
 - t7006 (pager): introduce helper for parameterized tests

* ar/string-list-foreach (2010-07-03) 2 commits
 - Convert the users of for_each_string_list to for_each_string_list_item macro
 - Add a for_each_string_list_item macro
 (this branch is used by tf/string-list-init.)

* il/rfc-remote-fd-ext (2010-06-28) 2 commits
 - New remote helper: git-remote-ext
 - New remote helper git-remote-fd

* ab/submodule-add-f (2010-07-05) 1 commit
 - git submodule: add submodules with git add -f <path>

* bc/maint-makefile-fixes (2010-07-06) 2 commits
 - Makefile: work around ksh's failure to handle missing list argument to for loop
 - Makefile: remove some unnecessary curly braces

* gp/pack-refs-remove-empty-dirs (2010-07-06) 1 commit
 - pack-refs: remove newly empty directories

* hv/submodule-find-ff-merge (2010-07-07) 3 commits
 - Implement automatic fast-forward merge for submodules
 - setup_revisions(): Allow walking history in a submodule
 - Teach ref iteration module about submodules

* jc/rebase-i-commit-msg-fix (2010-07-05) 2 commits
 - rebase-i: do not get fooled by a log message ending with backslash
 - rebase-i: style fix

* jk/maint-status-keep-index-timestamp (2010-07-06) 1 commit
 - do not write out index when status does not have to

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

* jn/fast-import-subtree (2010-06-30) 1 commit
 - Teach fast-import to import subtrees named by tree id

* mg/revision-doc (2010-07-05) 3 commits
 - Documentation: link to gitrevisions rather than git-rev-parse
 - Documentation: gitrevisions
 - Documentation: split off rev doc into include file

* sg/rerere-gc-old-still-used (2010-07-01) 2 commits
 . rerere: fix overeager gc
 . mingw_utime(): handle NULL times parameter

* tf/string-list-init (2010-07-04) 1 commit
 - string_list: Add STRING_LIST_INIT macro and make use of it.
 (this branch uses ar/string-list-foreach.)

* en/d-f-conflict-fix (2010-07-07) 9 commits
 - Merge branch 'jc/d-f-conflict-fix-fixup' into en/d-f-conflict-fix
 - fast-import: Improve robustness when D->F changes provided in wrong order
 - Fixup (5)
 - fast-export: Fix output order of D/F changes
 - Fixup (4)
 - merge_recursive: Fix renames across paths below D/F conflicts
 - Fixup (3)
 - merge-recursive: Fix D/F conflicts
 - Add a rename + D/F conflict testcase
 (this branch uses jc/d-f-conflict-fix-fixup.)

* jc/d-f-conflict-fix-fixup (2010-07-07) 4 commits
 - Fixup (2)
 - Add a rename + D/F conflict testcase
 - Fixup (1)
 - Add additional testcases for D/F conflicts
 (this branch is used by en/d-f-conflict-fix.)

--------------------------------------------------
[Stalled -- would discard unless there are some movements soon]

* ps/gitweb-soc (2010-06-02) 2 commits
  (merged to 'next' on 2010-06-13 at 92245ae)
 + git-instaweb: Add option to reuse previous config file
 + Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'

If we are going to have a configuration variable to control this, I
strongly suspect that --reuse-config should be renamed so that the
variable can be named more sanely and in line with whatever option
that replaces it.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

I recall there was another round of re-roll planned for this one.

* rr/svn-export (2010-06-10) 7 commits
 - Add LICENSE
 - Add SVN dump parser
 - Add infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add library for string-specific memory pool
 - Add cpp macro implementation of treaps
 - Add memory pool library

I recall there was another round of re-roll planned for this one.

--------------------------------------------------
[Cooking]

* jn/grep-open (2010-07-02) 1 commit
 - grep -O: Do not pass color sequences as filenames to pager

* ab/i18n (2010-06-23) 1 commit
 - Add infrastructure for translating Git with gettext

* tc/checkout-B (2010-06-24) 3 commits
 - builtin/checkout: learn -B
 - builtin/checkout: reword hint for -b
 - add tests for checkout -b

* eb/double-convert-before-merge (2010-07-02) 3 commits
 - Don't expand CRLFs when normalizing text during merge
 - Try normalizing files to avoid delete/modify conflicts when merging
 - Avoid conflicts when merging branches with mixed normalization
