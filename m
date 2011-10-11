From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking snapshot
Date: Mon, 10 Oct 2011 20:25:24 -0700
Message-ID: <7vlissgqfv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 05:25:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDSyD-0002hP-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 05:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab1JKDZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 23:25:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36750 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab1JKDZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 23:25:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0544668F4;
	Mon, 10 Oct 2011 23:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	dvgvtp4N/sXsVsDiCz75DJGJ6Q=; b=qSYwb4edPagUGLZvOWguG8Ox9PYRTerKc
	xsu3Di0cFd8aq3+uSQP0QK2h6EfBxB9lDwxHeG8xbhs+VMv3xTO/yV9R093isO+n
	oH1CnQJcsrccpGN06NHGPxjoMHkhmXhAFB+H6ddmL5rIR6oI/VtKB/KxucvWqZla
	k3bdJ4jmNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=hUm
	5ZfiQIutS9gbCYWdY/rNS5kmv4w9yT0sTZHocWbuCFxqxgxpzpdbw5yruoC8qD58
	r1kQDEPz8uuhZ+TrjcE1S54lfudygqxM8jkRU43SikwK7dd0KgJhmapaiK8RAy7y
	lH4+q5SJ2xJ9MplhuejXw4lreMXOYdv74ejUuPyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F092168F3;
	Mon, 10 Oct 2011 23:25:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 596CB68F2; Mon, 10 Oct 2011
 23:25:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A976804E-F3B8-11E0-B20F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183279>

I am planning to merge the following topics that are queued in 'pu' to
'next' soonish.

* tm/completion-commit-fixup-squash (2011-10-06) 2 commits
 - completion: commit --fixup and --squash
 - completion: unite --reuse-message and --reedit-message handling
 (this branch is used by sg/completion.)

* tm/completion-push-set-upstream (2011-10-06) 1 commit
 - completion: push --set-upstream

* bc/attr-ignore-case (2011-10-06) 5 commits
 - attr.c: respect core.ignorecase when matching attribute patterns
 - attr: read core.attributesfile from git_default_core_config
 - builtin/mv.c: plug miniscule memory leak
 - cleanup: use internal memory allocation wrapper functions everywhere
 - attr.c: avoid inappropriate access to strbuf "buf" member

* ef/mingw-syslog (2011-10-07) 1 commit
 - mingw: avoid using strbuf in syslog

* jk/name-hash-dirent (2011-10-07) 1 commit
 - fix phantom untracked files when core.ignorecase is set

* rs/pickaxe (2011-10-07) 7 commits
 - pickaxe: factor out pickaxe
 - pickaxe: give diff_grep the same signature as has_changes
 - pickaxe: pass diff_options to contains and has_changes
 - pickaxe: factor out has_changes
 - pickaxe: plug regex/kws leak
 - pickaxe: plug regex leak
 - pickaxe: plug diff filespec leak with empty needle

* tc/fetch-leak (2011-10-07) 1 commit
 - fetch: plug two leaks on error exit in store_updated_refs

* mm/maint-config-explicit-bool-display (2011-10-10) 1 commit
 - config: display key_delim for config --bool --get-regexp

* rs/diff-whole-function (2011-10-10) 2 commits
 - diff: add option to show whole functions as context
 - xdiff: factor out get_func_line()

* sc/difftool-skip (2011-10-10) 1 commit
 - git-difftool: allow skipping file by typing 'n' at prompt

* sg/completion (2011-10-10) 2 commits
 - completion: unite --format and --pretty for 'log' and 'show'
 - completion: unite --reuse-message and --reedit-message for 'notes'
 (this branch uses tm/completion-commit-fixup-squash.)

Comments welcome.
