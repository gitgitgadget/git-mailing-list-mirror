From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in a
 non-bash shell
Date: Thu, 29 Jul 2010 16:38:20 -0700
Message-ID: <7vr5ilsvtf.fsf@alter.siamese.dyndns.org>
References: <4C50B005.1030004@pileofstuff.org>
 <7v4ofiuuf7.fsf@alter.siamese.dyndns.org> <4C51F2C0.8090101@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	solsTiCe d'Hiver <solstice.dhiver@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Fri Jul 30 01:38:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OecgP-00028i-8n
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 01:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab0G2Xic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 19:38:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab0G2Xib (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 19:38:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 61C2EC9EC7;
	Thu, 29 Jul 2010 19:38:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ek9p6PhaV9EJTzUbQQu7+iMLxDQ=; b=xm9oo8
	s9uszU+4BUuR30QaEYUsPrFVO6v03utoJ/8Ocjb5rhMBhCmORDRKlEt48fMfQnel
	BXFO6P3xjH+o11mrpdokhRYCmusVQX+sKKkB/9ANETj0nLHsgMTYKPizUmz/vdpy
	6vQKPaSLLGv8nfQS/zfpD+tHNIdUtqjG8OVmQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M3Aqj9JGl9cU+OP930ZV0fsR9HJcxez3
	MwMn6rhGOTpVAzOxDaBSPIGSzp8MBrEGumghVBUS3vH3aI7/MRXcXYa5me2V4WR4
	546l1l+dfdc2tnPsVjlAwfjggodtV6CxhjquO2vFdcism4motuaT2HssCsn3IgS2
	23thXvfn3jg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29EF4C9EC5;
	Thu, 29 Jul 2010 19:38:26 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 638B3C9EC4; Thu, 29 Jul
 2010 19:38:22 -0400 (EDT)
In-Reply-To: <4C51F2C0.8090101@pileofstuff.org> (Andrew Sayers's message of
 "Thu\, 29 Jul 2010 22\:29\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 623CF930-9B6A-11DF-9991-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152211>

Andrew Sayers <andrew-git@pileofstuff.org> writes:

> Would you be amenable in principle to creating something like `man
> git-bug`?  A quick search doesn't turn up any documents specifically
> about bug fixing/reporting, and a man page was the first place I thought
> to look.

I'd be perfectly fine with something like this.  People may want to add a
sentence or two to give tips on how to make sure that they are actual
bugs.


 Documentation/git.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 59f291d..3ba004f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -727,6 +727,14 @@ The documentation for git suite was started by David Greaves
 <david@dgreaves.com>, and later enhanced greatly by the
 contributors on the git-list <git@vger.kernel.org>.
 
+Reporting Bugs
+--------------
+
+If you found a bug, please send a bug report to the Git mailing list
+<git@vger.kernel.org>, where the development and maintenance is primarily
+done.  You do not have to be subscribed to the list to send a message
+there.
+
 SEE ALSO
 --------
 linkgit:gittutorial[7], linkgit:gittutorial-2[7],
