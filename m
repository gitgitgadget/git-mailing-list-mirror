From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2011, #01; Sun, 5)
Date: Sun, 05 Jun 2011 23:29:13 -0700
Message-ID: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTTJV-0001Y3-Oc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 08:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab1FFG3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 02:29:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1FFG3T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 02:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93D8133CB;
	Mon,  6 Jun 2011 02:31:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=m
	oUqQbKMliQ/Ve2Yysedu5p/CaI=; b=M9kpWssguIBFnuM7F3ARsGY1IvUc5EDzK
	dJl6Vxq41qOA+teac2vSTyNHjl9MczkTfInsfZq49RfOgi83rCkSzxkuEKpnGjRW
	665XnUnaNAWv+dwuNJdk+ZsAKtIV5as8AurW1/eoSvV2BJL+fF8gbFrUD6055qD+
	t6D9e8e7KU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=E54
	/B7b+d3FEOo8WY8KlLx9UrkglT9pCBWWemEBlvtNBzk3e9SHuDRVV1YNqYGt3GtX
	T8li0y82SL0msmRapfFzusFG5o7Ctp556r671iI28oFiQO4INFmrw3PJceKFtKWi
	/SRKntCSzQCUJkHBZHcK8ul42Cb3SuxTpJy+dFas=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EF0E33CA;
	Mon,  6 Jun 2011 02:31:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 66BFF33C9; Mon,  6 Jun 2011
 02:31:25 -0400 (EDT)
X-master-at: a6605d76cdad37ed3c55a7be4d2e0af0f4721bb2
X-next-at: 697f9d23c6a32d612282fa77d5a526ad9a9ae192
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B80D46E-9006-11E0-BFF7-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175093>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

We will be in the feature freeze, and 1.7.6-rc1 will be tagged in a few
days. Unless it is a very obviously correct fix to trivial bug (either
code or documentation), nothing other than regression fixes will graduate
to "master".

Subsystem people are asked to kindly give pull requests to me.

--------------------------------------------------
[New Topics]

* js/ref-namespaces (2011-06-05) 4 commits
 - ref namespaces: documentation
 - ref namespaces: support remote repositories via upload-pack and receive-pack
 - ref namespaces: infrastructure
 - Fix prefix handling in ref iteration functions

Fairly involved feature enhancement, and breaks tests when merged to 'pu'.
Not urgent. Will not merge before 1.7.6.

* db/http-cookies (2011-06-03) 1 commit
 - http: pass http.cookiefile using CURLOPT_COOKIEFILE

Fairly trivial enhancement.
Not urgent. Will not merge before 1.7.6.

* jc/maint-1.7.3-checkout-describe (2011-06-05) 1 commit
 - checkout -b <name>: correctly detect existing branch

Fairly trivial bugfix.
Not urgent. Will not merge before 1.7.6.

* jk/clone-detached (2011-06-05) 4 commits
 - remote-testgit: short-term fix to allow t5800 pass
 - clone: always fetch remote HEAD
 - consider only branches in guess_remote_head
 - t: add tests for cloning remotes with detached HEAD

Somewhat involved bugfix.
Not urgent. Will not merge before 1.7.6.

* jk/maint-1.7.2-status-ignored (2011-06-02) 2 commits
  (merged to 'next' on 2011-06-02 at 8626cc6)
 + git status --ignored: tests and docs
 + status: fix bug with missing --ignore files

Fairly trivial bugfix.
Not urgent. Will not merge before 1.7.6.

* jl/submodule-add-relurl-wo-upstream (2011-06-05) 1 commit
 - submodule add: improve message when resolving a relative url fails

This is just a message change without loosening a seemingly overtight
restriction in the code. It might turn out to be a good idea to loosen
the check.

Not urgent. Will not merge before 1.7.6.

* jn/gitweb-docs (2011-06-03) 3 commits
  (merged to 'next' on 2011-06-05 at 691c7e6)
 + gitweb: Move "Requirements" up in gitweb/INSTALL
  (merged to 'next' on 2011-06-02 at 56cba41)
 + gitweb: Describe CSSMIN and JSMIN in gitweb/INSTALL
 + gitweb: Move information about installation from README to INSTALL

Should be safe.
Will merge to "master" before 1.7.6-rc1.

* jn/mime-type-with-params (2011-06-05) 1 commit
  (merged to 'next' on 2011-06-05 at 697f9d2)
 + gitweb: Fix usability of $prevent_xss

Will merge to "master" before 1.7.6-rc1.

* rs/grep-color (2011-06-05) 3 commits
 - grep: add --heading
 - grep: add --break
 - grep: fix coloring of hunk marks between files

Fairly straightforward feature enhancement.
Not urgent. Will not merge before 1.7.6.

--------------------------------------------------
[Stalled]

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* jc/index-pack (2011-06-05) 9 commits
 - verify-pack: use index-pack --verify
 - index-pack: show histogram when emulating "verify-pack -v"
 - index-pack: start learning to emulate "verify-pack -v"
 - index-pack: a miniscule refactor
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Killed "verify-pack" ;-) The next will be to update fsck, which would be a
bigger task.

Not urgent. Will not merge before 1.7.6.

* jh/receive-count-limit (2011-05-23) 10 commits
 - receive-pack: Allow server to refuse pushes with too many objects
 - pack-objects: Estimate pack size; abort early if pack size limit is exceeded
 - send-pack/receive-pack: Allow server to refuse pushing too large packs
 - pack-objects: Allow --max-pack-size to be used together with --stdout
 - send-pack/receive-pack: Allow server to refuse pushes with too many commits
 - pack-objects: Teach new option --max-commit-count, limiting #commits in pack
 - receive-pack: Prepare for addition of the new 'limit-*' family of capabilities
 - Tighten rules for matching server capabilities in server_supports()
 - send-pack: Attempt to retrieve remote status even if pack-objects fails
 - Update technical docs to reflect side-band-64k capability in receive-pack

Would need another round to separate per-pack and per-session limits.
Not urgent. Will not merge before 1.7.6.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

--------------------------------------------------
[Cooking]

* jc/diff-index-quick-exit-early (2011-05-31) 2 commits
  (merged to 'next' on 2011-06-01 at 79d868a)
 + diff-index --quiet: learn the "stop feeding the backend early" logic
 + Merge remote-tracking branch 'ko/maint' into jc/diff-index-quick-exit-early
 (this branch uses jk/diff-not-so-quick.)

Not urgent. Will not merge before 1.7.6.

* jk/diff-not-so-quick (2011-05-31) 2 commits
  (merged to 'next' on 2011-06-01 at 5f66784)
 + diff: futureproof "stop feeding the backend early" logic
 + diff_tree: disable QUICK optimization with diff filter
 (this branch is used by jc/diff-index-quick-exit-early.)

Will merge to "master" before 1.7.6-rc1.

* bc/maint-status-z-to-use-porcelain (2011-05-29) 2 commits
  (merged to 'next' on 2011-06-01 at 4f44a91)
 + builtin/commit.c: set status_format _after_ option parsing
 + t7508: demonstrate status's failure to use --porcelain format with -z

Will merge to "master" before 1.7.6-rc1.

* ef/maint-win-verify-path (2011-05-27) 3 commits
  (merged to 'next' on 2011-06-01 at f316f68)
 + verify_path: consider dos drive prefix
 + real_path: do not assume '/' is the path seperator
 + A Windows path starting with a backslash is absolute

Will cook a bit longer.

* jc/apply-nsbp (2011-05-27) 4 commits
 - War on nbsp: teach "git apply" to check and fix nbsp
 - War on nbsp: Add "nbsp" whitespace breakage class
 - War on nbsp: a bit of retreat
 - ws.c: add a helper to format comma separated messages

Will probably drop.
It was fun to write, though.

* jn/gitweb-js-blame (2011-05-27) 3 commits
  (merged to 'next' on 2011-06-01 at a984a1b)
 + gitweb.js: use setTimeout rather than setInterval in blame_incremental.js
 + gitweb.js: No need for loop in blame_incremental's handleResponse()
 + gitweb.js: No need for inProgress in blame_incremental.js

Will cook a bit longer.

* mg/diff-stat-count (2011-05-27) 4 commits
  (merged to 'next' on 2011-06-01 at 5cdb776)
 + diff --stat-count: finishing touches
 + diff-options.txt: describe --stat-{width,name-width,count}
 + diff: introduce --stat-lines to limit the stat lines
 + diff.c: omit hidden entries from namelen calculation with --stat

Not urgent. Will not merge before 1.7.6.

* da/git-prefix-everywhere (2011-06-02) 4 commits
  (merged to 'next' on 2011-06-02 at 2ab66e7)
 + t/t7503-pre-commit-hook.sh: Add GIT_PREFIX tests
  (merged to 'next' on 2011-05-30 at 9480900)
 + git-mergetool--lib: Make vimdiff retain the current directory
 + git: Remove handling for GIT_PREFIX
 + setup: Provide GIT_PREFIX to built-ins

Not urgent. Will not merge before 1.7.6.

* jc/streaming-filter (2011-05-26) 8 commits
 - t0021: test application of both crlf and ident
 - t0021-conversion.sh: fix NoTerminatingSymbolAtEOF test
 - streaming: filter cascading
 - streaming filter: ident filter
 - Add LF-to-CRLF streaming conversion
 - stream filter: add "no more input" to the filters
 - Add streaming filter API
 - convert.h: move declarations for conversion from cache.h
 (this branch uses jc/streaming.)

Trivial lf-to-crlf and ident conversions can be performed without reading
everything in-core first.

Not urgent. Will not merge before 1.7.6.

* jk/combine-diff-binary-etc (2011-05-24) 5 commits
  (merged to 'next' on 2011-05-24 at 07cf180)
 + combine-diff: respect textconv attributes
 + refactor get_textconv to not require diff_filespec
 + combine-diff: handle binary files as binary
 + combine-diff: calculate mode_differs earlier
 + combine-diff: split header printing into its own function

Not urgent. Will not merge before 1.7.6.

* jc/advice-about-to-lose-commit (2011-05-24) 1 commit
  (merged to 'next' on 2011-05-30 at 42385cc)
 + checkout: make advice when reattaching the HEAD less loud

Not urgent. Will not merge before 1.7.6.

* jc/streaming (2011-05-26) 14 commits
  (merged to 'next' on 2011-05-26 at 7fdda8d)
 + sha1_file: use the correct type (ssize_t, not size_t) for read-style function
  (merged to 'next' on 2011-05-23 at 7fd0b52)
 + streaming: read loose objects incrementally
 + sha1_file.c: expose helpers to read loose objects
 + streaming: read non-delta incrementally from a pack
 + streaming_write_entry(): support files with holes
 + convert: CRLF_INPUT is a no-op in the output codepath
 + streaming_write_entry(): use streaming API in write_entry()
 + streaming: a new API to read from the object store
 + write_entry(): separate two helper functions out
 + unpack_object_header(): make it public
 + sha1_object_info_extended(): hint about objects in delta-base cache
 + sha1_object_info_extended(): expose a bit more info
 + packed_object_info_detail(): do not return a string
 + Merge branches 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming
 (this branch is used by jc/streaming-filter.)

Not urgent. Will not merge before 1.7.6.

* ab/i18n-scripts (2011-05-21) 48 commits
  (merged to 'next' on 2011-05-23 at 69164a3)
 + i18n: git-bisect bisect_next_check "You need to" message
 + i18n: git-bisect [Y/n] messages
 + i18n: git-bisect bisect_replay + $1 messages
 + i18n: git-bisect bisect_reset + $1 messages
 + i18n: git-bisect bisect_run + $@ messages
 + i18n: git-bisect die + eval_gettext messages
 + i18n: git-bisect die + gettext messages
 + i18n: git-bisect echo + eval_gettext message
 + i18n: git-bisect echo + gettext messages
 + i18n: git-bisect gettext + echo message
 + i18n: git-bisect add git-sh-i18n
 + i18n: git-stash drop_stash say/die messages
 + i18n: git-stash "unknown option" message
 + i18n: git-stash die + eval_gettext $1 messages
 + i18n: git-stash die + eval_gettext $* messages
 + i18n: git-stash die + eval_gettext messages
 + i18n: git-stash die + gettext messages
 + i18n: git-stash say + gettext messages
 + i18n: git-stash echo + gettext message
 + i18n: git-stash add git-sh-i18n
 + i18n: git-submodule "blob" and "submodule" messages
 + i18n: git-submodule "path not initialized" message
 + i18n: git-submodule "[...] path is ignored" message
 + i18n: git-submodule "Entering [...]" message
 + i18n: git-submodule $errmsg messages
 + i18n: git-submodule "Submodule change[...]" messages
 + i18n: git-submodule "cached cannot be used" message
 + i18n: git-submodule $update_module say + die messages
 + i18n: git-submodule die + eval_gettext messages
 + i18n: git-submodule say + eval_gettext messages
 + i18n: git-submodule echo + eval_gettext messages
 + i18n: git-submodule add git-sh-i18n
 + i18n: git-pull eval_gettext + warning message
 + i18n: git-pull eval_gettext + die message
 + i18n: git-pull die messages
 + i18n: git-pull add git-sh-i18n
 + i18n: git-am printf(1) message to eval_gettext
 + i18n: git-am core say messages
 + i18n: git-am "Falling back" say message
 + i18n: git-am "Apply?" message
 + i18n: git-am clean_abort messages
 + i18n: git-am cannot_fallback messages
 + i18n: git-am die messages
 + i18n: git-am gettext + gettext to stderr message
 + i18n: git-am eval_gettext messages
 + i18n: git-am multi-line getttext $msg; echo
 + i18n: git-am one-line gettext $msg; echo
 + i18n: git-am add git-sh-i18n

Rerolled.
Will cook a bit longer.
