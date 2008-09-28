From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 7/8] Docs: send-email: Added all config variables to man end
Date: Sat, 27 Sep 2008 20:09:55 -0500
Message-ID: <1222564196-84202-7-git-send-email-mfwitten@mit.edu>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-2-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-3-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-4-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-5-git-send-email-mfwitten@mit.edu>
 <1222564196-84202-6-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 28 03:11:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjkow-000293-LV
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 03:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbYI1BKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 21:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbYI1BKP
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 21:10:15 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48401 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138AbYI1BKO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Sep 2008 21:10:14 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8S1A9hm006984;
	Sat, 27 Sep 2008 21:10:09 -0400 (EDT)
Received: from localhost.localdomain (97-116-110-244.mpls.qwest.net [97.116.110.244])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8S19usI017501
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 27 Sep 2008 21:10:08 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.2.304.g577ee
In-Reply-To: <1222564196-84202-6-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96924>

Admittedly, I didn't take much pride in my work, but
I'm not trying to solve this problem.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 Documentation/git-send-email.txt |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8aa5098..ee89e03 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -207,6 +207,9 @@ sendemail.aliasfiletype::
 sendemail.bcc::
 	Email address (or alias) to always bcc.
 
+sendemail.cc::
+    Default for --cc
+
 sendemail.cccmd::
 	Command to execute to generate per patch file specific "Cc:"s.
 
@@ -214,6 +217,9 @@ sendemail.chainreplyto::
 	Boolean value specifying the default to the '--[no-]chain-reply-to'
 	parameter.
 
+sendemail.envelopesender
+    Default for --envelope-sender.
+
 sendemail.identity::
 	The default configuration identity. When specified,
 	'sendemail.<identity>.<item>' will have higher precedence than
@@ -221,6 +227,9 @@ sendemail.identity::
 	identities and to hoist sensitive authentication information
 	out of the repository and into the global configuration file.
 
+sendemail.signedoffcc::
+    Default for --[no-]signed-off-by-cc.
+
 sendemail.smtpencryption::
 	Default encryption method.  Use 'ssl' for SSL (and specify an
 	appropriate port), or 'tls' for TLS.  Takes precedence over
@@ -241,6 +250,15 @@ sendemail.smtpssl::
 sendemail.smtpuser::
 	Default SMTP-AUTH username.
 
+sendemail.suppresscc::
+    Default for --supress-cc.
+
+sendemail.suppressfrom::
+    Default for --[no-]suppress-from
+
+sendemail.thread::
+    Default for --[no-]thread
+
 sendemail.to::
 	Email address (or alias) to always send to.
 
-- 
1.6.0.2.304.g577ee
