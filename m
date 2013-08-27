From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 05/11] Fix some typos and improve wording
Date: Tue, 27 Aug 2013 19:59:21 +0200 (CEST)
Message-ID: <70864071.34489.1377626361141.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 19:59:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENY6-0005s1-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 19:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab3H0R7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 13:59:23 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:56936 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752217Ab3H0R7W (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 13:59:22 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 384995A3B0;
	Tue, 27 Aug 2013 19:59:21 +0200 (CEST)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 2C5733481FC;
	Tue, 27 Aug 2013 19:59:21 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 1C53D8262;
	Tue, 27 Aug 2013 19:59:21 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-16.arcor-online.net 1C53D8262
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626361; bh=9FlTkQyTvysnSZ909YIwAZ075eJX7vtc7I4USrNBwbQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=JZl2WrZxYXb6DHRbMotNT1rk+f46wD5OSI8h+cuhG+EU6bMJZSOexa/TxULWSQMZp
	 4SAydkfAUVnVE0TvINxVvxaTcIjxtFtFVitGWOjgbm15pGXKcPtcLMJVO6tWeWHWTu
	 zJodYQhIj2u8LscdvehQJBUagJg7UjblVugR2/l0=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 19:59:21 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233125>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6241a43..465d9cb 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -219,7 +219,7 @@ of development leading to that point.
 
 The best way to see how this works is using the linkgit:gitk[1]
 command; running gitk now on a Git repository and looking for merge
-commits will help understand how the Git organizes history.
+commits will help understand how Git organizes history.
 
 In the following, we say that commit X is "reachable" from commit Y
 if commit X is an ancestor of commit Y.  Equivalently, you could say
@@ -793,7 +793,7 @@ e05db0fd4f31dde7005f075a84f96b360d05984b
 -------------------------------------------------
 
 Or you could recall that the `...` operator selects all commits
-contained reachable from either one reference or the other but not
+reachable from either one reference or the other but not
 both; so
 
 -------------------------------------------------
@@ -820,7 +820,7 @@ You could just visually inspect the commits since e05db0fd:
 $ gitk e05db0fd..
 -------------------------------------------------
 
-Or you can use linkgit:git-name-rev[1], which will give the commit a
+or you can use linkgit:git-name-rev[1], which will give the commit a
 name based on any tag it finds pointing to one of the commit's
 descendants:
 
@@ -864,8 +864,8 @@ because it outputs only commits that are not reachable from v1.5.0-rc1.
 
 As yet another alternative, the linkgit:git-show-branch[1] command lists
 the commits reachable from its arguments with a display on the left-hand
-side that indicates which arguments that commit is reachable from.  So,
-you can run something like
+side that indicates which arguments that commit is reachable from.  
+So, if you run something like
 
 -------------------------------------------------
 $ git show-branch e05db0fd v1.5.0-rc0 v1.5.0-rc1 v1.5.0-rc2
@@ -877,15 +877,15 @@ available
 ...
 -------------------------------------------------
 
-then search for a line that looks like
+then a line like
 
 -------------------------------------------------
 + ++ [e05db0fd] Fix warnings in sha1_file.c - use C99 printf format if
 available
 -------------------------------------------------
 
-Which shows that e05db0fd is reachable from itself, from v1.5.0-rc1, and
-from v1.5.0-rc2, but not from v1.5.0-rc0.
+shows that e05db0fd is reachable from itself, from v1.5.0-rc1,
+and from v1.5.0-rc2, and not from v1.5.0-rc0.
 
 [[showing-commits-unique-to-a-branch]]
 Showing commits unique to a given branch
@@ -3542,7 +3542,7 @@ with Git 1.5.2 can look up the submodule commits in the repository and
 manually check them out; earlier versions won't recognize the submodules at
 all.
 
-To see how submodule support works, create (for example) four example
+To see how submodule support works, create four example
 repositories that can be used later as a submodule:
 
 -------------------------------------------------
@@ -3914,7 +3914,7 @@ fact that such a commit brings together ("merges") two or more
 previous states represented by other commits.
 
 In other words, while a "tree" represents a particular directory state
-of a working directory, a "commit" represents that state in "time",
+of a working directory, a "commit" represents that state in time,
 and explains how we got there.
 
 You create a commit object by giving it the tree that describes the
-- 
1.8.3.msysgit.0


---
Thomas
