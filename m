Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB5620189
	for <e@80x24.org>; Sun, 19 Jun 2016 22:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbcFSWwU (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 18:52:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751423AbcFSWwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 18:52:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E99626200;
	Sun, 19 Jun 2016 18:52:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	Mzx5r2eerHYrKnbcVe3D5F/K0g=; b=jmp3QeFQEuRi3Cw8S9NejQmNJmfi/SZNC
	YGn83kJFhNp30JQX7GW03puL5f6wqcV0DoLjLqIv1QmWEKqSCvuQZsm9al2Cp5/p
	INlyWCvT5LRgVRJThxMycmBOw53ChafoAQUaPriywzOLl/p96FhKJU2RpykROqad
	9uxMUrFRC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=l/U
	UKMnXi01tEMRHkBI0e4tii/1ylKgR9VtFoLSa/twflivEzIG1+KXwT9iy+ONGvOh
	k+nJoqIJT0CAfbn2JVERPK28r/ZJ3Wlg08MvWd7tWZNY4sWrwiYtQ4i4Cg22Qq4n
	/1hq8orWjMARppdLbK82+mMPWu7rbnGt8ZS+KMx0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 274DB261FF;
	Sun, 19 Jun 2016 18:52:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A744E261FE;
	Sun, 19 Jun 2016 18:52:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	git@vger.kernel.org
Subject: Short-term plans for the post 2.9 cycle
Date:	Sun, 19 Jun 2016 15:52:04 -0700
Message-ID: <xmqqh9covlkb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72852ACC-3670-11E6-B33F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Here are the list of topics that are in the "private edition" I use
for every day work, grouped by where they sit in the the near-term
plan of merging them up to 'next' and then to 'master'.

These will be merged to 'master' soonish.

 ew/fast-import-unpack-limit
 ah/no-verify-signature-with-pull-rebase
 ew/daemon-socket-keepalive
 sb/submodule-misc-cleanups
 sb/submodule-recommend-shallowness
 et/pretty-format-c-auto
 jg/dash-is-last-branch-in-worktree-add
 aq/upload-pack-use-parse-options
 jc/clear-pathspec
 wd/userdiff-css
 jk/rev-list-count-with-bitmap
 rs/xdiff-hunk-with-func-line

These will be in 'next' immediately after the above gets merged to
'master'.

 cc/apply-introduce-state

These have been in 'next', but will be kicked back to give them
chance to clean up when 'next' is rewound.

 mh/split-under-lock
 mh/ref-iterators
 jc/attr
 sb/pathspec-label

These are expected to be merged to 'next' in the first batch after
'next' gets rewound.

 pc/occurred
 tr/doc-tt
 ap/git-svn-propset-doc
 jk/fetch-prune-doc
 dn/gpg-doc
 pb/strbuf-read-file-doc
 lf/receive-pack-auto-gc-to-client
 mg/cherry-pick-multi-on-unborn
 sg/reflog-past-root
 vs/prompt-avoid-unset-variable
 rj/compat-regex-size-max-fix
 jk/avoid-unbounded-alloca
 et/add-chmod-x
 jc/deref-tag
 nb/gnome-keyring-build
 lv/status-say-working-tree-not-directory
 tb/complete-status
 em/newer-freebsd-shells-are-fine-with-returns

These are the second batch for 'next'.

 km/fetch-do-not-free-remote-name
 jk/parseopt-string-list
 jk/string-list-static-init
 lf/sideband-returns-void
 jk/bisect-show-tree
 jk/add-i-diff-compact-heuristics
 jk/big-and-future-archive-tar
 jk/send-pack-stdio
 lf/recv-sideband-cleanup
 pb/commit-editmsg-path
 nd/test-lib-httpd-show-error-log-in-verbose
 ep/http-curl-trace

These are the third batch.

 mh/connect
 ew/mboxrd-format-am
 jk/repack-keep-unreachable
 jk/gpg-interface-cleanup
 sb/submodule-clone-retry
 mg/signature-doc

These are the fourth.

 nd/worktree-cleanup-post-head-protection
 jk/upload-pack-hook
 nd/graph-width-padded
 nd/shallow-deepen
 sb/submodule-default-paths
 nd/worktree-lock

These are the remainder.

 jc/blame-reverse
 jc/send-email-skip-backup
 va/i18n-even-more
 dt/index-helper
 dk/blame-move-no-reason-for-1-line-context
 sb/clone-shallow-passthru

Some of them that are regression fixes may need to jump the queue
and land on 'master' earlier than others.
