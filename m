From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] format-patch --notes: show notes after three-dashes
Date: Fri, 19 Oct 2012 13:06:30 -0700
Message-ID: <7vzk3ii5vd.fsf@alter.siamese.dyndns.org>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com>
 <1350539128-21577-7-git-send-email-gitster@pobox.com>
 <C2D3CE0879B345FFAC2A6487760B5378@PhilipOakley>
 <7vlif3l9fw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 22:06:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPIqE-0006uE-Ad
	for gcvg-git-2@plane.gmane.org; Fri, 19 Oct 2012 22:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758609Ab2JSUGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 16:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758327Ab2JSUGe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 16:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACAD98462;
	Fri, 19 Oct 2012 16:06:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZSmE809zTN5LAeV1YRlhRpHh4g8=; b=XSxNH6
	JrnLrqXEzqekDP4KUl1fh8FVzHAnbAPbPfOAYrLI/Fz7hxrV4YqSTNVBffipHEM4
	vSnQ/ItURoX77+SB9kPF66IeIveTuI0NgTvO3+FRmraleSigkBP5B1Uqo81eOQc/
	tkptGbusTWKwP6uXl/eK70EvcTRp/UxH0mMqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hja9N/SfNOxm68QueOvddoH1K7sCuiWW
	ieuVF9rPQnwdUQg2cNA5Ph23CgosEKkIxiK+kgUVma0gsr+Y/pBrrwcApB8ahBvM
	VIcnejzNkHlVdYz2l4+jw2uOAwerTDH6InUXspUQHPInR9SySn8NYBwQmOoBNv3C
	YqvQSIW+BS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 990BA8461;
	Fri, 19 Oct 2012 16:06:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 929B48454; Fri, 19 Oct 2012
 16:06:31 -0400 (EDT)
In-Reply-To: <7vlif3l9fw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 18 Oct 2012 15:08:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 799FFFAC-1A28-11E2-8D00-9A8C2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208056>

Junio C Hamano <gitster@pobox.com> writes:

> As long as what it does is explained in format-patch, that is fine.
>
> I do not think this deserves to be in the SubmittingPatches.  We do
> tell people to hide "here is the context of the change" additional
> explanation after three dashes, but how the submitters prepare that
> text is entirely up to them (and I personally do not think notes is
> not necessarily the right tool to do so).

Just in case, here is what I'll queue as a placeholder on 'pu'.

-- >8 --
Subject: [PATCH] Documentation: decribe format-patch --notes

Even though I coded this, I am not sure what use scenarios would benefit
from this option, so the description is unnecessarily negative at this
moment. People who do want to use this feature need to come up with a
more plausible use case and replace it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6d43f56..066dc8b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		   [--ignore-if-in-upstream]
 		   [--subject-prefix=Subject-Prefix]
 		   [--to=<email>] [--cc=<email>]
-		   [--cover-letter] [--quiet]
+		   [--cover-letter] [--quiet] [--notes[=<ref>]]
 		   [<common diff options>]
 		   [ <since> | <revision range> ]
 
@@ -191,6 +191,19 @@ will want to ensure that threading is disabled for `git send-email`.
 	containing the shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--notes[=<ref>]::
+	Append the notes (see linkgit:git-notes[1]) for the commit
+	after the three-dash line.
++
+The expected use case of this is to write supporting explanation for
+the commit that does not belong to the commit log message proper
+when (or after) you create the commit, and include it in your patch
+submission.  But if you can plan ahead and write it down, there may
+not be a good reason not to write it in your commit message, and if
+you can't, you can always edit the output of format-patch before
+sending it out, so the practical value of this option is somewhat
+dubious, unless your workflow is broken.
+
 --[no]-signature=<signature>::
 	Add a signature to each message produced. Per RFC 3676 the signature
 	is separated from the body by a line with '-- ' on it. If the
-- 
1.8.0.rc3.162.g1f53438
