From: Junio C Hamano <gitster@pobox.com>
Subject: incremental updates to "What's cooking"
Date: Mon, 16 Jul 2012 15:46:46 -0700
Message-ID: <7va9yzz5m1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 00:47:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Squ4C-0001y2-9D
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 00:47:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab2GPWqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 18:46:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075Ab2GPWqu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 18:46:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33D658F35;
	Mon, 16 Jul 2012 18:46:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	QdjhIPYAt2KvbSkkaVrDSWQP2Y=; b=p5pqFQFPucz+JkIJrwedCStwUCcGIIeGw
	PK1xkEKJRUi6+5/NLb2ICziKKP7DAaPhQ8XBwlXTYoqncPG/ThbQU5RuGY+H4fgk
	oqg6boisLTiiwsq5i8nCfVIXdd+y0ekl0NJiELdWa1dylpkz2PxvA/lLTuf/BUWZ
	u1EFNE+je0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MRG
	+cSMZFDQSUSjTQ4hpVAEr3UoUOwKdig2ZGUa9tnaFhZZTKOAUcsKWtHczTFTCq2L
	ueyHnAq8R/RKaefXGiYsHl96Bgu+tpQdunLiOA7iXcBEbjG2ykKBsGKLGUJNsoPN
	fyOAp2RfVC6cGCYdyQwAyNZa2TyK1ndfXM9BQJd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2222A8F34;
	Mon, 16 Jul 2012 18:46:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E4158F33; Mon, 16 Jul 2012
 18:46:48 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2078A1FC-CF98-11E1-8625-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201580>

Topics meant for the upcoming 1.7.12 have been maturing, and I am
planning to tag 1.7.12-rc0 early next week.  As a handful of topics
have been rerolled since the last "What's cooking", here is an
incremental updates.

There are quite a few topics that are marked as "Expecting a reroll"
in the last "What's cooking".  I'd hope them to be ready by the end
of this week.


[New Topics]

 * lk/more-helpful-status-hints (2012-07-16) 1 commit
   (merged to 'next' on 2012-07-16 at 8f9b3cc)
  + status: color in-progress message like other header messages
 
 Will merge to 'master'.

 * mm/mediawiki-usability (2012-07-16) 8 commits
  - git-remote-mediawiki: properly deal with invalid remote revisions
  - git-remote-mediawiki: show progress information when getting last remote revision
  - git-remote-mediawiki: show progress information when listing pages
  - git-remote-mediawiki: use --force when adding notes
  - git-remote-mediawiki: get rid of O(N^2) loop
  - git-remote-mediawiki: make mediafiles export optional
  - git-remote-mediawiki: actually send empty comment when they're empty
  - git-remote-mediawiki: don't split namespaces with spaces
 
 Will merge to 'next'.

 * ms/daemon-doc-typo (2012-07-16) 1 commit
   (merged to 'next' on 2012-07-16 at 3976434)
  + Documentation/git-daemon: add missing word
 
 Will merge to 'master'.

--------------------------------------------------
Moved from [New Topics] to [Cooking]

 * sn/doc-typofix (2012-07-14) 1 commit
  - doc: A few minor copy edits.
+
+Will merge to 'next'.

--------------------------------------------------
Other topics

[Cooking]

-* as/t4012-style-updates (2012-07-12) 7 commits
+* as/t4012-style-updates (2012-07-16) 8 commits
+ - t4012: Use test_must_fail instead of if-else
  - t4012: use 'printf' instead of 'dd' to generate a binary file
  - t4012: Re-indent test snippets
  - t4012: Make --shortstat test more robust
  - t4012: Break up pipe into serial redirections
  - t4012: Actually quote the sed script
  - t4012: Unquote git command fragment in test title
  - t4012: modernize style for quoting
 
-Expecting a reroll.
+Will merge to 'next'.

-* mm/config-xdg (2012-07-12) 2 commits
+* mm/config-xdg (2012-07-16) 1 commit
- - fixup! config: fix several access(NULL) calls
  - config: fix several access(NULL) calls
 
-Either we do the stupid literal conversion (shown in fixup!), or the
-reason why we special case missing HOME needs to be better explained.
+Will merge to 'next'.

 * tg/ce-namelen-field (2012-07-11) 2 commits
  - Strip namelen out of ce_flags into a ce_namelen field
  - Merge branch 'tg/maint-cache-name-compare' into tg/ce-namelen-field
 
+Split lower bits of ce_flags field and creates a new ce_namelen
+field in the in-core index structure.
+
-Split lower bits of ce_flags field and creates a new ce_namelen
-field in the in-core index structure.
+Will merge to 'next'.
