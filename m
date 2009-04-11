From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC 02/10] Docs: send-email: Remove superfluous information in CONFIGURATION
Date: Sat, 11 Apr 2009 14:08:20 -0500
Message-ID: <1239476908-25944-2-git-send-email-mfwitten@gmail.com>
References: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 11 21:11:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsibr-0001aa-7P
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbZDKTJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757719AbZDKTJv
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:09:51 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:54758 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbZDKTJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:09:50 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1616389yxl.1
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LEjP/fi+Z754ovgmEaEBx9qSofaovcaHh613li/P5Zc=;
        b=EgkzBqJQyuWgxAK5eI9VNZ5grF9QTN5shCeoZiyB0JSRjUP/xqDrXWKKk8ntTXUzcW
         CqHkn+hWxDppGm3vLEXcO5qG/37N69Mk4nRlrpshW6rRFL/2+l+qAXnhODbO62PgeRKL
         0i2yLxwf4fz5JvYQTzG75fETzpvp8y7Zzw1Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AwkieflJgtLIiaiWHPgU/O1ww6kwpOHJ4nbf6+MVaggwfQDX1kg4cIfpgzfbkpLzyE
         SjtUphEkIhYsgNDhfuQFK5i/pELM9P7yhxnjaccYNfeZgFOEt17eacraC7WGmqCI+Tb7
         h7ZRIq1gvjzgzL2VsXJMajGTW0lnylB49EvUE=
Received: by 10.100.229.12 with SMTP id b12mr795698anh.46.1239476989567;
        Sat, 11 Apr 2009 12:09:49 -0700 (PDT)
Received: from localhost.localdomain (97-116-109-29.mpls.qwest.net [97.116.109.29])
        by mx.google.com with ESMTPS id 9sm5461438ywf.6.2009.04.11.12.09.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Apr 2009 12:09:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239476908-25944-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116311>

In particular, sendemail.confirm was removed, because it's already
described along with its corresponding option.

There is now a comment block warning trespassers.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 595c7ba..7cdbdd6 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -257,6 +257,11 @@ Default is the value of 'sendemail.validate'; if this is not set,
 default to '--validate'.
 
 
+//////////////////////////////////////////////////////////////////////////////
+//// Only list configuration variables that can't be listed and described ////
+//// with a corresponding option above                                    ////
+//////////////////////////////////////////////////////////////////////////////
+
 CONFIGURATION
 -------------
 
@@ -274,12 +279,6 @@ sendemail.multiedit::
 	summary when '--compose' is used). If false, files will be edited one
 	after the other, spawning a new editor each time.
 
-sendemail.confirm::
-	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
-	in the previous section for the meaning of these values.
-
-
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
-- 
1.6.2.2.479.g2aec
