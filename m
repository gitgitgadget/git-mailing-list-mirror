From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH] wording fixes in the user manual and glossary
Date: Sat, 24 May 2014 20:50:41 -0700
Message-ID: <1400989841-2845-1-git-send-email-jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 25 05:51:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoPTZ-0004D3-KE
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 05:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaEYDvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 23:51:50 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:59545 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaEYDvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 23:51:49 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so5995047pbb.25
        for <git@vger.kernel.org>; Sat, 24 May 2014 20:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kE9Bku0oWMBvZpEhGxv7a5sogpjaIbRS5kyVDpI8X9Q=;
        b=ClfMGed1TF8DcoUUPYqXqdwg+dUilMjTvsLBsKFWZibxLzv3WXPdqVRpm+l2FHor4Z
         xC31RqGIFHcpq6Gub9pBuDBWS1Uorg1dVtpU7k/M6GDC67EZ7aRkzv1vCQAyBx0ltz6M
         cnbMU5o8ojUyHGbJo7DulOMrFRJr6rPaZVNA9uE2jpiQi2/E49du5hL1JAUQkdz4e8Eo
         QANXZ9x9eUkmvDXYLpmjpmYGcIQJWPv/YXuIux7uD0k7jUxetZxttwVb/M25VtnVynts
         74MCPFX3R0g1tagpeYxPVJns7RUZnYALniUG9hGmxg1iN2ppERjmO4C9610E9ipq5tQz
         TZUg==
X-Received: by 10.68.226.105 with SMTP id rr9mr877326pbc.161.1400989909440;
        Sat, 24 May 2014 20:51:49 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id mq10sm1019544pbc.62.2014.05.24.20.51.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 24 May 2014 20:51:48 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 24 May 2014 20:51:45 -0700
X-Mailer: git-send-email 2.0.0.rc4.479.gd6c9c28
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250066>

Some minor wording fixes in the user manual and glossary.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/glossary-content.txt | 2 +-
 Documentation/user-manual.txt      | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index be0858c..4e0b971 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -1,7 +1,7 @@
 [[def_alternate_object_database]]alternate object database::
 	Via the alternates mechanism, a <<def_repository,repository>>
 	can inherit part of its <<def_object_database,object database>>
-	from another object database, which is called "alternate".
+	from another object database, which is called an "alternate".
 
 [[def_bare_repository]]bare repository::
 	A bare repository is normally an appropriately
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d33f884..efb3c97 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -416,7 +416,7 @@ REVISIONS" section of linkgit:gitrevisions[7].
 Updating a repository with git fetch
 ------------------------------------
 
-Eventually the developer cloned from will do additional work in her
+Eventually the developer will do additional work in her cloned
 repository, creating new commits and advancing the branches to point
 at the new commits.
 
@@ -1811,8 +1811,8 @@ manner.
 You can then import these into your mail client and send them by
 hand.  However, if you have a lot to send at once, you may prefer to
 use the linkgit:git-send-email[1] script to automate the process.
-Consult the mailing list for your project first to determine how they
-prefer such patches be handled.
+Consult the mailing list for your project first to determine
+their requirements for submitting patches.
 
 [[importing-patches]]
 Importing patches to a project
@@ -2255,7 +2255,7 @@ $ git checkout test && git merge speed-up-spinlocks
 It is unlikely that you would have any conflicts here ... but you might if you
 spent a while on this step and had also pulled new versions from upstream.
 
-Some time later when enough time has passed and testing done, you can pull the
+Sometime later when enough time has passed and testing done, you can pull the
 same branch into the `release` tree ready to go upstream.  This is where you
 see the value of keeping each patch (or patch series) in its own branch.  It
 means that the patches can be moved into the `release` tree in any order.
-- 
2.0.0.rc4.479.gd6c9c28
