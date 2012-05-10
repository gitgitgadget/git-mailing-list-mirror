From: Angus Hammond <angusgh@gmail.com>
Subject: [PATCH 2/2] Remove diagnostics section from commit-tree and var man pages New error messages shouldn't need explaining like the old ones did so just delete the diagnostics section of the man pages. Signed-off-by: Angus Hammond <angusgh@gmail.com>
Date: Thu, 10 May 2012 20:06:10 +0100
Message-ID: <1336676770-17965-2-git-send-email-angusgh@gmail.com>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Cc: Angus Hammond <angusgh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 21:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSYhD-000293-C1
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760019Ab2EJTGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 15:06:33 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33484 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758752Ab2EJTGb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:06:31 -0400
Received: by wgbdr13 with SMTP id dr13so1765873wgb.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=K37dYliR9WHgJCPPS5Q1uhhkHbS2o1CE1TIg3hldXt8=;
        b=FJDmuT3GgcZvB2Einq4/1q9vwVKB+s7+vvr5xQGsu5AifFYhE1goLQMw+fNTXeL2mY
         C61hIxFk+6AMpZju7iIutaoyRe6YOMmSggZaQz3Xj1eOYSDw7cswampXmlfseV78Wq4b
         TGLsO+3k7Nv1Eo4GFpg4n3fd6HTlzsunQZ4BvztllPx7ehMxCFT8IoTsWlYnGykwhS3E
         hD5mkYYmMNYimsEMORAprvjfvyY5HeJbKeATmabC+cf86vjcojB3fVLQdSOkYL2IdbN8
         d14RNTHOR3FkeVqRhoA2DWdiqUNJjFxaSRtAQXKzYViTpeWyyzgSyfhZC6qeXFYbX+bV
         dA3A==
Received: by 10.180.24.7 with SMTP id q7mr327398wif.11.1336676790691;
        Thu, 10 May 2012 12:06:30 -0700 (PDT)
Received: from angus-laptop.lan (levelgrove.demon.co.uk. [62.49.19.234])
        by mx.google.com with ESMTPS id o9sm8065149wia.3.2012.05.10.12.06.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 12:06:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197617>

---
 Documentation/git-commit-tree.txt |    9 ---------
 Documentation/git-var.txt         |    9 ---------
 2 files changed, 18 deletions(-)

diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index cfb9906..eb8ee99 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -88,15 +88,6 @@ for one to be entered and terminated with ^D.
 
 include::date-formats.txt[]
 
-Diagnostics
------------
-You don't exist. Go away!::
-    The passwd(5) gecos field couldn't be read
-Your parents must have hated you!::
-    The passwd(5) gecos field is longer than a giant static buffer.
-Your sysadmin must hate you!::
-    The passwd(5) name field is longer than a giant static buffer.
-
 Discussion
 ----------
 
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 988a323..67edf58 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -59,15 +59,6 @@ ifdef::git-default-pager[]
     The build you are using chose '{git-default-pager}' as the default.
 endif::git-default-pager[]
 
-Diagnostics
------------
-You don't exist. Go away!::
-    The passwd(5) gecos field couldn't be read
-Your parents must have hated you!::
-    The passwd(5) gecos field is longer than a giant static buffer.
-Your sysadmin must hate you!::
-    The passwd(5) name field is longer than a giant static buffer.
-
 SEE ALSO
 --------
 linkgit:git-commit-tree[1]
-- 
1.7.9.5
