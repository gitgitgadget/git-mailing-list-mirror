From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 2/3] Add coding-guidelines.txt and submitting-patches.txt to
 ./Documentation/Makefile
Date: Sun, 30 Dec 2012 11:33:22 +0100 (CET)
Message-ID: <1932763211.1364098.1356863602510.JavaMail.ngmail@webmail19.arcor-online.net>
References: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 11:33:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpGD8-0005Y6-Hf
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 11:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab2L3KdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 05:33:25 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:51062 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754358Ab2L3KdX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Dec 2012 05:33:23 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mx.arcor.de (Postfix) with ESMTP id 8600C1978B9
	for <git@vger.kernel.org>; Sun, 30 Dec 2012 11:33:22 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id 835133FEF5A;
	Sun, 30 Dec 2012 11:33:22 +0100 (CET)
Received: from webmail19.arcor-online.net (webmail19.arcor-online.net [151.189.8.77])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 80B9959DD7;
	Sun, 30 Dec 2012 11:33:22 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 80B9959DD7
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356863602; bh=koAkIZ3DU2ct0sCCelwxe68CTgNr/4IbUzzPW9skqY0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=qssONS32GyMeIcAYyGzud4+ri+UkZhwWU3XUmbrMGeVO1alSJL1z9f57AMMmg7Wf7
	 SIqQuM9AbTmDbF2v4qUArQmqgJIgLWad+rlbOOrkmolSYVXR91aObm8nrAUk+mGt6v
	 L1V44dWy0k3J71ck9LEZKA8YMivubhzM36YZeJEo=
Received: from [188.98.241.53] by webmail19.arcor-online.net (151.189.8.77) with HTTP (Arcor Webmail); Sun, 30 Dec 2012 11:33:22 +0100 (CET)
In-Reply-To: <1023165134.213650.1356863340563.JavaMail.ngmail@webmail06.arcor-online.net>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.98.241.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212325>

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e53d333..a51c00f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -47,6 +47,8 @@ TECH_DOCS += technical/racy-git
 TECH_DOCS += technical/send-pack-pipeline
 TECH_DOCS += technical/shallow
 TECH_DOCS += technical/trivial-merge
+TECH_DOCS += technical/coding-guidelines
+TECH_DOCS += technical/submitting-patches
 SP_ARTICLES += $(TECH_DOCS)
 SP_ARTICLES += technical/api-index
 
-- 
1.8.0.msysgit.0


---
Thomas
