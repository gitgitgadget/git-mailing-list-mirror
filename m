From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 11/12] Docs: send-email: Clarification of sendemail.<identity>
Date: Sat, 18 Apr 2009 12:02:07 -0500
Message-ID: <1240074128-16132-12-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-8-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-9-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-10-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-11-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE2z-0007ku-B6
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbZDRRIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbZDRRIK
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:08:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:49433 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbZDRRIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:08:09 -0400
Received: by qw-out-2122.google.com with SMTP id 5so486458qwd.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=1EcEnHaNbjcO4ynRBvq6WNnJ5rnzfKf9MOmzllqCpIM=;
        b=HjuVd4iA2r7S8ibre69lLJxrnGDGwvPjVGcggEjZQxL/2e1U6iSokqh3pDm/VVd+h8
         5ko3n9Lv/WDnBaC6yP6HX3kAr+zWIZjXHYUw60wiTDxs8yFER05B0S10Kd6Wd5/VgGid
         cL3MWYkoPyfQWLcWZX86uIV1Rr0a/91sJ1HhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EFGVMrtPzJu7QX+7VkbTBx9ZvGQmtFRK5Si6r3FG/d2zLZ9C9h3APtBHIgJv8D+AHI
         /NZMtMqBaBhZMKuoqRfSiTPFn41Yn0wJGAAE8xSpm4xtVQ/EhmWXyjGcfd8XbGWriszP
         mtVoySLL8ZDRhTVhgH80FXxIUftSIoG4KqtD0=
Received: by 10.220.76.144 with SMTP id c16mr4227840vck.17.1240074487745;
        Sat, 18 Apr 2009 10:08:07 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.08.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:08:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-11-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116855>

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   43 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 93c39e1..3b36ac7 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -194,6 +194,7 @@ Automating
 	'sendemail.<identity>' subsection to take precedence over
 	values in the 'sendemail' section. The default identity is
 	the value of the 'sendemail.identity' configuration variable.
+	See the *CONFIGURATION* section for more details.
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in Signed-off-by: or Cc: lines to the
@@ -282,6 +283,48 @@ default to '--validate'.
 CONFIGURATION
 -------------
 
+Configuration subsections are very useful in combination with '--identity'.
+For instance, consider a configuration file that contains the following:
+
+	...
+
+	[sendemail]
+		smtpencryption = tls
+		smtpserver     = smtp.example.com
+		smtpuser       = user@example.com
+		suppresscc     = self
+		confirm        = always
+		identity       = test
+
+	[sendemail "test"]
+		to = user@example.com
+
+	[sendemail "git-rfc"]
+		to = git@vger.kernel.org
+
+	[sendemail "git-submit"]
+		to      = gitster@pobox.com
+		cc      = git@vger.kernel.org
+		confirm = never
+
+	...
+
+With this configuration, 'send-email' processes the variables in `[sendemail]`.
+Then, 'sendemail.identity' tells 'send-email' to process the variables in the
+`[sendemail "test"]` subsection. Thus:
+
+	git send-email <patch>
+
+would send `<patch>` to `user@example.com` as a "test". When the user
+decides that `<patch>` is ready to be sent for real, the user could
+email the 'git' mailing list to make a request for comments (RFC):
+
+	git send-email <patch> --identity git-rfc
+
+Then, for final submission:
+
+	git send-email <patch> --identity git-submit
+
 Composing
 ~~~~~~~~~
 
-- 
1.6.2.2.479.g2aec
