From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pulling signed tag: add howto document
Date: Wed, 18 Jan 2012 14:27:17 -0800
Message-ID: <7v1uqwmyt6.fsf@alter.siamese.dyndns.org>
References: <7vehuyosaa.fsf@alter.siamese.dyndns.org>
 <7v62g9q55f.fsf@alter.siamese.dyndns.org> <4F16E228.5050203@xiplink.com>
 <7v62g8n1tq.fsf@alter.siamese.dyndns.org> <4F173C5D.7000802@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:27:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RndyZ-0000H8-AA
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab2ARW1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:27:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab2ARW1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 17:27:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40D05678A;
	Wed, 18 Jan 2012 17:27:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gjXNo8Rz6fsbbbsVCTYY2I9C+D0=; b=LZOV4f
	BO6g7iuyTG5cLPZhz8zHz89JjHONTTcHytqx4LUsfAP49neBZWjCiekAgUypS7v0
	i0vZXNDTzzhUSORZZHLJfwKoZ1v/yEGv/w+ufW4/XGhcj+aK+O0z9YpHuXSZLnu8
	WVQxrc7/mHH7hBzATQboZ2KF9jMjh4Hx6tLF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sv50PAcN9sceGCNFW4MBbr9IwSVZGTtQ
	xwm3q8KowHOrPQey8MZjgKF35XxXdOOt+e1kRPOikj3I0psstyZkKWo9sms6yO1W
	rpClTGrYqdB8j97GRc1Ki8p5ZY/qo3zW0R2cvLk41ff1XbXpHNv9Rlipgmcxc7hw
	9rNLFfheirg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 367A16789;
	Wed, 18 Jan 2012 17:27:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 616276788; Wed, 18 Jan 2012
 17:27:19 -0500 (EST)
In-Reply-To: <4F173C5D.7000802@xiplink.com> (Marc Branchaud's message of
 "Wed, 18 Jan 2012 16:40:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 954EFC90-4223-11E1-86D0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188768>

Marc Branchaud <marcnarc@xiplink.com> writes:

> It might be better to just move the footnote to the end of the next sentence.

Ok. How does this version look?  The highlights are:

 * remove footnotes and spell them out inline, like "Note that..."

 * "a single liner" -> "a one-liner"

 * "publishing repository" -> "public repository". I often use the former
   when I want to differenciate a repository used to publish the work by a
   single owner from a shared public repository, so technically the wording
   could stay as-is, but I think it is clear that we mean publishing one
   not a shared one from the context of this document.

 * Drop the attempt to say "you would see these 'Good signature from...'
   if and only if the signature verifies OK" altogether. It is clear from
   the example that the signature was good.

 * Replace the paragraph that explains there is no need to keep and
   transfer signed tags for auditors with your version.

Thanks.

 .../howto/using-signed-tag-in-pull-request.txt     |   60 +++++++++----------
 1 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/Documentation/howto/using-signed-tag-in-pull-request.txt b/Documentation/howto/using-signed-tag-in-pull-request.txt
index efac088..a1351c5 100644
--- a/Documentation/howto/using-signed-tag-in-pull-request.txt
+++ b/Documentation/howto/using-signed-tag-in-pull-request.txt
@@ -58,7 +58,7 @@ A contributor or a lieutenant
 -----------------------------
 
 After preparing her work to be pulled, the contributor uses `git tag -s`
-to create a signed tag [*1*]:
+to create a signed tag:
 
 ------------
  $ git checkout work
@@ -66,14 +66,27 @@ to create a signed tag [*1*]:
  $ git tag -s -m "Completed frotz feature" frotz-for-xyzzy work
 ------------
 
-and pushes the tag out to her publishing repository [*2*]. There is no
-need to push the `work` branch or anything else:
+Note that this example uses the `-m` option to create a signed tag with
+just a one-liner message, but this is for illustration purposes only. It
+is advisable to compose a well-written explanation of what the topic does
+to justify why it is worthwhile for the integrator to pull it, as this
+message will eventually become part of the final history after the
+integrator responds to the pull request (as we will see later).
+
+Then she pushes the tag out to her public repository:
 
 ------------
  $ git push example.com:/git/froboz.git/ +frotz-for-xyzzy
 ------------
 
-Then the contributor prepares a message to request a "pull":
+There is no need to push the `work` branch or anything else.
+
+Note that the above command line used a plus sign at the beginning of
+`+frotz-for-xyzzy` to allow forcing the update of a tag, as the same
+contributor may want to reuse a signed tag with the same name after the
+previous pull request has already been responded to.
+
+The contributor then prepares a message to request a "pull":
 
 ------------
  $ git request-pull v3.2 example.com:/git/froboz.git/ frotz-for-xyzzy >msg.txt
@@ -148,22 +161,21 @@ In the editor, the integrator will see something like this:
  # gpg: Good signature from "Con Tributor <nitfol@example.com>"
 ------------
 
-provided if the signature in the signed tag verifies correctly. Notice
-that the message recorded in the signed tag "Completed frotz feature"
-appears here, and again that is why it is important for the contributor
-to explain her work well when creating the signed tag.
+Notice that the message recorded in the signed tag "Completed frotz
+feature" appears here, and again that is why it is important for the
+contributor to explain her work well when creating the signed tag.
 
 As usual, the lines commented with `#` are stripped out. The resulting
 commit records the signed tag used for this validation in a hidden field
 so that it can later be used by others to audit the history. There is no
 need for the integrator to keep a separate copy of the tag in his
-repository (i.e. `git tag -l` won't list frotz-for-xyzzy tag in the above
-example), and there is no need to publish the tag to his public
+repository (i.e. `git tag -l` won't list the `frotz-for-xyzzy` tag in the
+above example), and there is no need to publish the tag to his public
 repository, either.
 
 After the integrator responds to the pull request and her work becomes
-part of the permanent history, the contributor can remove the tag from the
-publishing repository, if she chooses, in order to keep the tag namespace
+part of the permanent history, the contributor can remove the tag from
+her public repository, if she chooses, in order to keep the tag namespace
 of her public repository clean, with:
 
 ------------
@@ -199,23 +211,7 @@ A typical output from `git show --show-signature` may look like this:
        ...
 ------------
 
-There is no need to fetch and keep a signed tag like `frotz-for-xyzzy`
-that is used for frequent "pull" exchange in the long term just for such
-auditing purposes, as the signature is recorded as part of the merge
-commit.
-
-
-Footnotes
----------
-
-*1* This example uses the `-m` option to create a signed tag with just a
-single liner message, but this is for illustration purposes only. It is
-advisable to compose a well-written explanation of what the topic does to
-justify why it is worthwhile for the integrator to pull it, as this
-message will eventually become part of the final history after the
-integrator responds to the pull request.
-
-*2* The example uses plus at the beginning of `+frotz-for-xyzzy` to allow
-forcing the update of a tag, as the same contributor may want to reuse a
-signed tag with the same name after the previous pull request has already
-been responded to.
+There is no need for the auditor to explicitly fetch the contributor's
+signature, or to even be aware of what tag(s) the contributor and integrator
+used to communicate the signature.  All the required information is recorded
+as part of the merge commit.
