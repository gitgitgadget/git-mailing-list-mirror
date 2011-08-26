From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.7-rc0 tagged and pushed out
Date: Fri, 26 Aug 2011 16:20:20 -0700
Message-ID: <7vobzbbw0b.fsf@alter.siamese.dyndns.org>
References: <7vwrdzbwrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 01:20:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx5hM-0002O6-C7
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 01:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1HZXUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 19:20:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab1HZXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 19:20:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00D53494C;
	Fri, 26 Aug 2011 19:20:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e4IJAuyXXZ/xQQ8bQdg864xIdMA=; b=ctHqcR
	dO5ASwTXNDG62SzgSc9S1vKDuKUCHee5jzt9XZ5pwQRQGXQoqXw8IDKxK5X/sh+4
	ZTs5++a1KVLMA+XW6beyDiJHxzECSl/lOGKfdPGNqZhPr+xdKFg5Y6JQ+hNdB4xN
	HFRD6xaDNMMYIeMT8lQVDCOHXCt5y39YiycAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PnLhG6gxwROyihEQ7CMW/qvNL4j/U3tB
	2Um8KWtxf1/0HFysAEToVjMAN91a6BWk9N5WpbTQROh+HCY9mtyQWY1v0w5cLuqc
	XX2HvE8R43W6fOUs41oFtrdX7TnwCVGuYKtY+pID+NLrsn0jWl7qBFg5wNFxdymg
	Vku2vgRk98s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECF4B494B;
	Fri, 26 Aug 2011 19:20:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6179B494A; Fri, 26 Aug 2011
 19:20:22 -0400 (EDT)
In-Reply-To: <7vwrdzbwrt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 26 Aug 2011 16:03:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8A071A4-D039-11E0-8F24-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180210>

Junio C Hamano <gitster@pobox.com> writes:

> ... and I think I've collected all the recent leftover topics from the
> list that are at least going in the right direction if not perfect and
> queued them to update 'pu'.

Here is a preview of the "New Topics" section of the next "What's
cooking".


[New Topics]

* mg/maint-notes-C-doc (2011-08-25) 1 commit
 - git-notes.txt: clarify -C vs. copy and -F

* jc/clean-exclude-doc (2011-08-26) 1 commit
 - Documentation: clarify "git clean -e <pattern>"

* mh/check-ref-format-print-normalize (2011-08-25) 1 commit
 - check-ref-format --print: Normalize refnames that start with slashes

These tiny clean-up topics could go to 1.7.7 final. On the other hand,
they are not urgent, either.

* bk/ancestry-path (2011-08-25) 3 commits
 - revision: do not include sibling history in --ancestry-path output
 - revision: keep track of the end-user input from the command line
 - rev-list: Demonstrate breakage with --ancestry-path --all

The topic came up a bit too late in the cycle.

* mg/branch-list (2011-08-26) 5 commits
 - branch: allow pattern arguments
 - branch: introduce --list option
 - git-branch: introduce missing long forms for the options
 - git-tag: introduce long forms for the options
 - t6040: test branch -vv
 (this branch uses nk/branch-v-abbrev.)

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
 (this branch uses fg/submodule-ff-check-before-push, fg/submodule-ff-check-before-push and jc/combine-diff-callback.)

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
