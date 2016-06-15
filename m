From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2010, #05; Sun, 27)
Date: Sun, 27 Jun 2010 13:11:41 -0700
Message-ID: <7v6314fd6q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 27 22:11:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSyCo-0003HE-EU
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 22:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618Ab0F0ULt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 16:11:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab0F0ULs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 16:11:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46D54BF05D;
	Sun, 27 Jun 2010 16:11:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=+J/D
	B8w2IlYsOzI5blaPa7lljJQ=; b=NtMikDsi4w6c3NwsnpVJlIxpmKY8INHgvGJr
	O4Ijs/gWaoGH3duiOmQ95NHtlzOm0CLdINbjJn6wRg0AF1CHGk+rTW1BZiggCX+Y
	cOvVBLz1RI1LUIgBlPrJ/vY3m1J0uILPlqUEme9UydKrsiXZ1z/2Z0FkI/NJR1s5
	3FiSpsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=DpN
	WEupIrPf2fqzaiLgYD1l+iRodi6FnrbGwiCzICzQBimzozeahXG59zArP+orQuSI
	MDEAYxgU0spdHJB8+YpOlLp5n10w16MaraS5ZRrhA0sMK07ft0YG8niR/jYFXM9Q
	0Q2jeDeK6kdrpQgWg/jZJFcgxzAMpya3T5xZnxno=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 340EABF052;
	Sun, 27 Jun 2010 16:11:45 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44C55BF04F; Sun, 27 Jun
 2010 16:11:43 -0400 (EDT)
X-master-at: 492b10766f499b60bdc867c253f36d274ac51538
X-next-at: 3336145a668a798c0dd3f7363f53ae788d35dcc9
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 35794562-8228-11DF-B3B3-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149808>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

I'd like to have most of the topics still cooking in 'next' in upcoming 1.7.2
while I don't think any of the ones out of 'next' is ready; that makes
today the perfect time to tag 1.7.2-rc0 ;-)

--------------------------------------------------
[Graduated to "master"]

* ab/blame-textconv (2010-06-07) 3 commits
  (merged to 'next' on 2010-06-23 at a7da5af)
 + t/t8006: test textconv support for blame
 + textconv: support for blame
 + textconv: make the API public
 (this branch is used by cp/textconv-cat-file.)

* cp/textconv-cat-file (2010-06-09) 5 commits
 + git-cat-file.txt: Document --textconv
  (merged to 'next' on 2010-06-23 at eb6f216)
 + t/t8007: test textconv support for cat-file
 + textconv: support for cat_file
 + sha1_name: add get_sha1_with_context()

* jn/show-num-walks (2010-06-01) 1 commit
  (merged to 'next' on 2010-06-23 at e61649c)
 + DWIM 'git show -5' to 'git show --do-walk -5'

* js/maint-am-rebase-invalid-author (2010-06-16) 1 commit
  (merged to 'next' on 2010-06-23 at b345ad5)
 + am: use get_author_ident_from_commit instead of mailinfo when rebasing

* pb/maint-perl-errmsg-no-dir (2010-06-18) 1 commit
  (merged to 'next' on 2010-06-23 at 990ea67)
 + Git.pm: better error message

* tr/send-email-8bit (2010-06-17) 1 commit
  (merged to 'next' on 2010-06-23 at be75199)
 + send-email: ask about and declare 8bit mails

--------------------------------------------------
[New Topics]

* jk/url-decode (2010-06-24) 1 commit
 - url_decode: URL scheme ends with a colon and does not require a slash

* jl/maint-submodule-ignore-dirty-submodules (2010-06-25) 1 commit
 - git submodule: ignore dirty submodules for summary and status
 (this branch is used by jl/status-ignore-submodules and jl/status-ignore-submodules; uses jl/maint-diff-ignore-submodules.)

* jl/status-ignore-submodules (2010-06-25) 1 commit
 - Add the option "--ignore-submodules" to "git status"
 (this branch uses jl/maint-diff-ignore-submodules, jl/maint-submodule-ignore-dirty-submodules and jl/maint-submodule-ignore-dirty-submodules.)

These two looked sane; will merge to 'next' shortly.

* mg/doc-rev-parse-treepath-syntax (2010-06-27) 1 commit
 - git-rev-parse.txt: Document ":path" specifier

Swapping the two bullets in the existing documentation without anything
else may be a simpler and easier-to-read alternative.

* jp/string-list-api-cleanup (2010-06-26) 6 commits
  (merged to 'next' on 2010-06-27 at b1e8b97)
 + string_list: Fix argument order for string_list_append
 + string_list: Fix argument order for string_list_lookup
 + string_list: Fix argument order for string_list_insert_at_index
 + string_list: Fix argument order for string_list_insert
 + string_list: Fix argument order for for_each_string_list
 + string_list: Fix argument order for print_string_list
 (this branch is used by jn/grep-open.)

* mg/rev-parse-tests (2010-05-14) 2 commits
  (merged to 'next' on 2010-06-27 at 3336145)
 + t6018: make sure all tested symbolic names are different revs
 + t6018: add tests for rev-list's --branches and --tags

Resurrects the tests from discarded mg/rev-parse-option-sifter-deprecation.

--------------------------------------------------
[Stalled -- would discard unless there are some movements soon]

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* zl/mailinfo-recode-patch (2010-06-14) 2 commits
 - add --recode-patch option to git-am
 - add --recode-patch option to git-mailinfo

Perhaps another round is coming?

* rr/svn-export (2010-06-10) 7 commits
 - Add LICENSE
 - Add SVN dump parser
 - Add infrastructure to write revisions in fast-export format
 - Add stream helper library
 - Add library for string-specific memory pool
 - Add cpp macro implementation of treaps
 - Add memory pool library

I recall there was another round of re-roll planned for this one.

* ab/i18n (2010-06-15) 3 commits
 . Add initial C, Shell and Perl gettext translations
 . fixup! Add infrastructure
 . Add infrastructure for translating Git with gettext

I saw a new round on the list, but I haven't got around picking it up yet.

--------------------------------------------------
[Cooking]

* ps/gitweb-soc (2010-06-02) 2 commits
  (merged to 'next' on 2010-06-13 at 92245ae)
 + git-instaweb: Add option to reuse previous config file
 + Makefile: Use $(sharedir)/gitweb for target 'install-gitweb'

If we are going to have a configuration variable to control this, I
strongly suspect that --reuse-config should be renamed so that the
variable can be named more sanely and in line with whatever option
that replaces it.

* ab/tap (2010-06-26) 6 commits
  (merged to 'next' on 2010-06-27 at a761d14)
 + t9700: Use Test::More->builder, not $Test::Builder::Test
 + tests: Say "pass" rather than "ok" on empty lines for TAP
 + tests: Skip tests in a way that makes sense under TAP
 + test-lib: output a newline before "ok" under a TAP harness
 + test-lib: Make the test_external_* functions TAP-aware
 + test-lib: Adjust output to be valid TAP format

Updated with a newer round with support for older Test::More before 0.94
version.

* ar/decorate-color (2010-06-24) 4 commits
 - Allow customizable commit decorations colors
 - log --decorate: Colorize commit decorations
 - log-tree.c: Use struct name_decoration's type for classifying decoration
 - commit.h: add 'type' to struct name_decoration

Tests, perhaps?  Otherwise looked sane.

* tc/checkout-B (2010-06-24) 3 commits
 - builtin/checkout: learn -B
 - builtin/checkout: reword hint for -b
 - add tests for checkout -b

* as/maint-completion-set-u-fix (2010-06-17) 1 commit
  (merged to 'next' on 2010-06-27 at 24ce8c2)
 + bash-completion: Fix __git_ps1 to work with "set -u"

* tr/rev-list-count (2010-06-17) 2 commits
  (merged to 'next' on 2010-06-27 at 0525b63)
 + bash completion: Support "divergence from upstream" messages in __git_ps1
 + rev-list: introduce --count option

* jl/maint-diff-ignore-submodules (2010-06-25) 3 commits
  (merged to 'next' on 2010-06-25 at d75dbf1)
 + t4027,4041: Use test -s to test for an empty file
  (merged to 'next' on 2010-06-23 at 057acb7)
 + Add optional parameters to the diff option "--ignore-submodules"
 + git diff: rename test that had a conflicting name
 (this branch is used by jl/maint-submodule-ignore-dirty-submodules and jl/status-ignore-submodules.)

* jn/grep-open (2010-06-26) 8 commits
  (merged to 'next' on 2010-06-27 at 84c0976)
 + Merge branch 'jp/string-list-api-cleanup' into jn/grep-open
  (merged to 'next' on 2010-06-22 at 8edca58)
 + t/t7811-grep-open.sh: remove broken/redundant creation of fake "less" script
 + t/t7811-grep-open.sh: ensure fake "less" is made executable
 + t/lib-pager.sh: remove unnecessary '^' from 'expr' regular expression
  (merged to 'next' on 2010-06-18 at cf96ea8)
 + grep -O: allow optional argument specifying the pager (or editor)
 + grep: Add the option '--open-files-in-pager'
 + Unify code paths of threaded greps
 + grep: refactor grep_objects loop into its own function
 (this branch uses jp/string-list-api-cleanup.)

* eb/double-convert-before-merge (2010-06-16) 1 commit
 - ll-merge: Normalize files before merging

I saw a new round on the list, but I haven't got around picking it up yet.

* cc/cherry-pick-stdin (2010-06-14) 2 commits
  (merged to 'next' on 2010-06-27 at 3af0bba)
 + revert: accept arbitrary rev-list options
 + t3508 (cherry-pick): futureproof against unmerged files

--------------------------------------------------
[Discarded]

* mg/rev-parse-lrbranches-locals (2010-05-14) 1 commit
 . revlist: Introduce --lrbranches and --locals revision specifiers
 (this branch uses mg/rev-parse-option-sifter-deprecation.)

* mg/rev-parse-option-sifter-deprecation (2010-05-14) 3 commits
 . t6018: make sure all tested symbolic names are different revs
 . t6018: add tests for rev-list's --branches and --tags
 . rev-parse: deprecate use as an option sifter

The tests are resurrected in a separate branch, though.
