From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 02/13] Use current "detached HEAD" message
Date: Sat, 24 Aug 2013 09:25:40 +0200 (CEST)
Message-ID: <1667680014.1090850.1377329140347.JavaMail.ngmail@webmail08.arcor-online.net>
References: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, wking@tremily.us, th.acker@arcor.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 09:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD8EE-0002Sm-3s
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 09:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754975Ab3HXHZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Aug 2013 03:25:42 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:56700 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754605Ab3HXHZl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Aug 2013 03:25:41 -0400
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mx.arcor.de (Postfix) with ESMTP id 62142E3B72;
	Sat, 24 Aug 2013 09:25:40 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 59B8D112033;
	Sat, 24 Aug 2013 09:25:40 +0200 (CEST)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 5661BE3B72;
	Sat, 24 Aug 2013 09:25:40 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net 5661BE3B72
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1377329140; bh=t6hOIAkrwBzV+pzirMSVxEEviXjse8HeG+9X+Su0L8k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=T3BpkT5tH31X3W22TpHMgYEy5Ffvd0XOZmBDtTrA+aHdBPuIgHbvvWMj3RTPMW+U8
	 aggA61b3jDeTko5FEby5LIYuIMgBF6/gFX1lHX2OiSlySt/2MsrUThfxy1+8q5kWuE
	 bQRYrZ+iNMUMQbBnNXJl/azhcA81HAU0TjM6qQOU=
Received: from [188.98.235.44] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 24 Aug 2013 09:25:40 +0200 (CEST)
In-Reply-To: <282216171.1090748.1377328932833.JavaMail.ngmail@webmail08.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.235.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232869>


Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/user-manual.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 103ec9a..cb30929 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -312,10 +312,17 @@ referenced by a tag:
 
 ------------------------------------------------
 $ git checkout v2.6.17
-Note: moving to "v2.6.17" which isn't a local branch
-If you want to create a new branch from this checkout, you may do so
-(now or later) by using -b with the checkout command again. Example:
-  git checkout -b <new_branch_name>
+Note: checking out 'v2.6.17'.
+
+You are in 'detached HEAD' state. You can look around, make experimental
+changes and commit them, and you can discard any commits you make in this
+state without impacting any branches by performing another checkout.
+
+If you want to create a new branch to retain commits you create, you may
+do so (now or later) by using -b with the checkout command again. Example:
+
+  git checkout -b new_branch_name
+
 HEAD is now at 427abfa... Linux v2.6.17
 ------------------------------------------------
 
@@ -326,7 +333,7 @@ and git branch shows that you are no longer on a branch:
 $ cat .git/HEAD
 427abfa28afedffadfca9dd8b067eb6d36bac53f
 $ git branch
-* (no branch)
+* (detached from v2.6.17)
   master
 ------------------------------------------------
 
-- 
1.8.3.msysgit.0


---
Thomas
