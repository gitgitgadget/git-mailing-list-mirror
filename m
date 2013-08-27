From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 07/11] Improve section "Manipulating branches"
Date: Tue, 27 Aug 2013 20:02:08 +0200 (CEST)
Message-ID: <1088240617.34545.1377626528726.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: martinvonz@gmail.com, jrnieder@gmail.com, th.acker@arcor.de,
	gitster@pobox.com, wking@tremily.us, philipoakley@iee.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 20:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VENap-00083O-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602Ab3H0SCL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:02:11 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:37002 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751715Ab3H0SCK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 14:02:10 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mx.arcor.de (Postfix) with ESMTP id C285026CBE;
	Tue, 27 Aug 2013 20:02:08 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id BD22A1968A;
	Tue, 27 Aug 2013 20:02:08 +0200 (CEST)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id B1F5C26CBE;
	Tue, 27 Aug 2013 20:02:08 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net B1F5C26CBE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377626528; bh=6DRn2mOpTLHqWZ/RuW7NnNR1ruLdW9xuwreZrxFY72c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=Tm3UsyuBiO4Sy5K5pFKUun78pWWl8//i4hAc2sMjRzeBj0iayOnp783jAVbbg67U7
	 6Lmjs8VAK3N0cnnTXYGPhhQJx4xPEwYJ2swAB8bwWO0UqHj65gUFhxEJJhU3ff7CiN
	 IaH7BNubnHOHPDkEdkAEPS6/pihJoFYLqO1ik2Uc=
Received: from [178.7.16.225] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Tue, 27 Aug 2013 20:02:08 +0200 (CEST)
In-Reply-To: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.16.225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233127>


Add some missing punctuation.
Simplify description of "git branch -d/-D".

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 98d2804..c20e8df 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -268,27 +268,23 @@ Creating, deleting, and modifying branches is quick and easy; here's
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
+	merged in its upstream branch or contained in the current branch, 
+	this command will fail with a warning.
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
