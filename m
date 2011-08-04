From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/23] doc: Correct git_attr() calls in example code
Date: Thu,  4 Aug 2011 06:36:12 +0200
Message-ID: <1312432593-9841-3-git-send-email-mhagger@alum.mit.edu>
References: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qopg6-0005Ex-7Y
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866Ab1HDEg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:36:58 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39624 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1HDEg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:36:56 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744agHg029203;
	Thu, 4 Aug 2011 06:36:52 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312432593-9841-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178670>

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
