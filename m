From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2011, #14; Tue, 31)
Date: Tue, 31 May 2011 15:43:22 -0700
Message-ID: <7vhb8aij91.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 00:43:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRXf1-0001D5-Sf
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 00:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835Ab1EaWna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 18:43:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932786Ab1EaWn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 18:43:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A40455E6F;
	Tue, 31 May 2011 18:45:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=O
	seBGhEIsl2BZhU5CSBEco6rgCY=; b=sJi1X7T0h9zvcpjXzlkbRnbqoCPH+LiA2
	vmtBwNiT4sYTIKBx0M6JYhWvu1zJD0l9W2zvAvgdtONa9ieO+zSHXOGJP+eqDlHG
	EvF5V2uIOLHbKO2IpVf2DmdevUpgXG6cqcqVvsuduCLBtZtOUIV9WMHJ3Y+0Md6T
	CCHUTvROdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Qmg
	UxCA4sgLZfyQpreDqBS8W7RqPbS+0BDMNFJdjOdjdSjlWrSmgsJ7Ct46tFkzeLQE
	KWjyrjZPNzCefOBinwkZ5NkMlYa+qGbEMgmxuI9pN5glfl+CnHfwoK8GT32BP4Nf
	sDTE/Cz4mcBaiGm3dJTgAaro7h0bzTivj6/BeuxA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FBBB5E6E;
	Tue, 31 May 2011 18:45:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 50AFB5E6B; Tue, 31 May 2011
 18:45:33 -0400 (EDT)
X-master-at: 090a1a5d95c7b4380e6a52f42add41ead9215ed3
X-next-at: 1dff92d3ec7495803f594a4b47d1663bac6d103a
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2C90E76-8BD7-11E0-A3AE-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174837>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.

We are in week #6 of this cycle. Feature freeze is imminent.

--------------------------------------------------
[New Topics]

* jc/diff-index-quick-exit-early (2011-05-31) 2 commits
 - diff-index --quiet: learn the "stop feeding the backend early" logic
 - Merge remote-tracking branch 'ko/maint' into jc/diff-index-quick-exit-early
 (this branch uses jk/diff-not-so-quick.)

* jk/diff-not-so-quick (2011-05-31) 2 commits
 - diff: futureproof "stop feeding the backend early" logic
 - diff_tree: disable QUICK optimization with diff filter
 (this branch is used by jc/diff-index-quick-exit-early.)

--------------------------------------------------
[Graduated to "master"]

* ab/i18n-envsubst-doc-fix (2011-05-30) 1 commit
  (merged to 'next' on 2011-05-30 at 25ef758)
 + git-sh-i18n--envsubst: add SYNOPSIS section to the documentation

* jc/fmt-req-fix (2011-05-25) 1 commit
  (merged to 'next' on 2011-05-25 at 9f46ca0)
 + userformat_find_requirements(): find requirement for the correct format

* jc/log-quiet-fix (2011-05-28) 1 commit
  (merged to 'next' on 2011-05-30 at dcbdbc0)
 + log: --quiet should serve as synonym to -s

* jk/format-patch-am (2011-05-26) 5 commits
  (merged to 'next' on 2011-05-30 at 29d5dac)
 + format-patch: preserve subject newlines with -k
 + clean up calling conventions for pretty.c functions
 + pretty: add pp_commit_easy function for simple callers
 + mailinfo: always clean up rfc822 header folding
 + t: test subject handling in format-patch / am pipeline

* jk/format-patch-empty-prefix (2011-05-30) 1 commit
 - format-patch: make zero-length subject prefixes prettier

* jk/maint-config-alias-fix (2011-05-24) 4 commits
  (merged to 'next' on 2011-05-25 at 25b86e4)
 + handle_options(): do not miscount how many arguments were used
 + config: always parse GIT_CONFIG_PARAMETERS during git_config
 + git_config: don't peek at global config_parameters
 + config: make environment parsing routines static

* jk/maint-docs (2011-05-26) 4 commits
  (merged to 'next' on 2011-05-30 at 0ed19d6)
 + docs: fix some antique example output
 + docs: make sure literal "->" isn't converted to arrow
 + docs: update status --porcelain format
 + docs: minor grammar fixes to git-status

* jk/maint-remote-mirror-safer (2011-05-26) 1 commit
  (merged to 'next' on 2011-05-30 at dc260ff)
 + remote: allow "-t" with fetch mirrors

* jk/read-in-full-stops-on-error (2011-05-26) 1 commit
  (merged to 'next' on 2011-05-30 at 102a220)
 + read_in_full: always report errors

* jk/rebase-head-reflog (2011-05-27) 2 commits
  (merged to 'next' on 2011-05-30 at 97f02df)
 + rebase: write a reflog entry when finishing
 + rebase: create HEAD reflog entry when aborting

* jl/read-tree-m-dry-run (2011-05-25) 2 commits
  (merged to 'next' on 2011-05-30 at 42febaf)
 + Teach read-tree the -n|--dry-run option
 + unpack-trees: add the dry_run flag to unpack_trees_options

* jn/doc-remote-helpers (2011-05-30) 1 commit
 - Documentation: do not misinterpret refspecs as bold text

* kk/maint-prefix-in-config-mak (2011-05-27) 1 commit
  (merged to 'next' on 2011-05-30 at 35b8752)
 + config.mak.in: allow "configure --sysconfdir=/else/where"

--------------------------------------------------
[Stalled]

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this.

* jc/index-pack (2011-02-27) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

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

* bc/maint-status-z-to-use-porcelain (2011-05-29) 2 commits
 - builtin/commit.c: set status_format _after_ option parsing
 - t7508: demonstrate status's failure to use --porcelain format with -z

Will merge to "next".

* ef/maint-win-verify-path (2011-05-27) 3 commits
 - verify_path: consider dos drive prefix
 - real_path: do not assume '/' is the path seperator
 - A Windows path starting with a backslash is absolute

J6t had a reasonable question in the discussion; has it been resolved?

* jc/apply-nsbp (2011-05-27) 4 commits
 - War on nbsp: teach "git apply" to check and fix nbsp
 - War on nbsp: Add "nbsp" whitespace breakage class
 - War on nbsp: a bit of retreat
 - ws.c: add a helper to format comma separated messages

Will probably drop.
It was fun to write, though.

* jn/gitweb-js-blame (2011-05-27) 3 commits
 - gitweb.js: use setTimeout rather than setInterval in blame_incremental.js
 - gitweb.js: No need for loop in blame_incremental's handleResponse()
 - gitweb.js: No need for inProgress in blame_incremental.js

Will cook a bit longer.

* mg/diff-stat-count (2011-05-27) 4 commits
 - diff --stat-count: finishing touches
 - diff-options.txt: describe --stat-{width,name-width,count}
 - diff: introduce --stat-lines to limit the stat lines
 - diff.c: omit hidden entries from namelen calculation with --stat

Will merge to "next".

* da/git-prefix-everywhere (2011-05-26) 3 commits
  (merged to 'next' on 2011-05-30 at 9480900)
 + git-mergetool--lib: Make vimdiff retain the current directory
 + git: Remove handling for GIT_PREFIX
 + setup: Provide GIT_PREFIX to built-ins

Will cook a bit longer.

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
