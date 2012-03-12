From: Junio C Hamano <gitster@pobox.com>
Subject: Incremental highlights from next issue of "What's cooking"
Date: Mon, 12 Mar 2012 16:51:38 -0700
Message-ID: <7vr4wxml85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 13 00:51:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7F1m-0002Ob-Ol
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 00:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758121Ab2CLXvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 19:51:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757757Ab2CLXvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 19:51:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BCE017BE4;
	Mon, 12 Mar 2012 19:51:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	TfvIW1T1cBjJIRA2hNMBTpu8Ps=; b=Rr85yze0sN7+/pZjCV+ReKQy0g6B8YoqZ
	+3xeOqwWqWF/SKoCS7kMlAjjHIpDNyB3q/mE5LbmXmEM7yy+8NfzqQGpWte7a9vZ
	IX+mXn/Xtc98PAxlpjWBTA4lLN0QJSXWyCffXWFFratbZozYMjuT9rOVKOCyzmzl
	ftgjdWI5FM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Vqf
	a2vvsOSulod5SdCS1uEaVmP/lsMpjdowxKsLYo6z0J6442VmNQ5Q6HHM2UlntvJ0
	zNvTO2AajuIjzNK3zWyZOtRlh48X4TM8CAVsUrSuWK7L0OBvX/5frMWKTRNiFQO0
	xWI0ZzDB74B98q0EpHetUuyWlvQ5zcXSiT1x14ps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B405E7BE3;
	Mon, 12 Mar 2012 19:51:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4723D7BE1; Mon, 12 Mar 2012
 19:51:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5024661E-6C9E-11E1-AFC2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192965>

Here is the summary of my thinking regarding individual topics in
flight (stalled ones are omitted).

Undecided are mostly "my not thinking" ;-)  If any of these (or the
ones marked as "will defer") is critical for 1.7.10, please holler.

-- >8 --

Needs more work; results in double-frees.
 - cn/apply-fix-ws-can-lengthen-lines                           03-11          #1

Undecided
 + jc/i18n-shell-script-gettext                                 03-12/03-12    #1
 - jc/diff-algo-cleanup                                         02-19          #2
 - jh/apply-free-patch                                          03-07          #1
 - jn/maint-fast-import-empty-ls                                03-09          #2
 - mm/push-default-switch-warning                               03-09          #1
 - sl/customize-sane-tool-path                                  03-09          #1
 - ab/perl-i18n                                                 03-10          #3
 - jc/run-hook-env-1                                            03-11          #4
 - nd/threaded-index-pack                                       03-11          #2
 - jh/notes-merge-in-git-dir-worktree                           03-12          #2

Will defer til 1.7.10.
 + rs/unpack-trees-leakfix                                      03-06/03-07    #1
 + nd/stream-more                                               03-07/03-07    #7
 + jc/fmt-merge-msg-people                                      03-08/03-08    #3
 + jc/commit-hook-authorship                                    03-11/03-12    #3
 - nl/http-proxy-more                                           03-12          #4

Will discard.
 + tb/maint-remove-irrelevant-i18n-test                         03-06/03-07    #1

Will merge to 'master' by 1.7.10.
 + ph/rerere-doc                                                03-08/03-12    #1
 + jc/maint-undefined-i18n-observation-test                     03-09/03-12    #1
 + ms/maint-config-error-at-eol-linecount                       03-12/03-12    #1
