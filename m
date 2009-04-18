From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 09/12] Docs: send-email: Reorganize the CONFIGURATION section
Date: Sat, 18 Apr 2009 12:02:05 -0500
Message-ID: <1240074128-16132-10-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE1z-0007Tv-As
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758062AbZDRRHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757608AbZDRRHI
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:07:08 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:45168 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583AbZDRRHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:07:06 -0400
Received: by mail-qy0-f126.google.com with SMTP id 32so634324qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2dsWxjzKxHLPjhU3iSMQeeBN2ESsTu5vKPTPT4Bqumk=;
        b=Wr/oma+yKqCKENawp6CveJAxyQjEElhwIBnT4nvOEFWKg/SIDx9shWdyqJBxN9oqcA
         pjMAySLvKYydQhq+EcCnK9+/WSomndDNeRwj7MbzB9OY23ESzawjaqCYKXJUPaJxNAYN
         3nmI578HufPBXdtp60RqPA6LiPW+G8KffnSwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lC3LBPPLX8pBp0ugasww+YXgYGFi46MHIqPKgmStZKEz8Z4pDG6xvAQMT0haI0ihbZ
         QNUv5BupcwPLyz+SM+oNaZiGR6jsqw/yKDGp3cyQVebB90+m7MyyjInFNrOAPd4V73Xj
         OuVjsqFreID3sJMIV0usyv7y8QcktiMSvtqRg=
Received: by 10.220.94.137 with SMTP id z9mr4281210vcm.52.1240074425875;
        Sat, 18 Apr 2009 10:07:05 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.07.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:07:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116853>

For each configuration variable, the reader is either prompted
to seek out the description of the corresponding command line option,
or a description is given if there is no corresponding command line
option.

The CONFIGURATION section has also been recast into the Composing,
Sending, Automating, and Administering sections, and configuration
variables are listed in alphabetical order within each section.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   83 ++++++++++++++++++++++++++++++++++----
 1 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 92985ee..6f770d0 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -282,6 +282,28 @@ default to '--validate'.
 CONFIGURATION
 -------------
 
+Composing
+~~~~~~~~~
+
+sendemail.bcc::
+	See '--bcc'
+
+sendemail.cc::
+	See '--cc'
+
+sendemail.multiedit::
+	If true (default), a single editor instance will be spawned to edit
+	files you have to edit (patches when '--annotate' is used, and the
+	summary when '--compose' is used). If false, files will be edited one
+	after the other, spawning a new editor each time.
+
+sendemail.to::
+	See '--from'
+
+
+Sending
+~~~~~~~
+
 sendemail.aliasesfile::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
@@ -290,16 +312,61 @@ sendemail.aliasfiletype::
 	Format of the file(s) specified in sendemail.aliasesfile. Must be
 	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
 
-sendemail.multiedit::
-	If true (default), a single editor instance will be spawned to edit
-	files you have to edit (patches when '--annotate' is used, and the
-	summary when '--compose' is used). If false, files will be edited one
-	after the other, spawning a new editor each time.
+sendemail.envelopesender::
+	See '--envelope-sender'
+
+sendemail.smtpencryption::
+	See '--smtp-encryption'
+
+sendemail.smtppass::
+	See '--smtp-pass'
+
+sendemail.smtpserver::
+	See '--smtp-server'
+
+sendemail.smtpserverport::
+	See '--smtp-server-port'
+
+sendemail.smtpuser::
+	See '--smtp-ssl'
+
+
+Automating
+~~~~~~~~~~
+
+sendemail.cccmd::
+	See '--cc-cmd'
+
+sendemail.chainreplyto::
+	See '--[no-]chain-reply-to'
+
+sendemail.identity::
+	See '--identity'
+
+sendemail.signedoffbycc::
+	See '--[no-]signed-off-by-cc'
+
+sendemail.sleep::
+	See '--sleep'
+
+sendemail.suppresscc::
+	See '--suppress-cc'
+
+sendemail.suppressfrom::
+	See '--[no-]suppress-from'
+
+sendemail.thread::
+	See '--[no-]thread'
+
+
+Administering
+~~~~~~~~~~~~~
 
 sendemail.confirm::
-	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
-	in the previous section for the meaning of these values.
+	See '--confirm'
+
+sendemail.validate::
+	See '--dry-run'
 
 
 Author
-- 
1.6.2.2.479.g2aec
