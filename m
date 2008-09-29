From: Michael Witten <mfwitten@MIT.EDU>
Subject: [RFC 8/9] Docs: send-email: Create logical groupings for --help text
Date: Mon, 29 Sep 2008 00:08:11 -0500
Message-ID: <1222664892-55810-3-git-send-email-mfwitten@mit.edu>
References: <20080929003636.GA18552@coredump.intra.peff.net>
 <1222664892-55810-1-git-send-email-mfwitten@mit.edu>
 <1222664892-55810-2-git-send-email-mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 07:10:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkB1Z-0008Oq-Kp
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 07:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYI2FJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 01:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbYI2FJD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 01:09:03 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:54578 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171AbYI2FJC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Sep 2008 01:09:02 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8T58J2B015111;
	Mon, 29 Sep 2008 01:08:19 -0400 (EDT)
Received: from localhost.localdomain (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8T58C4J019902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 29 Sep 2008 01:08:18 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.gdcf23.dirty
In-Reply-To: <1222664892-55810-2-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96997>

The options are partitioned into more digestible groups.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-send-email.perl |   61 ++++++++++++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4662d28..127acb7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -39,33 +39,40 @@ package main;
 sub usage {
 	print <<EOT;
 git send-email [options] <file | directory>...
-Options:
-   --identity              <str>  * Use the sendemail.<id> options.
-   --from                  <str>  * Email From:
-   --envelope-sender       <str>  * Email envelope sender.
-   --to                    <str>  * Email To:
-   --cc                    <str>  * Email Cc:
-   --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
-   --bcc                   <str>  * Email Bcc:
-   --subject               <str>  * Email "Subject:" (only if --compose).
-   --compose                      * Open an editor for introduction.
-   --in-reply-to           <str>  * First "In-Reply-To:" (only if --compose).
-   --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
-   --[no-]thread                  * Use In-Reply-To: field. Default on.
-   --[no-]signed-off-by-cc        * Actually send to Cc: and Signed-off-by:
-                                    addresses. Default on.
-   --suppress-cc           <str>  * author, self, sob, cccmd, all.
-   --[no-]suppress-from           * Don't send email to self. Default off.
-   --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
-                                    is optional. Default 'localhost'.
-   --smtp-server-port      <int>  * Outgoing SMTP server port.
-   --smtp-user             <str>  * The username for SMTP-AUTH.
-   --smtp-pass             <str>  * The password for SMTP-AUTH; not necessary.
-   --smtp-encryption       <str>  * tls or ssl; anything else disables.
-   --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
-   --quiet                        * Output one line of info per email.
-   --dry-run                      * Don't actually send the emails.
-   --[no-]validate                * Perform patch sanity checks. Default on.
+
+  Composing:
+    --from                  <str>  * Email From:
+    --to                    <str>  * Email To:
+    --cc                    <str>  * Email Cc:
+    --bcc                   <str>  * Email Bcc:
+    --subject               <str>  * Email "Subject:"
+    --in-reply-to           <str>  * Email "In-Reply-To:"
+    --compose                      * Open an editor for introduction.
+
+  Sending:
+    --envelope-sender       <str>  * Email envelope sender.
+    --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
+                                     is optional. Default 'localhost'.
+    --smtp-server-port      <int>  * Outgoing SMTP server port.
+    --smtp-user             <str>  * Username for SMTP-AUTH.
+    --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
+    --smtp-encryption       <str>  * tls or ssl; anything else disables.
+    --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+
+  Automating:
+    --identity              <str>  * Use the sendemail.<id> options.
+    --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
+    --suppress-cc           <str>  * author, self, sob, cccmd, all.
+    --[no-]signed-off-by-cc        * Send to Cc: and Signed-off-by:
+                                     addresses. Default on.
+    --[no-]suppress-from           * Send to self. Default off.
+    --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default on.
+    --[no-]thread                  * Use In-Reply-To: field. Default on.
+
+  Administering:
+    --quiet                        * Output one line of info per email.
+    --dry-run                      * Don't actually send the emails.
+    --[no-]validate                * Perform patch sanity checks. Default on.
 
 EOT
 	exit(1);
-- 
1.6.0.2.304.gdcf23.dirty
