From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH v2 3/3] Documentation: move format.* documentation to format-patch
Date: Fri, 22 Oct 2010 07:02:31 +0200
Message-ID: <48770d33c558c07b5457c3011512b15486602b31.1287690696.git.trast@student.ethz.ch>
References: <cover.1287690696.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 07:03:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P99mp-0006x2-PH
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 07:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0JVFDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 01:03:09 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:11329 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288Ab0JVFDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 01:03:08 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 22 Oct
 2010 07:02:59 +0200
Received: from localhost.localdomain (129.132.209.169) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 22 Oct
 2010 07:02:50 +0200
X-Mailer: git-send-email 1.7.3.1.281.g5da0b
In-Reply-To: <cover.1287690696.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159642>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/config-vars-src.txt  |   56 -------------------------------
 Documentation/git-format-patch.txt |   65 +++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/Documentation/config-vars-src.txt b/Documentation/config-vars-src.txt
index 949259c..e12ff6e 100644
--- a/Documentation/config-vars-src.txt
+++ b/Documentation/config-vars-src.txt
@@ -775,67 +775,11 @@ fetch.unpackLimit::
 	especially on slow filesystems.  If not set, the value of
 	`transfer.unpackLimit` is used instead.
 
-format.attach::
-	Enable multipart/mixed attachments as the default for
-	'format-patch'.  The value can also be a double quoted string
-	which will enable attachments as the default and set the
-	value as the boundary.  See the --attach option in
-	linkgit:git-format-patch[1].
-
-format.numbered::
-	A boolean which can enable or disable sequence numbers in patch
-	subjects.  It defaults to "auto" which enables it only if there
-	is more than one patch.  It can be enabled or disabled for all
-	messages by setting it to "true" or "false".  See --numbered
-	option in linkgit:git-format-patch[1].
-
-format.headers::
-	Additional email headers to include in a patch to be submitted
-	by mail.  See linkgit:git-format-patch[1].
-
-format.to::
-format.cc::
-	Additional recipients to include in a patch to be submitted
-	by mail.  See the --to and --cc options in
-	linkgit:git-format-patch[1].
-
-format.subjectprefix::
-	The default for format-patch is to output files with the '[PATCH]'
-	subject prefix. Use this variable to change that prefix.
-
-format.signature::
-	The default for format-patch is to output a signature containing
-	the git version number. Use this variable to change that default.
-	Set this variable to the empty string ("") to suppress
-	signature generation.
-
-format.suffix::
-	The default for format-patch is to output files with the suffix
-	`.patch`. Use this variable to change that suffix (make sure to
-	include the dot if you want it).
-
 format.pretty::
 	The default pretty format for log/show/whatchanged command,
 	See linkgit:git-log[1], linkgit:git-show[1],
 	linkgit:git-whatchanged[1].
 
-format.thread::
-	The default threading style for 'git format-patch'.  Can be
-	a boolean value, or `shallow` or `deep`.  `shallow` threading
-	makes every mail a reply to the head of the series,
-	where the head is chosen from the cover letter, the
-	`\--in-reply-to`, and the first patch mail, in this order.
-	`deep` threading makes every mail a reply to the previous one.
-	A true boolean value is the same as `shallow`, and a false
-	value disables threading.
-
-format.signoff::
-    A boolean value which lets you enable the `-s/--signoff` option of
-    format-patch by default. *Note:* Adding the Signed-off-by: line to a
-    patch should be a conscious act and means that you certify you have
-    the rights to submit this work under the same open source license.
-    Please see the 'SubmittingPatches' document for further discussion.
-
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9dcafc6..6154e98 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -211,10 +211,9 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 
 CONFIGURATION
 -------------
-You can specify extra mail header lines to be added to each message,
-defaults for the subject prefix and file suffix, number patches when
-outputting more than one patch, add "To" or "Cc:" headers, configure
-attachments, and sign off patches with configuration variables.
+
+'git format-patch' has a lot of configuration variables.  A short
+example:
 
 ------------
 [format]
@@ -226,8 +225,66 @@ attachments, and sign off patches with configuration variables.
 	cc = <email>
 	attach [ = mime-boundary-string ]
 	signoff = true
+	signature = "Hello, world!\n"
+	thread = shallow
 ------------
 
+The individual variables are as follows:
+
+format.attach::
+	Enable multipart/mixed attachments as the default for
+	'format-patch'.  The value can also be a double quoted string
+	which will enable attachments as the default and set the
+	value as the boundary.  See the --attach option.
+
+format.numbered::
+	A boolean which can enable or disable sequence numbers in patch
+	subjects.  It defaults to "auto" which enables it only if there
+	is more than one patch.  It can be enabled or disabled for all
+	messages by setting it to "true" or "false".  See the --numbered
+	option.
+
+format.headers::
+	Additional email headers to include in a patch to be submitted
+	by mail.
+
+format.to::
+format.cc::
+	Additional recipients to include in a patch to be submitted
+	by mail.  See the --to and --cc options above.
+
+format.subjectprefix::
+	The default for format-patch is to output files with the '[PATCH]'
+	subject prefix. Use this variable to change that prefix.
+
+format.signature::
+	The default for format-patch is to output a signature containing
+	the git version number. Use this variable to change that default.
+	Set this variable to the empty string ("") to suppress
+	signature generation.
+
+format.suffix::
+	The default for format-patch is to output files with the suffix
+	`.patch`. Use this variable to change that suffix (make sure to
+	include the dot if you want it).
+
+format.thread::
+	The default threading style for 'git format-patch'.  Can be
+	a boolean value, or `shallow` or `deep`.  `shallow` threading
+	makes every mail a reply to the head of the series,
+	where the head is chosen from the cover letter, the
+	`\--in-reply-to`, and the first patch mail, in this order.
+	`deep` threading makes every mail a reply to the previous one.
+	A true boolean value is the same as `shallow`, and a false
+	value disables threading.
+
+format.signoff::
+    A boolean value which lets you enable the `-s/--signoff` option of
+    format-patch by default. *Note:* Adding the Signed-off-by: line to a
+    patch should be a conscious act and means that you certify you have
+    the rights to submit this work under the same open source license.
+    Please see the 'SubmittingPatches' document for further discussion.
+
 
 EXAMPLES
 --------
-- 
1.7.3.1.281.g5da0b
