From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH RFC 3/6] Docs: send-email usage text much sexier
Date: Thu, 25 Sep 2008 15:44:33 -0500
Message-ID: <1222375476-32911-3-git-send-email-mfwitten@mit.edu>
References: <1222099095-50360-1-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-1-git-send-email-mfwitten@mit.edu>
 <1222375476-32911-2-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 25 22:48:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kixkl-0008DU-AM
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 22:47:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933AbYIYUqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbYIYUqp
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 16:46:45 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:61855 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755903AbYIYUqn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 16:46:43 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8PKipCb003906;
	Thu, 25 Sep 2008 16:44:52 -0400 (EDT)
Received: from localhost.localdomain (97-116-112-224.mpls.qwest.net [97.116.112.224])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8PKibJa008003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 25 Sep 2008 16:44:50 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.302.ge6cbd1
In-Reply-To: <1222375476-32911-2-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96802>

All of the descriptions are aligned, and no
line is greater than 78 columns.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-send-email.perl |   94 +++++++++++++++++++++++++++------------------------
 1 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d390364..b86a3f3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -40,74 +40,80 @@ sub usage {
 	print <<EOT;
 git send-email [options] <file | directory>...
 Options:
-   --from         Specify the "From:" line of the email to be sent.
+   --from                  Specify the "From:" line of the email to be sent.
 
-   --to           Specify the primary "To:" line of the email.
+   --to                    Specify the primary "To:" line of the email.
 
-   --cc           Specify an initial "Cc:" list for the entire series
-                  of emails.
+   --cc                    Specify an initial "Cc:" list for the entire series
+                           of emails.
 
-   --cc-cmd       Specify a command to execute per file which adds
-                  per file specific cc address entries
+   --cc-cmd                Specify a command to execute per file which adds
+                           per file specific cc address entries
 
-   --bcc          Specify a list of email addresses that should be Bcc:
-                  on all the emails.
+   --bcc                   Specify a list of email addresses that should be
+                           Bcc: on all the emails.
 
-   --compose      Use \$GIT_EDITOR, core.editor, \$EDITOR, or \$VISUAL to edit
-                  an introductory message for the patch series.
+   --compose               Use \$GIT_EDITOR, core.editor, \$EDITOR, or
+                           \$VISUAL to edit an introductory message for the
+                           patch series.
 
-   --subject      Specify the initial "Subject:" line.
-                  Only necessary if --compose is also set.  If --compose
-                  is not set, this will be prompted for.
+   --subject               Specify the initial "Subject:" line. Only necessary
+                           if --compose is also set.  If --compose is not set,
+                           this will be prompted for.
 
-   --in-reply-to  Specify the first "In-Reply-To:" header line.
-                  Only used if --compose is also set.  If --compose is not
-                  set, this will be prompted for.
+   --in-reply-to           Specify the first "In-Reply-To:" header line. Only
+                           used if --compose is also set.  If --compose is not
+                           set, this will be prompted for.
 
-   --[no-]chain-reply-to If set, the replies will all be to the previous
-                         email sent, rather than to the first email sent.
-                         Defaults to on.
+   --[no-]chain-reply-to   If set, the replies will all be to the previous
+                           email sent, rather than to the first email sent.
+                           Defaults to on.
 
    --[no-]signed-off-by-cc Automatically add email addresses that appear in
-                           Signed-off-by: or Cc: lines to the cc: list. Defaults to on.
+                           Signed-off-by: or Cc: lines to the cc: list.
+                           Defaults to on.
 
-   --identity     The configuration identity, a subsection to prioritise over
-                  the default section.
+   --identity              The configuration identity to use.
 
-   --smtp-server  If set, specifies the outgoing SMTP server to use.
-                  Defaults to localhost.  Port number can be specified here with
-                  hostname:port format or by using --smtp-server-port option.
+   --smtp-server           If set, specifies the outgoing SMTP server to use.
+                           Defaults to localhost.  Port number can be
+                           specified here with hostname:port format or by
+                           using --smtp-server-port option.
 
-   --smtp-server-port Specify a port on the outgoing SMTP server to connect to.
+   --smtp-server-port      Specify a port on the outgoing SMTP server to
+                           connect to.
 
-   --smtp-user    The username for SMTP-AUTH.
+   --smtp-user             The username for SMTP-AUTH.
 
-   --smtp-pass    The password for SMTP-AUTH.
+   --smtp-pass             The password for SMTP-AUTH.
 
-   --smtp-encryption Specify 'tls' for STARTTLS encryption, or 'ssl' for SSL.
-                     Any other value disables the feature.
+   --smtp-encryption       Specify 'tls' for STARTTLS encryption, or 'ssl' for
+                           SSL. Any other value disables the feature.
 
-   --smtp-ssl     Synonym for '--smtp-encryption=ssl'.  Deprecated.
+   --smtp-ssl              Synonym for '--smtp-encryption=ssl'.  Deprecated.
 
-   --suppress-cc  Suppress the specified category of auto-CC.  The category
-                  can be one of 'author' for the patch author, 'self' to
-                  avoid copying yourself, 'sob' for Signed-off-by lines,
-                  'cccmd' for the output of the cccmd, or 'all' to suppress
-                  all of these.
+   --suppress-cc           Suppress the specified category of auto-CC.  The
+                           category can be one of 'author' for the patch
+                           author, 'self' to avoid copying yourself, 'sob'
+                           for Signed-off-by lines, 'cccmd' for the output
+                           of the cccmd, or 'all' to suppress all of these.
+                           (Note: Linus uses 'self' and 'sob' interchangeably)
 
-   --[no-]suppress-from Suppress sending emails to yourself. Defaults to off.
+   --[no-]suppress-from    Suppress sending emails to yourself. Defaults to
+                           off.
 
-   --[no-]thread       Specify that the "In-Reply-To:" header should be set on all
-                       emails. Defaults to on.
+   --[no-]thread           Specify that the "In-Reply-To:" header should be
+                           set on all emails. Defaults to on.
 
-   --quiet Make git-send-email less verbose.  One line per email
-           should be all that is output.
+   --quiet                 Make git-send-email less verbose.  One line per
+                           email should be all that is output.
 
-   --dry-run Do everything except actually send the emails.
+   --dry-run               Do everything except actually send the emails.
 
-   --envelope-sender Specify the envelope sender used to send the emails.
+   --envelope-sender       Specify the envelope sender used to send the
+                           emails.
 
-   --no-validate Don't perform any sanity checks on patches.
+   --no-validate           Don't perform any sanity checks on patches.
 
 EOT
 	exit(1);
-- 
1.6.0.2.302.ge6cbd1
