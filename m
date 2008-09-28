From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 8/8] Docs: config: send-email config options included
Date: Sat, 27 Sep 2008 20:09:56 -0500
Message-ID: <1222564196-84202-8-git-send-email-mfwitten@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-2-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-3-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-4-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-5-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-6-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-7-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 03:12:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjkpp-0002LE-Nv
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 03:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYI1BLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 21:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbYI1BLT
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 21:11:19 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48502 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751708AbYI1BLT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Sep 2008 21:11:19 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8S1AASv007000;
	Sat, 27 Sep 2008 21:10:10 -0400 (EDT)
Received: from localhost.localdomain (97-116-110-244.mpls.qwest.net [97.116.110.244])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8S19usJ017501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Sep 2008 21:10:09 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.g577ee
In-Reply-To: <1222564196-84202-7-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96930>

I just copied what is in the send-email man text.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/config.txt |   69 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bea867d..3fc1bb1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1075,6 +1075,75 @@ repack.usedeltabaseoffset::
 	"false" and repack. Access from old git versions over the
 	native protocol are unaffected by this option.
 
+sendemail.aliasesfile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
+
+sendemail.aliasfiletype::
+	Format of the file(s) specified in sendemail.aliasesfile. Must be
+	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
+
+sendemail.bcc::
+	Email address (or alias) to always bcc.
+
+sendemail.cc::
+    Default for --cc
+
+sendemail.cccmd::
+	Command to execute to generate per patch file specific "Cc:"s.
+
+sendemail.chainreplyto::
+	Boolean value specifying the default to the '--[no-]chain-reply-to'
+	parameter.
+
+sendemail.envelopesender
+    Default for --envelope-sender.
+
+sendemail.identity::
+	The default configuration identity. When specified,
+	'sendemail.<identity>.<item>' will have higher precedence than
+	'sendemail.<item>'. This is useful to declare multiple SMTP
+	identities and to hoist sensitive authentication information
+	out of the repository and into the global configuration file.
+
+sendemail.signedoffcc::
+    Default for --[no-]signed-off-by-cc.
+
+sendemail.smtpencryption::
+	Default encryption method.  Use 'ssl' for SSL (and specify an
+	appropriate port), or 'tls' for TLS.  Takes precedence over
+	'smtpssl' if both are specified.
+
+sendemail.smtppass::
+	Default SMTP-AUTH password.
+
+sendemail.smtpserver::
+	Default SMTP server to use.
+
+sendemail.smtpserverport::
+	Default SMTP server port to use.
+
+sendemail.smtpssl::
+	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
+
+sendemail.smtpuser::
+	Default SMTP-AUTH username.
+
+sendemail.suppresscc::
+    Default for --supress-cc.
+
+sendemail.suppressfrom::
+    Default for --[no-]suppress-from
+
+sendemail.thread::
+    Default for --[no-]thread
+
+sendemail.to::
+	Email address (or alias) to always send to.
+
+sendemail.validate::
+    Boolean override for --[no-]validate.
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
-- 
1.6.0.2.304.g577ee
