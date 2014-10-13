From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking summary snapshot
Date: Mon, 13 Oct 2014 16:29:23 -0700
Message-ID: <xmqqzjczzgz0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 14 01:29:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdp3c-0007df-MN
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 01:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbaJMX31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 19:29:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752554AbaJMX30 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 19:29:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F56D16385;
	Mon, 13 Oct 2014 19:29:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	7tvQ1jMVTMxIxcOzEckXqMyzls=; b=AkfmGb0m60OTEXeOQvavIybO/mTBYtwof
	0448SbQCwrwqk9bWT6j6Y6+0giW3/0OaiUBCc0HvA/89tfnSgTd/1Z7jwj2Gml58
	/17GVwAbIzx05Ce1OidvYCIy/hOBrXFOabN6gYgYn3KMNc9bXFk6o6pX9ugYZ5Bf
	V/zBM5fMfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=LvC
	sVlZMytWgP32kqS+2pT+A44IQvCbAgk0aez/l359+YLuTrY8a2PcjRVmNYDKzRsj
	ou5O5BpvuW9Wuh9SZhpVQOQv6N5hJDTL7YbUYHNJ5hf0BzouSuQ0YioykAQeKqpb
	CSGPq8oUBgckv/P5YS8YSFIaJNLnD9fND4kEmXcA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96A9E16384;
	Mon, 13 Oct 2014 19:29:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D03916383;
	Mon, 13 Oct 2014 19:29:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4AE90B0-5330-11E4-9C52-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I do not want to do too many "What's cooking" report, so here is
just a summary of the status of various topics.  Hopefully I'll do
the real one later this week after a few more integrations.

Thanks.


$ Meta/cook -w
Expecting a reroll.
 - jk/makefile                                                  02-05         #16
 - bg/rebase-off-of-previous-branch                             04-16          #1
 - jk/tag-contains                                              06-30          #8
 - jk/prune-mtime                                               10-04         #18

Expecting an Ack/Sign-off or update from Jonathan on the bottom one.
 - jn/parse-config-slot                                         10-07          #2

Expecting the final reroll.
 - rs/ref-transaction                                           09-10         #19

Stalled
 - jc/graph-post-root-gap                                       12-30          #3
 - jn/gitweb-utf8-in-links                                      05-27          #1
 - ss/userdiff-update-csharp-java                               06-02          #2
 - hv/submodule-config                                          06-30          #4
 - jk/pack-bitmap                                               08-04          #1
 - jt/timer-settime                                             08-29          #6

Undecided
 - nd/multiple-work-trees                                       09-27         #32
 - da/mergetool-tool-help                                       10-13          #4
 - eb/no-pthreads                                               10-13          #2
 - cc/interpret-trailers                                        10-13         #11

Waiting for a reroll ($gmane/256591).
 - tr/remerge-diff                                              09-08          #8

Waiting for a reroll.
 - rb/merge-prepare-commit-msg-hook                             01-10          #4
 - ab/add-interactive-show-diff-func-name                       05-12          #2

Waiting for an Ack.
 - je/quiltimport-no-fuzz                                       09-26          #2

Waiting for the final step to lift the hard-limit before sending it out.
 - jc/show-branch                                               03-24          #5

Will hold.
 - tg/perf-lib-test-perf-cleanup                                09-19          #2

Will merge to 'master'.
 + da/include-compat-util-first-in-c                            09-15/10-07    #1
 + so/rebase-doc-fork-point                                     09-29/10-07    #1
 + dt/cache-tree-repair                                         09-30/10-07    #1
 + rs/daemon-fixes                                              10-01/10-07    #3
 + da/completion-show-signature                                 10-07/10-07    #1
 + sk/tag-contains-wo-recursion                                 09-23/10-08    #1
 + mh/lockfile-stdio                                            10-01/10-08    #3
 + rs/sha1-array-test                                           10-01/10-08    #2
 + mh/lockfile                                                  10-01/10-08   #38
 + rs/mailsplit                                                 10-07/10-08    #1
 + rs/more-uses-of-skip-prefix                                  10-07/10-08    #1
 + rs/plug-leak-in-bundle                                       10-07/10-08    #1
 + bc/asciidoc-pretty-formats-fix                               10-08/10-13    #1
 + po/everyday-doc                                              10-10/10-13    #3

Will merge to 'next'.
 - bw/trace-no-inline-getnanotime                               09-29          #1
 - jc/completion-no-chdir                                       10-09          #1
 - bc/asciidoc                                                  10-13          #2
 - jk/test-shell-trace                                          10-13          #3
 - rs/receive-pack-argv-leak-fix                                10-13          #1
 - ta/config-set                                                10-13          #1
 - da/mergetool-temporary-filename                              10-13          #2

Will perhaps drop.
 - mt/patch-id-stable                                           06-10          #1
 - jc/push-cert-hmac-optim                                      09-25          #2
