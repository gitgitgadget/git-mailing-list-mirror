From: Adam Monsen <haircut@gmail.com>
Subject: [PATCH] SubmittingPatches: clean up commit message tips
Date: Wed,  9 Mar 2011 13:27:49 -0800
Message-ID: <1299706069-5463-1-git-send-email-haircut@gmail.com>
References: <4D77F03B.4050605@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 22:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQzM-0008Dk-0P
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 22:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab1CIVcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 16:32:07 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42616 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905Ab1CIVcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 16:32:05 -0500
Received: by pvg12 with SMTP id 12so173686pvg.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=gtbMmUWEzv9YE+qGzQXj+gdcU12ZGnyV1zuCEiWRyzw=;
        b=VZmq0XgKXjwz8JtM995iDyKGCRZuCCPGp5+gxl0WY/mm3+iQaSzG1Ossizm6V7Al8W
         fFhr61xh3MviRY4Uzbdist6OZ1UMCyE2fDZvnUDI9+Fzk6zv+jwSrSHnMVKPlfuixVS/
         c654cahj4WvDR8+n+5Ue+1f/CFhNpIwatKcgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=abQbyrzy+rFEZXLqiTSunc1wGD57l/mPfeDc83LxPor++uo40RoAvMtVcPHAS017LK
         v8o7xGeJDZwXt820V7lqSV/LB2IztmP5Rk5dTlFNJB4rCz7neRhvuRpjFCO3Fkr26688
         Xsw8CaFe6jvbQYKZilRtZC19EPWB7/qRV6t84=
Received: by 10.142.238.17 with SMTP id l17mr4851323wfh.99.1299706324239;
        Wed, 09 Mar 2011 13:32:04 -0800 (PST)
Received: from localhost.localdomain (c-67-183-136-182.hsd1.wa.comcast.net [67.183.136.182])
        by mx.google.com with ESMTPS id m10sm2934743wfl.11.2011.03.09.13.32.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 13:32:03 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <4D77F03B.4050605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168764>

Removed uncommon acronyms in the "Checklist" section. I had to look up
"iow" online, but this documentation should stand alone (without online
access) as well as commit messages.

Leave wiggle room for including URLs in commit messages. Having both
summaries of mailing list discussions as well as URLs in commit messages
gives the reader the choice of how deep into history they wish to dig.

Modify the section about trivial changes slightly... it makes more sense
that it is discouraging diffs pasted in emails as opposed to patches
generated with "git am".

Remove recommendations on commit messages from the "Make separate
commits for logically separate changes" section, they are covered
well and explicitly in the "Checklist" section on top. This section need
not repeat same, and the deleted text doesn't really apply to the
section it was under. Also remove irrelevant text about good commit
messages. The only relevant part of that paragraph was the first
sentence about breaking apart big commits into separate patches.

Consistently use the phrase "commit message" to mean the chunk of text
that describes a commit.

Also in "Checklist", make the third bullet under "...a meaningful
commit message, which:" flow better grammatically by adding "mentions".

Relevant mailing list discussion:

http://thread.gmane.org/gmane.comp.version-control.git/168481/focus=168717

Signed-off-by: Adam Monsen <haircut@gmail.com>
---

I realize that this commit probably violates the very virtues it recommends by
having a long commit message and fixing several things in one shot. Let me know
if you'd like me to break it apart. Also, I may of course have made further
errors. It does adhere to the subject of cleaning up commit message tips.

Hope this helps,
-Adam

 Documentation/SubmittingPatches |   38 ++++++++++++++++----------------------
 1 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c3b0816..3f8bff5 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -10,18 +10,19 @@ Checklist (and a short version for the impatient):
 	  description (50 characters is the soft limit, see DISCUSSION
 	  in git-commit(1)), and should skip the full stop
 	- the body should provide a meaningful commit message, which:
-	  . explains the problem the change tries to solve, iow, what
-	    is wrong with the current code without the change.
-	  . justifies the way the change solves the problem, iow, why
-	    the result with the change is better.
-	  . alternate solutions considered but discarded, if any.
+	  . explains the problem the change tries to solve, in other words,
+	    what is wrong with the current code without the change.
+	  . justifies the way the change solves the problem, in other words,
+	    why the result with the change is better.
+	  . mentions alternate solutions considered but discarded, if any.
 	- describe changes in imperative mood, e.g. "make xyzzy do frotz"
 	  instead of "[This patch] makes xyzzy do frotz" or "[I] changed
 	  xyzzy to do frotz", as if you are giving orders to the codebase
 	  to change its behaviour.
 	- try to make sure your explanation can be understood without
-	  external resources. Instead of giving a URL to a mailing list
-	  archive, summarize the relevant points of the discussion.
+	  external resources. Instead of providing only a URL to a
+	  mailing list archive, summarize the relevant points of the
+	  discussion.
 	- add a "Signed-off-by: Your Name <you@example.com>" line to the
 	  commit message (or just use the option "-s" when committing)
 	  to confirm that you agree to the Developer's Certificate of Origin
@@ -52,14 +53,14 @@ Checklist (and a short version for the impatient):
 
 Long version:
 
-I started reading over the SubmittingPatches document for Linux
+I started reading over the SubmittingPatches document for the Linux
 kernel, primarily because I wanted to have a document similar to
-it for the core GIT to make sure people understand what they are
-doing when they write "Signed-off-by" line.
+it for core GIT to make sure people understand what they are
+doing when they include a "Signed-off-by" line.
 
 But the patch submission requirements are a lot more relaxed
-here on the technical/contents front, because the core GIT is
-thousand times smaller ;-).  So here is only the relevant bits.
+here on the technical/contents front, because the core GIT is a
+thousand times smaller ;-).  So here are just the relevant bits.
 
 (0) Decide what to base your work on.
 
@@ -93,7 +94,7 @@ commit is the tip of the topic branch.
 (1) Make separate commits for logically separate changes.
 
 Unless your patch is really trivial, you should not be sending
-out a patch that was generated between your working tree and
+out a diff that was generated between your working tree and
 your commit head.  Instead, always make a commit with complete
 commit message and generate a series of patches from your
 repository.  It is a good discipline.
@@ -103,15 +104,8 @@ that people can judge if it is good thing to do, without reading
 the actual patch text to determine how well the code does what
 the explanation promises to do.
 
-If your description starts to get too long, that's a sign that you
-probably need to split up your commit to finer grained pieces.
-That being said, patches which plainly describe the things that
-help reviewers check the patch, and future maintainers understand
-the code, are the most beautiful patches.  Descriptions that summarise
-the point in the subject well, and describe the motivation for the
-change, the approach taken by the change, and if relevant how this
-differs substantially from the prior version, are all good things
-to have.
+If your commit message starts to get too long, that's a sign that you
+probably need to split your commit into finer grained pieces.
 
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
-- 
1.7.2.3
