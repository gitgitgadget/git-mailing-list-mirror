From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] request-pull: state what commit to expect
Date: Tue, 20 Sep 2011 16:01:49 -0700
Message-ID: <7vy5xi4y3m.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <CA+55aFxAQTR3sT7gekAD4qih8J+z-qwri7ZmNCPUd811xgci6w@mail.gmail.com>
 <CA+55aFy0b+eozmzbKD4RXcJ7e3WCpf7BV1n1qXHOeEwSHZKOXw@mail.gmail.com>
 <7vobynui8a.fsf@alter.siamese.dyndns.org>
 <7viposfgvd.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 01:02:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R69KE-0003IW-Mc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 01:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab1ITXB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 19:01:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47685 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1ITXB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 19:01:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C54250A0;
	Tue, 20 Sep 2011 19:01:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MkefhGzfPNXoZS13JuxN02xDS8Q=; b=R7PsIg
	LTT2jaSM27jYpUUsaz9+A1gyi0FKxBm5IHxayXjqfLzNKb0wU3oeNesix3Kv8POG
	rvx9uqgUZHSXavux9K8Eox3i8EDhbdUHY4vZEyKyh+NPo8Kiz15yAuFOptHXUfcV
	5LAx3pjvnlSOjiMpTVfy5u0MMv1aAWxc5NHnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ar/gQRojy9Ii0JXmcxUEtAN7iPKYyPZF
	HE+27H4vxKpSqGIbcFpoNevaSr7DSCEOZ+b88i2yMj7gsDZykZzksctojVvxQYHW
	bayJ5VRb4RrahDYqwcBQ0Du36gOrSkg8uAy/TjbMvI9Y19UZF7rZ+tD8mOWhnWiM
	Dkf8CJyqUe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63674509F;
	Tue, 20 Sep 2011 19:01:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D6F5E509B; Tue, 20 Sep 2011
 19:01:50 -0400 (EDT)
In-Reply-To: <7viposfgvd.fsf_-_@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Sep 2011 12:04:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 866FFF8A-E3DC-11E0-BFBE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181804>

Here are three patches on top of the latest round of request-pull update.
The first two are to add a new option to "git branch" command so that a
descriptive text that explains what the purpose of the branch is, for use
by other commands. And the last one builds on top of the patch this
message is a response to, to use that information.

And here is the first one, just an unrelated doc clean-up.

-- >8 --
Subject: [PATCH 1/3] branch doc: minor formatting fix

We tend to use typewriter font when writing command flags that are
meant to be typed literally by the user.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-branch.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 507b8d0..79424a5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -54,7 +54,7 @@ With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
 
-Use -r together with -d to delete remote-tracking branches. Note, that it
+Use `-r` together with `-d` to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
 in the remote repository or if 'git fetch' was configured not to fetch
 them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
-- 
1.7.7.rc2.4.g5ec82
