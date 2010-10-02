From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] SubmittingPatches: Document some extra tags used in commit messages
Date: Sat,  2 Oct 2010 10:07:43 +0530
Message-ID: <1285994263-31154-1-git-send-email-artagnon@gmail.com>
References: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 02 06:39:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1tsF-0004cs-8v
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 06:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255Ab0JBEi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 00:38:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38459 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab0JBEi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 00:38:58 -0400
Received: by pwj5 with SMTP id 5so709394pwj.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 21:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k2Ft7pT9iOZSCfgM7jqSvQuVFp1so4AICcBuuF69x1s=;
        b=PUDvJHj1bRgFTHB07FQHUM8ST2FHgCy8otIO+4IdpADKTBXg/PeYJkIFKg7pwl+gcY
         tB3gdBzjjZo1ViWIpB+45PgjsCWtiPnQLZwYj3h7xoBJhm0bL+o7X4m2hlbpcuLD7dCS
         ydOi/ZOSCogWGcjY3KOYfe5D0sal1asuGgIvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dpTlCkOklptw3hIPFRvIehqtfPqzCYR8F6JmU/Ngt7eq/sV3ill+5yUFPutp5bDtJi
         DYIvl8zovodD1pytNHOKNGd3WfxlNhlTKCDXAmp30j9M5cn+LG5MGlcwWGxPuNBWTkEk
         pEaS6B/8mCO+gXvM/iHuzdy2RZV6Ds8PSiccQ=
Received: by 10.142.186.1 with SMTP id j1mr5653246wff.164.1285994337755;
        Fri, 01 Oct 2010 21:38:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id 9sm2249888wfd.12.2010.10.01.21.38.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 21:38:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.256.g00e8a.dirty
In-Reply-To: <AANLkTi=91-TJ=C1dUKRXKYWYShWZ-LuLFG3hq1Ms+C+Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157792>

Document the meanings of the tags "Reported-by:", "Acked-by:",
"Reviewed-by:" and "Tested-by:" clearly. Also mention that the user is
free to use any custom tags.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Liked-by: Sverre Rabbelier <srabbelier@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/SubmittingPatches |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ece3c77..72741eb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -264,12 +264,21 @@ the change to its true author (see (2) above).
 Also notice that a real name is used in the Signed-off-by: line. Please
 don't hide your real name.
 
-Some people also put extra tags at the end.
-
-"Acked-by:" says that the patch was reviewed by the person who
-is more familiar with the issues and the area the patch attempts
-to modify.  "Tested-by:" says the patch was tested by the person
-and found to have the desired effect.
+If you like, you can put extra tags at the end:
+
+1. "Reported-by:" is used to to credit someone who found the bug that
+   the patch attempts to fix.
+2. "Acked-by:" says that the person who is more familiar with the area
+   the patch attempts to modify liked the patch.
+3. "Reviewed-by:", unlike the other tags, can only be offered by the
+   reviewer and means that she is completely satisfied that the patch
+   is ready for application.  It is usually offered only after a
+   detailed review.
+4. "Tested-by:" is used to indicate that the person applied the patch
+   and found it to have the desired effect.
+
+You can also create your own tag or use one that's in common usage
+such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
 
 ------------------------------------------------
 An ideal patch flow
-- 
1.7.2.2.409.gdbb11.dirty
