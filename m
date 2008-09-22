From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH RFC 2/6] Docs: send-email usage cleanup 1
Date: Mon, 22 Sep 2008 10:58:11 -0500
Message-ID: <1222099095-50360-2-git-send-email-mfwitten@mit.edu>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 22 18:03:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khnq6-0004K2-RN
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 18:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbYIVP7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYIVP7e
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 11:59:34 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:33438 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752829AbYIVP7c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 11:59:32 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8MFwP59012974;
	Mon, 22 Sep 2008 11:58:26 -0400 (EDT)
Received: from localhost.localdomain (97-116-112-224.mpls.qwest.net [97.116.112.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8MFwGo3024990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 22 Sep 2008 11:58:25 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.302.ge6cbd1
In-Reply-To: <1222099095-50360-1-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96492>

The usage text mainly uses spaces to layout the text,
so I replaced the few tabs that exit with spaces.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-send-email.perl |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9f56162..d390364 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -51,25 +51,25 @@ Options:
                   per file specific cc address entries
 
    --bcc          Specify a list of email addresses that should be Bcc:
-		  on all the emails.
+                  on all the emails.
 
    --compose      Use \$GIT_EDITOR, core.editor, \$EDITOR, or \$VISUAL to edit
-		  an introductory message for the patch series.
+                  an introductory message for the patch series.
 
    --subject      Specify the initial "Subject:" line.
                   Only necessary if --compose is also set.  If --compose
-		  is not set, this will be prompted for.
+                  is not set, this will be prompted for.
 
    --in-reply-to  Specify the first "In-Reply-To:" header line.
                   Only used if --compose is also set.  If --compose is not
-		  set, this will be prompted for.
+                  set, this will be prompted for.
 
    --[no-]chain-reply-to If set, the replies will all be to the previous
-                  email sent, rather than to the first email sent.
-                  Defaults to on.
+                         email sent, rather than to the first email sent.
+                         Defaults to on.
 
    --[no-]signed-off-by-cc Automatically add email addresses that appear in
-                 Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
+                           Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
 
    --identity     The configuration identity, a subsection to prioritise over
                   the default section.
@@ -85,29 +85,29 @@ Options:
    --smtp-pass    The password for SMTP-AUTH.
 
    --smtp-encryption Specify 'tls' for STARTTLS encryption, or 'ssl' for SSL.
-                  Any other value disables the feature.
+                     Any other value disables the feature.
 
    --smtp-ssl     Synonym for '--smtp-encryption=ssl'.  Deprecated.
 
    --suppress-cc  Suppress the specified category of auto-CC.  The category
-		  can be one of 'author' for the patch author, 'self' to
-		  avoid copying yourself, 'sob' for Signed-off-by lines,
-		  'cccmd' for the output of the cccmd, or 'all' to suppress
-		  all of these.
+                  can be one of 'author' for the patch author, 'self' to
+                  avoid copying yourself, 'sob' for Signed-off-by lines,
+                  'cccmd' for the output of the cccmd, or 'all' to suppress
+                  all of these.
 
    --[no-]suppress-from Suppress sending emails to yourself. Defaults to off.
 
    --[no-]thread       Specify that the "In-Reply-To:" header should be set on all
-                  emails. Defaults to on.
+                       emails. Defaults to on.
 
-   --quiet	  Make git-send-email less verbose.  One line per email
-                  should be all that is output.
+   --quiet Make git-send-email less verbose.  One line per email
+           should be all that is output.
 
-   --dry-run	  Do everything except actually send the emails.
+   --dry-run Do everything except actually send the emails.
 
-   --envelope-sender	Specify the envelope sender used to send the emails.
+   --envelope-sender Specify the envelope sender used to send the emails.
 
-   --no-validate	Don't perform any sanity checks on patches.
+   --no-validate Don't perform any sanity checks on patches.
 
 EOT
 	exit(1);
-- 
1.6.0.2.302.ge6cbd1
