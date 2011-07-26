From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 02/19] doc: Correct git_attr() calls in example code
Date: Tue, 26 Jul 2011 16:12:45 +0200
Message-ID: <1311689582-3116-3-git-send-email-mhagger@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:32:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlig5-0005I5-PR
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323Ab1GZOby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:31:54 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40199 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab1GZObw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:31:52 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QliM6-0004aQ-Gu; Tue, 26 Jul 2011 16:11:30 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177874>

Commit 7fb0eaa2 (2010-01-17) changed git_attr() to take a string
instead of a string and a length.  Update the documentation
accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-gitattributes.txt |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 9d97eaa..916720f 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -11,9 +11,9 @@ Data Structure
 `struct git_attr`::
 
 	An attribute is an opaque object that is identified by its name.
-	Pass the name and its length to `git_attr()` function to obtain
-	the object of this type.  The internal representation of this
-	structure is of no interest to the calling programs.
+	Pass the name to `git_attr()` function to obtain the object of
+	this type.  The internal representation of this structure is
+	of no interest to the calling programs.
 
 `struct git_attr_check`::
 
@@ -72,8 +72,8 @@ static void setup_check(void)
 {
 	if (check[0].attr)
 		return; /* already done */
-	check[0].attr = git_attr("crlf", 4);
-	check[1].attr = git_attr("ident", 5);
+	check[0].attr = git_attr("crlf");
+	check[1].attr = git_attr("ident");
 }
 ------------
 
-- 
1.7.6.8.gd2879
