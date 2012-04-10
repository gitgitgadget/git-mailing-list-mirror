From: Junio C Hamano <gitster@pobox.com>
Subject: Post 1.7.10 cycle
Date: Mon, 09 Apr 2012 17:22:05 -0700
Message-ID: <7v1unwtp02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 02:22:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHOqi-0000qR-36
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 02:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250Ab2DJAWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 20:22:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab2DJAWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 20:22:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66B876470;
	Mon,  9 Apr 2012 20:22:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=8
	8p9tVrS98czh6+BvMz6JsxOLNA=; b=qBFz7D2Knv1I4UZ1i6YvBfh/DcJiEjbHn
	W0zmh61GP8+7SdyCkeGjwSudeoPVHbVfHi5WoWaYcVyhoQHfmWAQBbqbOkkyfbno
	u7Tyywhmnb+RUe5xQDaCOPWetN0brg1Nl0cAq9P7zvkrWcVuwV/cmGHoNRoDH5s+
	SWPeJQGqAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=XuR
	P1TkBxCBvypBZUdBZeVMl0cICTBRLeuYF2kQWZharlj8YBwKbVAkCwEv91XzQ9qQ
	DbICap0TyEvcuk1wlbT1I7APB2p835dO3G+8mNPniES/ToDTPfgc4f3grpw0x7cI
	IIRFMNA6hhNJd8rK+GQZKFu8/zVLNi4LYuDSpi0o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58370646F;
	Mon,  9 Apr 2012 20:22:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E131B646E; Mon,  9 Apr 2012
 20:22:06 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 347716F8-82A3-11E1-B70A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195050>

It's now time to pick among the topics that have been cooking in 'next'
and 'pu' which ones to start moving to 'master' in what order.

I've already kicked one topic out of 'next' as it regresses the http proxy
support, but I haven't spent enough time to look at the other topics again
closely enough to decide.  I was hoping that we could feed a handful of
topics every few days to 'master'.

I think the following topics (in 'next') are more or less ready:

da/difftool-test
jn/diffstat-tests
jc/commit-hook-authorship
tr/maint-word-diff-regex-sticky
rs/unpack-trees-leakfix
jc/diff-algo-cleanup
nd/stream-more
zj/test-cred-helper-nicer-prove
nl/rebase-i-cheat-sheet
jc/maint-clean-nested-worktree-in-subdir
jh/notes-merge-in-git-dir-worktree

These (in 'next') are "ready" code-wise, but we would need to see the end
of the "upstream", "current" or "beginner" discussion:

ct/advise-push-default
mm/push-default-switch-warning


And I think these in 'pu' are ready for 'next':

jk/diff-no-rename-empty
rs/combine-diff-zero-context-at-the-beginning
jc/commit-unedited-template
jk/http-backend-keep-committer-ident-env
jc/push-upstream-sanity
jk/branch-quiet
jc/run-hook-env-1
sl/autoconf
jb/am-include
jc/am-report-3way
jc/fmt-merge-msg-people
wk/gitweb-snapshot-use-if-modified-since
bw/spawn-via-shell-path
it/fetch-pack-many-refs
jn/debian-customizes-default-editor
jk/add-p-skip-conflicts


Others not listed here fall into one of the following categories:

 (1) known to be incomplete;
 (2) stalled;
 (3) I simply haven't stared at them long enough; or
 (4) I don't have strong opinion in the area in general.

I'll do a proper "What's cooking" later tonight or tomorrow.
