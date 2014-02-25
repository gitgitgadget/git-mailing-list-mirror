From: Junio C Hamano <gitster@pobox.com>
Subject: [FYI] 'next' will be rewound shortly
Date: Mon, 24 Feb 2014 16:33:31 -0800
Message-ID: <xmqqeh2s6nfo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 25 01:33:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI5xs-0000GH-QN
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 01:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaBYAdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 19:33:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37569 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbaBYAdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 19:33:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8B516F320;
	Mon, 24 Feb 2014 19:33:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	b52gpR+UmBowq9m2RzDCJD6+Mg=; b=xUCOaGpj8BnEosIrHP+8WrnlN2umfhWR8
	gD+qp+/UYnN9QQ+w9N1s8iNBLCcUB3RzggnHpKtklyL3l0qwT0SGnF5lNPy0oqai
	3212/HTnxV0r0KFigLus/wL5XVgp+kWGjUbqDkcnmc7c1L87xx+6GWYF4SPKfqHB
	5xFkPJ2v+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=yQC
	Mp5n9gY4WNspLJzpxO4ArokzYgb4CT4JmLaPlAaVbcLDKkpMVOzH32t/n7DflzJs
	Bix9Ziuj+9zqFmXrG3SNTgygL7FQR+r+uH0uz8ZWEIaS483/XTBwWRve2gcZC8lB
	ejgEIboyINysL7tmVb6WE3eGpXbihhisd2CFXr7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF6C66F31D;
	Mon, 24 Feb 2014 19:33:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 099E16F314;
	Mon, 24 Feb 2014 19:33:33 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 756539D2-9DB4-11E3-875F-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242658>

Just a quick heads-up.  

As the first wave for the post-1.9.0 development cycle, these topics
will be merged to 'master' (unless there are serious last minute
issues found) shortly:

 + kb/fast-hashmap                                              02-24/01-03   #18
 + nv/commit-gpgsign-config                                     02-24/01-03    #3
 + da/pull-ff-configuration                                     01-15/01-22    #2
 + bk/refresh-missing-ok-in-merge-recursive                     02-24/01-29    #4
 + ds/rev-parse-required-args                                   01-28/01-31    #1
 + jk/config-path-include-fix                                   01-28/01-31    #2
 + bs/stdio-undef-before-redef                                  01-31/01-31    #1
 + ep/varscope                                                  01-31/01-31    #7
 + nd/submodule-pathspec-ending-with-slash                      02-24/01-31    #8
 + nd/diff-quiet-stat-dirty                                     02-24/01-31    #2
 + nd/test-rename-reset                                         02-04/02-06    #1
 + mw/symlinks                                                  02-04/02-06    #6
 + ks/tree-diff-walk                                            02-24/02-06    #5
 + wk/submodule-on-branch                                       02-24/02-06    #4
 + nd/reset-intent-to-add                                       02-05/02-07    #1
 + jk/test-ports                                                02-10/02-13    #2
 + al/docs                                                      02-11/02-13    #4
 + bc/gpg-sign-everywhere                                       02-11/02-13    #9
 + jk/pack-bitmap                                               02-12/02-13   #26
 + nd/http-fetch-shallow-fix                                    02-13/02-13    #7
 + dk/blame-janitorial                                          02-24/02-13    #4

and the tip of 'next' will be rewound at the same time (like, say,
tomorrow).

We may want to merge the 2.0.0 transition topics as the second wave
to 'master' (and starting Documentation/RelNotes/2.0.0.txt) before
merging topics other than the above to it.

There are about 30 more topics that are ready for 'next' (not
counting the ones for 2.0.0 transition), all of which are likely to
be in 'next' soonish.

 + nd/daemonize-gc                                              02-10/02-20    #2
 + jk/run-network-tests-by-default                              02-14/02-20    #1
 + ks/combine-diff                                              02-24/02-20    #6
 - jc/check-attr-honor-working-tree                             02-06          #2
 - nd/gitignore-trailing-whitespace                             02-10          #2
 - ss/completion-rec-sub-fetch-push                             02-11          #1
 - jk/http-no-curl-easy                                         02-18          #1
 - jk/janitorial-fixes                                          02-18          #5
 - ks/config-file-stdin                                         02-18          #4
 - lb/contrib-contacts-looser-diff-parsing                      02-18          #1
 - nd/reset-setup-worktree                                      02-18          #1
 - tr/diff-submodule-no-reuse-worktree                          02-18          #1
 - ak/gitweb-fit-image                                          02-20          #1
 - mh/replace-refs-variable-rename                              02-20          #1
 - nd/no-more-fnmatch                                           02-20          #4
 - rt/links-for-asciidoctor                                     02-20          #1
 - jh/note-trees-record-blobs                                   02-20          #1
 - da/difftool-git-files                                        02-24          #1
 - jk/commit-dates-parsing-fix                                  02-24          #5
 - jk/remote-pushremote-config-reading                          02-24          #1
 - jm/stash-doc-k-for-keep                                      02-24          #1
 - jn/am-doc-hooks                                              02-24          #1
 - mh/object-code-cleanup                                       02-24          #4
 - nd/i18n-progress                                             02-24          #1
 - fc/transport-helper-fixes                                    02-24          #7
 - tg/index-v4-format                                           02-24          #3
 - ks/tree-diff-more                                            02-24         #15

I may be a bit too busy to be able to pick up new topics for a few
days, as the topic-flipping is usually quite time consuming when
some ordering of the topics change, i.e. when rerere stops to be
helpful.

Thanks.
