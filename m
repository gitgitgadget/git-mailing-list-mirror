From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] SubmittingPatches: mention subsystems with dedicated
 repositories
Date: Wed, 02 Jan 2013 09:22:50 -0800
Message-ID: <7vy5gb33f9.fsf@alter.siamese.dyndns.org>
References: <1357082695-29713-1-git-send-email-gitster@pobox.com>
 <1357082695-29713-3-git-send-email-gitster@pobox.com>
 <20130102015233.GA25288@gmail.com> <7vsj6k5o1w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jason Holden <jason.k.holden.swdev@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 18:23:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqS25-00082L-4Q
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 18:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683Ab3ABRWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 12:22:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58238 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab3ABRWx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 12:22:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3AF4A36E;
	Wed,  2 Jan 2013 12:22:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfRpbEsGkOoin1PXFhdo6x3rDgI=; b=J41P/h
	0V6zFcv9uVRTAI4GayKrnh/ghD2bFRTpoz1O8ghst1FUmfjZBWUILT39/fs7AaCf
	PVjxPlGj6x0ZzIYAlUT/QE/1oh4YOZwGeTiNQ9WPvrhvAhC5lUTh48ZT+eR+A6qW
	hy57gRGQhZUngLHQ4zzFjyjru5et4raEno6tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtWW5ylCEUFhXUHL2tDPfqY863+KNtSw
	Q90sG9enoNOBCYG979Pu4UXI9Co6PNheiFOK4Jg8/ARQ8dGayh/P/tOGWq4qLvQK
	pLkEsl16LEtr1VAhBmCCvQPY5T2mp8jjtbtEw+oE6w8ieBwXyg0BXzyR9tbQY3DS
	AVob+d0uz1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5572A36D;
	Wed,  2 Jan 2013 12:22:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04529A36C; Wed,  2 Jan 2013
 12:22:51 -0500 (EST)
In-Reply-To: <7vsj6k5o1w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 01 Jan 2013 18:14:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09ADF9EC-5501-11E2-90F6-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212529>

Junio C Hamano <gitster@pobox.com> writes:

> Jason Holden <jason.k.holden.swdev@gmail.com> writes:
>
>> Any reason to leave out the maintainers email addresses?
>
> Nothing particular, other than that I did not find anywhere in the
> file that does not break the flow.

I've prepared this on top of the previous three.  The second hunk
that updates "(4) Sending your patches." is the logical place to
have this information.

The other hunks are correcting minor mistakes that are not related.
I think I'll squash them to the patch 3/3.


 Documentation/SubmittingPatches | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index a7daad3..9e113d0 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -31,8 +31,9 @@ change is relevant to.
    these parts should be based on their trees.
 
 To find the tip of a topic branch, run "git log --first-parent
-master..pu" and look for the merge commit. The second parent of this
-commit is the tip of the topic branch.
+master..pu" and look for merge commits. The second parent of these
+commits are the tips of topic branches.
+
 
 (1) Make separate commits for logically separate changes.
 
@@ -70,6 +71,7 @@ changes do not trigger errors with the sample pre-commit hook shipped
 in templates/hooks--pre-commit.  To help ensure this does not happen,
 run git diff --check on your changes before you commit.
 
+
 (2) Describe your changes well.
 
 The first line of the commit message should be a short description (50
@@ -185,14 +187,20 @@ not a text/plain, it's something else.
 Send your patch with "To:" set to the mailing list, with "cc:" listing
 people who are involved in the area you are touching (the output from
 "git blame $path" and "git shortlog --no-merges $path" would help to
-identify them), to solicit comments and reviews.  After the list
-reached a consensus that it is a good idea to apply the patch, re-send
-it with "To:" set to the maintainer and "cc:" the list for inclusion.
-Do not forget to add trailers such as "Acked-by:", "Reviewed-by:" and
-"Tested-by:" after your "Signed-off-by:" line as necessary.
+identify them), to solicit comments and reviews.
+
+After the list reached a consensus that it is a good idea to apply the
+patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
+list [*2*] for inclusion.  Do not forget to add trailers such as
+"Acked-by:", "Reviewed-by:" and "Tested-by:" after your
+"Signed-off-by:" line as necessary.
+
+    [Addresses]
+     *1* The current maintainer: gitster@pobox.com
+     *2* The mailing list: git@vger.kernel.org
 
 
-(4) Sign your work
+(5) Sign your work
 
 To improve tracking of who did what, we've borrowed the
 "sign-off" procedure from the Linux kernel project on patches
@@ -304,7 +312,8 @@ suggests to the contributors:
      even get them in a "on top of your change" patch form.
 
  (3) Polish, refine, and re-send to the list and the people who
-     spend their time to improve your patch.  Go back to step (2).
+     spent their time to help improving your patch.  Go back to
+     step (2) until step (4) happens.
 
  (4) The list forms consensus that the last round of your patch is
      good.  Send it to the list and cc the maintainer.
