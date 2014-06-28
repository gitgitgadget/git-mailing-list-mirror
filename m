From: Sergio Durigan Junior <sergiodj@sergiodj.net>
Subject: [PATCH] Documentation: Mention '--subject-prefix' in git-send-email's manual
Date: Sat, 28 Jun 2014 01:54:22 -0300
Message-ID: <1403931262-21679-1-git-send-email-sergiodj@sergiodj.net>
Cc: Sergio Durigan Junior <sergiodj@sergiodj.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 07:23:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0l6Q-00067y-9R
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 07:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbaF1FXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 01:23:00 -0400
Received: from kwanyin.sergiodj.net ([176.31.208.32]:52687 "EHLO
	kwanyin.sergiodj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaF1FXA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 01:23:00 -0400
X-Greylist: delayed 1704 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Jun 2014 01:23:00 EDT
X-Mailer: git-send-email 1.9.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252596>

This commit adds a mention to the '--subject-prefix' option in
git-send-email's documentation.  This option is already described in
git-format-patch's docs (because it belongs to this command, actually),
but it is very useful when you are submitting patches using
git-send-email too, for obvious reasons.

The text describing the option has been adapted from git-format-patch,
in order to be "self-contained" and not mention other options that are
not present in git-send-email's docs (e.g., '--numbered').

Signed-off-by: Sergio Durigan Junior <sergiodj@sergiodj.net>
---
 Documentation/git-send-email.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a60776e..76f531a 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -110,6 +110,13 @@ is not set, this will be prompted for.
 	Only necessary if --compose is also set.  If --compose
 	is not set, this will be prompted for.
 
+--subject-prefix=<Subject-Prefix>::
+	Instead of the standard '[PATCH]' prefix in the subject
+	line, instead use '[<Subject-Prefix>]'. This is useful if you
+	are sending an RFC instead of a patch, or if the patch version
+	has been bumped (e.g., '[PATCH v2]').  See also
+	linkgit:git-format-patch[1].
+
 --to=<address>::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
-- 
1.9.0
