From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 08/13] Improve section "Manipulating branches"
Date: Sat, 24 Aug 2013 09:31:33 +0200 (CEST)
Message-ID: <1973484790.1091060.1377329493472.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:31:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8Ju-0003jr-Dg
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab3HXHbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:31:34 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:40257 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab3HXHbe (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:31:34 -0400
Received: from mail-in-18-z2.arcor-online.net (mail-in-18-z2.arcor-online.net [151.189.8.35])
	by mx.arcor.de (Postfix) with ESMTP id 7FC6027293;
	Sat, 24 Aug 2013 09:31:33 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-18-z2.arcor-online.net (Postfix) with ESMTP id 7B0E53481E8;
	Sat, 24 Aug 2013 09:31:33 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 74A80A9D34;
	Sat, 24 Aug 2013 09:31:33 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net 74A80A9D34
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329493; bh=4Zy34+pvgkO1hr9ZTx5bGhRQifwruKliOtOQaYKYcpM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=oDrSpTDe8IvuSWH7RhZkS0lTQNM2mujdeu5d+DYNqqWJZxYFK/8etN0d6Hu4cQrtq
	 Ho+DKM1onM5iBvaM21p5a/Wmwd/oNeS2jxeXxt3B62fZk3Sb6IGLuiV7my/72eI0aO
	 /TgGF/baTGB+9Pc0DR8D/B2DttIY8pUb1Pp0hPdw=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:31:33 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232875>


Add some missing punctuation.
Simplify description of "git branch -d/-D".

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0656191..d5baf03 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -268,27 +268,22 @@ Creating, deleting, and modifying branches is quick and easy; here's
 a summary of the commands:
 
 `git branch`::
-	list all branches
+	list all branches.
 `git branch <branch>`::
 	create a new branch named `<branch>`, referencing the same
-	point in history as the current branch
+	point in history as the current branch.
 `git branch <branch> <start-point>`::
 	create a new branch named `<branch>`, referencing
 	`<start-point>`, which may be specified any way you like,
-	including using a branch name or a tag name
+	including using a branch name or a tag name.
 `git branch -d <branch>`::
-	delete the branch `<branch>`; if the branch you are deleting
-	points to a commit which is not reachable from the current
-	branch, this command will fail with a warning.
+	delete the branch `<branch>`; if the branch is not fully
+	merged in its upstream branch, this command will fail with a warning.
 `git branch -D <branch>`::
-	even if the branch points to a commit not reachable
-	from the current branch, you may know that that commit
-	is still reachable from some other branch or tag.  In that
-	case it is safe to use this command to force Git to delete
-	the branch.
+	delete the branch `<branch>` irrespective of its merged status.
 `git checkout <branch>`::
 	make the current branch `<branch>`, updating the working
-	directory to reflect the version referenced by `<branch>`
+	directory to reflect the version referenced by `<branch>`.
 `git checkout -b <new> <start-point>`::
 	create a new branch `<new>` referencing `<start-point>`, and
 	check it out.
-- 
1.8.3.msysgit.0


---
Thomas
