From: Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH] doc: fix unmatched code fences
Date: Tue, 12 May 2015 19:23:20 +0200
Message-ID: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
Cc: Jean-Noel Avila <jn.avila@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 19:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsE3j-00042H-DY
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 19:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933565AbbELRdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 13:33:15 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:38055 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809AbbELR0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 13:26:06 -0400
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id F34B3D1A69A
	for <git@vger.kernel.org>; Tue, 12 May 2015 19:26:02 +0200 (CEST)
Received: from localhost.localdomain (unknown [82.239.31.145])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DF4C882269;
	Tue, 12 May 2015 19:22:59 +0200 (CEST)
X-Mailer: git-send-email 2.4.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268861>

This mismatch upsets the renderer on git-scm.com.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 Documentation/gitcore-tutorial.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 8475c07..36e9ab3 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -259,7 +259,7 @@ index 557db03..263414f 100644
 @@ -1 +1,2 @@
  Hello World
 +It's a new day for git
-----
+------------
 
 i.e. the diff of the change we caused by adding another line to `hello`.
 
-- 
2.4.0.rc2
