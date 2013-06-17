From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] fixup! push: switch default from "matching" to "simple"
Date: Mon, 17 Jun 2013 20:01:19 +0200
Message-ID: <1371492079-19283-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 17 20:31:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoeDI-0002cd-CR
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 20:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab3FQSbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 14:31:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41284 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab3FQSbb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 14:31:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5HI1J6k008722
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 17 Jun 2013 20:01:19 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Uodk1-0001jM-56; Mon, 17 Jun 2013 20:01:21 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Uodk0-00051k-RJ; Mon, 17 Jun 2013 20:01:20 +0200
X-Mailer: git-send-email 1.8.3.1.495.g13f33cf.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 17 Jun 2013 20:01:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228096>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is to be squashed into jc/push-2.0-default-to-simple

(Noticed while writing the other patch about --force)

 Documentation/git-push.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 9b9e7d1..81b875b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -381,8 +381,10 @@ Examples
 	configured for the current branch).
 
 `git push origin`::
-	Without additional configuration, works like
-	`git push origin :`.
+	Without additional configuration, pushes the current branch to
+	the configured upstream (`remote.origin.merge` configuration
+	variable) if it has the same name as the current branch, and
+	errors out without pushing otherwise.
 +
 The default behavior of this command when no <refspec> is given can be
 configured by setting the `push` option of the remote, or the `push.default`
-- 
1.8.3.1.495.g13f33cf.dirty
