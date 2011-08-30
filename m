From: Junio C Hamano <gitster@pobox.com>
Subject: Not yet 1.7.7-rc1 but...
Date: Mon, 29 Aug 2011 19:32:15 -0700
Message-ID: <7v62lf4ok0.fsf_-_@alter.siamese.dyndns.org>
References: <7vwrdzbwrt.fsf@alter.siamese.dyndns.org>
 <7vobzbbw0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 04:32:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyE7r-0004dR-Tf
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 04:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab1H3CcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 22:32:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab1H3CcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 22:32:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 243F74EA6;
	Mon, 29 Aug 2011 22:32:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OkolRYTiegY9B/BS4L9A1mmz/UM=; b=ukPIY/
	65ImJz4qS9p8gj8Aeo2joEbPIuB1dksGf8XG98Fk8WTEnLJSS20J/z6AAjj2JiXg
	bTU4VsT+rOIKeKv6iOKg3LfcoHZXKElycZnfgPMzVxQhlqrIwGFohSMtCYUjcWhV
	L6x9zX9U4/Z0SbjBXpOaHW0nmM8iAXeBwR2Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yl5v3ABYsNZx5qrIVa43DZ4q0tV877AF
	CnCIHrPGEMfLdAP1UeDm2xkn/0SRr9i+ET0b2VNi7OhnnA11E9tPJ56kKGBQjVDW
	lCO6h31z8eECkXaKZBsXBbztgkRZmXLrjCUcwtDo3XjA8/NH02gQNvVIQ2cutD46
	Ijk9qovgqRY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6CE4EA5;
	Mon, 29 Aug 2011 22:32:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45E4A4EA4; Mon, 29 Aug 2011
 22:32:17 -0400 (EDT)
In-Reply-To: <7vobzbbw0b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 26 Aug 2011 16:20:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4746012A-D2B0-11E0-9A72-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180387>

... here is an updated preview of the "New Topics" section of the next
issue of "What's cooking". People sent in fixes to bugs several topics
that are new in 1.7.7-rc0 have introduced, and while they are still on
the "pu" (proposed updates) branch for tonight, they should and will be
fast tracked to 1.7.7-rc1.

Thanks.

-- >8 --

[New Topics]

* mg/maint-notes-C-doc (2011-08-25) 1 commit
 - git-notes.txt: clarify -C vs. copy and -F

Will merge to "master".

* jc/clean-exclude-doc (2011-08-28) 1 commit
 - Documentation: clarify "git clean -e <pattern>"

Will merge to "master".

* mh/check-ref-format-print-normalize (2011-08-27) 2 commits
 - Forbid DEL characters in reference names
 - check-ref-format --print: Normalize refnames that start with slashes

Will merge to "master".

* bk/ancestry-path (2011-08-25) 3 commits
 - revision: do not include sibling history in --ancestry-path output
 - revision: keep track of the end-user input from the command line
 - rev-list: Demonstrate breakage with --ancestry-path --all

The topic came up a bit too late in the cycle.
Will cook for a while.

* mg/branch-list (2011-08-28) 5 commits
 - branch: allow pattern arguments
 - branch: introduce --list option
 - git-branch: introduce missing long forms for the options
 - git-tag: introduce long forms for the options
 - t6040: test branch -vv

The topic came up a bit too late in the cycle.

* mm/rebase-i-exec-edit (2011-08-26) 2 commits
 - rebase -i: notice and warn if "exec $cmd" modifies the index or the working tree
 - rebase -i: clean error message for --continue after failed exec

The topic came up a bit too late in the cycle.

* jk/default-attr (2011-08-26) 1 commit
 - attr: map builtin userdiff drivers to well-known extensions

I fixed up the test breakage just for fun, but this is not urgent.

* hv/submodule-merge-search (2011-08-26) 4 commits
 - submodule: Search for merges only at end of recursive merge
 - allow multiple calls to submodule merge search for the same path
 - submodule: Demonstrate known breakage during recursive merge
 - push: Don't push a repository with unpushed submodules
 (this branch uses fg/submodule-ff-check-before-push.)

The topic came up a bit too late in the cycle.
The bottom one needs to be replaced with a properly written commit log message.

* mm/mediawiki-as-a-remote (2011-08-26) 1 commit
 - Add a remote helper to interact with mediawiki (fetch & push)

Fun.

* nd/maint-autofix-tag-in-head (2011-08-26) 3 commits
 - Accept tags in HEAD or MERGE_HEAD
 - merge: remove global variable head[]
 - merge: keep stash[] a local variable

Probably needs a re-roll to aim a bit higher.

* bc/unstash-clean-crufts (2011-08-27) 4 commits
 - git-stash: remove untracked/ignored directories when stashed
 - t/t3905: add missing '&&' linkage
 - git-stash.sh: fix typo in error message
 - t/t3905: use the name 'actual' for test output, swap arguments to test_cmp

* bg/t5540-osx-grep (2011-08-28) 1 commit
 - t5540-http-test: shorten grep pattern

Will merge to "master".

* cb/maint-ls-files-error-report (2011-08-28) 1 commit
 - t3005: do not assume a particular order of stdout and stderr of git-ls-files

Will merge to "master".

* da/make-auto-header-dependencies (2011-08-27) 1 commit
 - Makefile: Improve compiler header dependency check
 (this branch uses fk/make-auto-header-dependencies.)

* ms/daemon-timeout-is-in-seconds (2011-08-28) 1 commit
 - git-daemon.txt: specify --timeout in seconds

Will merge to "master".

* bc/bisect-test-use-shell-path (2011-08-29) 1 commit
 - t6030: use $SHELL_PATH to invoke user's preferred shell instead of bare sh

Will merge to "master".

* gb/am-hg-patch (2011-08-29) 1 commit
 - am: preliminary support for hg patches

* gb/maint-am-patch-format-error-message (2011-08-29) 1 commit
 - am: format is in $patch_format, not parse_patch

Will merge to "master".

* gb/maint-am-stgit-author-to-from-fix (2011-08-29) 1 commit
 - am: fix stgit patch mangling

Will merge to "master".

* jc/diff-index-unpack (2011-08-29) 3 commits
 - diff-index: pass pathspec down to unpack-trees machinery
 - unpack-trees: allow pruning with pathspec
 - traverse_trees(): allow pruning with pathspec

Will cook for a while.

* tr/maint-format-patch-empty-output (2011-08-29) 4 commits
 - Document negated forms of format-patch --to --cc --add-headers
 - t4014: "no-add-headers" is actually called "no-add-header"
 - t4014: invoke format-patch with --stdout where intended
 - t4014: check for empty files from git format-patch --stdout

Will merge to "master".

* tr/maint-ident-to-git-memmove (2011-08-29) 1 commit
 - Use memmove in ident_to_git

Will merge to "master".

* tr/maint-strbuf-grow-nul-termination (2011-08-29) 1 commit
 - strbuf_grow(): maintain nul-termination even for new buffer

Will merge to "master".

* tr/maint-t3903-misquoted-command (2011-08-29) 1 commit
 - t3903: fix misquoted rev-parse invocation

Will merge to "master".

* va/p4-branch-import-test-update (2011-08-29) 1 commit
 - git-p4: simple branch tests edits

Will merge to "master".
