From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 6/6] Use consistent links for User Manual and Everyday Git;
 Fix a quoting error
Date: Fri, 1 Feb 2013 19:12:53 +0100 (CET)
Message-ID: <549641245.1090170.1359742373184.JavaMail.ngmail@webmail18.arcor-online.net>
References: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net> <7vzjzodfp1.fsf@alter.siamese.dyndns.org> <7v38xsjzxg.fsf@alter.siamese.dyndns.org>
 <1860384981.631689.1358793375131.JavaMail.ngmail@webmail20.arcor-online.net>
 <7vvcark1f2.fsf@alter.siamese.dyndns.org>
 <775908345.1391972.1358713010522.JavaMail.ngmail@webmail12.arcor-online.net>
 <884336319.632675.1358795540870.JavaMail.ngmail@webmail20.arcor-online.net>
 <2009548606.632825.1358795980319.JavaMail.ngmail@webmail20.arcor-online.net>
 <CAJDDKr4fnUp_35ni72XJS_NSp4jxbvQPENLnk3AhFv2FBg3DTg@mail.gmail.com>
 <50804391.814945.1358931502165.JavaMail.ngmail@webmail07.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Fri Feb 01 19:13:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L6z-0006Cl-CP
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab3BASMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:12:55 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:37558 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752990Ab3BASMy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 13:12:54 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 369503B6022;
	Fri,  1 Feb 2013 19:12:53 +0100 (CET)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 2E14611202F;
	Fri,  1 Feb 2013 19:12:53 +0100 (CET)
Received: from webmail18.arcor-online.net (webmail18.arcor-online.net [151.189.8.76])
	by mail-in-18.arcor-online.net (Postfix) with ESMTP id 2343C3DC337;
	Fri,  1 Feb 2013 19:12:53 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 2343C3DC337
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1359742373; bh=21Blh7t7kl10I6UTtQiJCGUCuHxcY55XWwZrIQTB/F4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=omAC3mjySnDyzSGVRJ1kMf2HMYI5IIhASH0K+mIHAAkhplACpop5QrPMfy3cFulqs
	 /IamsiWk0DfsS1mAP7mO3CmDLD20mtggf8Dp9y5hp4RZraDg9wIysj+A7gJVFoCiEC
	 /TC4LwNW2afZBOuE8GLuiI1K1byqVOF9RnV+gI1U=
Received: from [188.105.106.49] by webmail18.arcor-online.net (151.189.8.76) with HTTP (Arcor Webmail); Fri, 1 Feb 2013 19:12:53 +0100 (CET)
In-Reply-To: <210945773.1090030.1359741840305.JavaMail.ngmail@webmail18.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.106.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215244>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/git.txt              | 2 +-
 Documentation/gitcore-tutorial.txt | 6 +++---
 Documentation/gittutorial-2.txt    | 2 +-
 Documentation/gittutorial.txt      | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c431ba2..c5f6845 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -23,7 +23,7 @@ and full access to internals.
 
 See linkgit:gittutorial[7] to get started, then see
 link:everyday.html[Everyday Git] for a useful minimum set of
-commands.  The link:user-manual.html[Git User's Manual] has a more
+commands.  The link:user-manual.html[The Git User's Manual] has a more
 in-depth introduction.
 
 After you mastered the basic concepts, you can come back to this
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 59c1c17..88e9839 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -17,7 +17,7 @@ work with a Git repository.
 
 If you just need to use Git as a revision control system you may prefer
 to start with "A Tutorial Introduction to Git" (linkgit:gittutorial[7]) or
-link:user-manual.html[the Git User Manual].
+link:user-manual.html[The Git User's Manual].
 
 However, an understanding of these low-level tools can be helpful if
 you want to understand Git's internals.
@@ -568,8 +568,8 @@ can explore on your own.
 
 [NOTE]
 Most likely, you are not directly using the core
-Git Plumbing commands, but using Porcelain such as 'git add', `git-rm'
-and `git-commit'.
+Git Plumbing commands, but using Porcelain such as 'git add', 'git rm'
+and 'git commit'.
 
 
 Tagging a version
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 94c906e..2db4ea3 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -406,7 +406,7 @@ pages for any of the git commands; one good place to start would be
 with the commands mentioned in link:everyday.html[Everyday Git].  You
 should be able to find any unknown jargon in linkgit:gitglossary[7].
 
-The link:user-manual.html[Git User's Manual] provides a more
+The link:user-manual.html[The Git User's Manual] provides a more
 comprehensive introduction to Git.
 
 linkgit:gitcvs-migration[7] explains how to
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 8262196..e63fd9f 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -656,7 +656,7 @@ digressions that may be interesting at this point are:
   * linkgit:gitworkflows[7]: Gives an overview of recommended
     workflows.
 
-  * link:everyday.html[Everyday Git with 20 Commands Or So]
+  * link:everyday.html[Everyday Git]
 
   * linkgit:gitcvs-migration[7]: Git for CVS users.
 
-- 
1.8.0.msysgit.0


---
Thomas
