From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/5] pull: cleanup documentation
Date: Sat, 14 Sep 2013 01:38:37 -0500
Message-ID: <1379140717-12940-6-git-send-email-felipe.contreras@gmail.com>
References: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:44:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjaV-0003fX-U3
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab3INGoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:44:04 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:57621 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692Ab3INGoC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:44:02 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so1922638obc.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Me6rgfCB3z3u1jVDfvKYHfODI5bNGTvO2s+GNE7pwgU=;
        b=p2xUSs7aY1fL055V3yx3Yl8CMpXZ5rFsPgOs1Cz6zux9vn1jC7kd0lOkOwDttJcNr7
         r5Vu3mEyAedR9s7wToJnSXejPPAaBCxQDAZAMNRYdfKSqd+Grx+whSvWAIC9WIxGpeX6
         wkN0djuDVLQgRLn3hB0JA463K3K1x71UccRTukehpAjhCpFFfK6iKUxxSpZK7RwBBmsq
         vcgHBB0GoNxSg8u/EJmak3RsIFRCOm9bfbVgEEPWELQvGGPIoR7bO5PTiBVuggipk2vY
         SjWGaqwdENlhNcjIV+8FReEao9kDWUA85SuVephnFr2LL6jU4R0x5j2AFAb4SHYl9anN
         umDg==
X-Received: by 10.60.63.167 with SMTP id h7mr15713239oes.43.1379141042284;
        Fri, 13 Sep 2013 23:44:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ru3sm20326797obc.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:44:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234801>

'origin/master' is very clear, no need to specify the 'remotes/' prefix,
or babysit the user.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6ef8d59..4dd941d 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
 "`master`":
 
 ------------
-	  A---B---C master on origin
+	  A---B---C origin/master
 	 /
     D---E---F---G master
 ------------
@@ -51,7 +51,7 @@ result in a new commit along with the names of the two parent commits
 and a log message from the user describing the changes.
 
 ------------
-	  A---B---C remotes/origin/master
+	  A---B---C origin/master
 	 /         \
     D---E---F---G---H master
 ------------
-- 
1.8.4-fc
