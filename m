From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Mon, 04 Jan 2010 21:57:46 -0800
Message-ID: <7vskal5c11.fsf@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 06:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS2S9-0002Lz-J3
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 06:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907Ab0AEF5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 00:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797Ab0AEF5w
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 00:57:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0AEF5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 00:57:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B78248E12A;
	Tue,  5 Jan 2010 00:57:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jDLaOZ5e1hY0ghTbYyomDH5Mynk=; b=jkkWgz
	kY6rBkXOwMoNIHC8suoGbK1l7CrRWcLxr4n2WOwUyT3/r5HWIN7uB5gMzG2JhR92
	Zyj4AaSVXNbSdDDMlU9zX+0A8nDyLUq6b+yXR+b0Q3QrlNH/LI8IvTL2fuXsLCWk
	VdQVE6xBgCcuGmWq5yZQmZZ9VU8ECtEHk6OOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gWGDekF+ojcMebWswGRdQ0GwvC7Ms0Rx
	rmy8sjGzdE8/VHgZ1kg6v7UyXYnqPHRcC63a9QMMpHJ2I7e+4XEdgXolCSC6BHM3
	UhEeI8NyiukqjwrJ01UpnPoUCGELr2eHQJFZg2Pgx147xGapV1jE4koH9sC10beB
	iHmrI3ftkH8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A485E8E127;
	Tue,  5 Jan 2010 00:57:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E94DD8E126; Tue,  5 Jan
 2010 00:57:47 -0500 (EST)
In-Reply-To: <7vljgei7rs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 04 Jan 2010 00\:39\:03 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 413EE83A-F9BF-11DE-80E3-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136165>

I am tempted to merge the following to 'next' soonish; please complain and
stop me before I do so in a few days if there are issues.

 * da/difftool (2009-12-22) 2 commits
 * jh/gitweb-cached (2010-01-03) 4 commits
 * tc/test-locate-httpd (2010-01-02) 1 commit
 * tc/smart-http-restrict (2010-01-02) 4 commits
 * jc/branch-d (2009-12-29) 1 commit
   http://thread.gmane.org/gmane.comp.version-control.git/135837/focus=135863
 * mm/diag-path-in-treeish (2009-12-07) 1 commit
 * mh/rebase-fixup (2009-12-07) 2 commits
 * ns/rebase-auto-squash (2009-12-08) 2 commits
 * fc/opt-quiet-gc-reset (2009-12-02) 1 commit
 * tr/http-push-ref-status (2009-12-24) 6 commits
   Daniel and Jeff commented on the earlier rounds; is everybody happy with
   this v3?  If so let's move it to 'next'.  If not, please complain.
 * jh/notes (2009-12-07) 11 commits
   I didn't see any negative comments after this round; is everybody happy
   with this?  If so let's move it to 'next'.  If not, please complain.
 * sr/gfi-options (2009-12-04) 7 commits
   I didn't see any negative comments after this round; is everybody happy
   with this?  If so let's move it to 'next'.  If not, please complain.

----------------------------------------------------------------
I expect the following to be in 'master' by the end of next week.

 * bg/maint-remote-update-default (2009-12-31) 1 commit
 * jk/maint-1.6.5-reset-hard (2009-12-30) 1 commit
 * jk/push-to-delete (2009-12-30) 1 commit
 * mm/config-path (2009-12-30) 1 commit
 * pm/cvs-environ (2009-12-30) 1 commit
 * so/cvsserver-update (2009-12-07) 1 commit
 * tr/maint-1.6.5-bash-prompt-show-submodule-changes (2009-12-31) 1 commit
 * js/filter-branch-prime (2009-12-15) 1 commit
 * mg/tag-d-show (2009-12-10) 1 commit
 * sb/maint-octopus (2009-12-11) 3 commits
 * bg/maint-add-all-doc (2009-12-07) 4 commits
 * mv/commit-date (2009-12-03) 2 commits
 * mo/bin-wrappers (2009-12-02) 3 commits
 * tr/http-updates (2009-12-28) 4 commits
 * nd/sparse (2009-12-30) 23 commits

----------------------------------------------------------------

These need a bit more work to go forward.  Help and follow-up are
appreciated.

 * jc/fix-tree-walk (2009-09-14) 7 commits
   Resurrected from "Ejected" category.  This is a fix to a tricky
   codepath and testing and improving before it hits 'next' by brave souls
   is greatly appreciated.  I am not very happy about the solution myself.

 * tc/clone-v-progress (2009-12-26) 4 commits
   Perhaps needs an entry in the Release Notes, but otherwise looked Ok.

 * jh/commit-status (2009-12-07) 1 commit
   Needs tests.

 * jc/checkout-merge-base (2009-11-20) 2 commits
   Users of "rebase -i" might want to teach this to the command.
   Volunteers?

 * il/vcs-helper (2009-12-09) 8 commits
   According to http://thread.gmane.org/gmane.comp.version-control.git/134980
   this is very close to completion (or did I overlook a reroll after that?)
   but the final touch is not there yet.
