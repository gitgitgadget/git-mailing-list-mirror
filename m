From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Standardize python shebangs
Date: Wed,  7 May 2014 05:03:07 -0500
Message-ID: <1399456987-24156-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 12:14:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhyrP-0002C9-5b
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 12:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316AbaEGKNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 06:13:55 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:43415 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbaEGKNy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 06:13:54 -0400
Received: by mail-ob0-f171.google.com with SMTP id wn1so909011obc.16
        for <git@vger.kernel.org>; Wed, 07 May 2014 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qX90T5g7WAg+VF/GQm9uMgIdM6/xRKAObATzUO9DOcg=;
        b=rhwP1uvn33vDhcmicPodzCCXEdDKNniQKpF/20inj7MkZegBVLBGmgXR7/jz5zH+fA
         XLH17zmN4/ZYbCNWYkZfHfTapYXUHwPUXxrPwFSjXiUhIWpCGKrYOQzsmsyOWW2jkmNE
         Qpo13k8iaKtzFlcCskrQzPty3jqTcLTgqIS22jzRRkU9oAlmgs8/fMz+kX4A2ySkWpOD
         zNwHyH9zmBktsBORHje8TORxhgxLAZJ/zsPhBzg0MYrdpw1rstWqfayLyiOeEGZBzylT
         lsiGhjz14DuBz1nYqHe18uF5u240/+pIAQSlqg2o1MwcLZEyTbPdINHtQSV/toPbmNl6
         uEJQ==
X-Received: by 10.60.132.236 with SMTP id ox12mr1066524oeb.81.1399457634003;
        Wed, 07 May 2014 03:13:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id tz6sm33403001obc.10.2014.05.07.03.13.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 May 2014 03:13:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.25.g15bd061
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248292>

It's better if all our scripts use the same '/usr/bin/env python'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/hooks/multimail/README                  | 6 +++---
 contrib/hooks/multimail/git_multimail.py        | 2 +-
 contrib/hooks/multimail/migrate-mailhook-config | 2 +-
 contrib/hooks/multimail/post-receive            | 2 +-
 contrib/svn-fe/svnrdump_sim.py                  | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/hooks/multimail/README b/contrib/hooks/multimail/README
index 477d65f..cf0bcb8 100644
--- a/contrib/hooks/multimail/README
+++ b/contrib/hooks/multimail/README
@@ -76,10 +76,10 @@ Requirements
   The example scripts invoke Python using the following shebang line
   (following PEP 394 [1]):
 
-      #! /usr/bin/env python2
+      #! /usr/bin/env python
 
-  If your system's Python2 interpreter is not in your PATH or is not
-  called "python2", you can change the lines accordingly.  Or you can
+  If your system's Python interpreter is not in your PATH or is not
+  called "python", you can change the lines accordingly.  Or you can
   invoke the Python interpreter explicitly, for example via a tiny
   shell script like
 
diff --git a/contrib/hooks/multimail/git_multimail.py b/contrib/hooks/multimail/git_multimail.py
index 8b58ed6..f6dcdc6 100755
--- a/contrib/hooks/multimail/git_multimail.py
+++ b/contrib/hooks/multimail/git_multimail.py
@@ -1,4 +1,4 @@
-#! /usr/bin/env python2
+#! /usr/bin/env python
 
 # Copyright (c) 2012-2014 Michael Haggerty and others
 # Derived from contrib/hooks/post-receive-email, which is
diff --git a/contrib/hooks/multimail/migrate-mailhook-config b/contrib/hooks/multimail/migrate-mailhook-config
index 04eeaac..fba0b90 100755
--- a/contrib/hooks/multimail/migrate-mailhook-config
+++ b/contrib/hooks/multimail/migrate-mailhook-config
@@ -1,4 +1,4 @@
-#! /usr/bin/env python2
+#! /usr/bin/env python
 
 """Migrate a post-receive-email configuration to be usable with git_multimail.py.
 
diff --git a/contrib/hooks/multimail/post-receive b/contrib/hooks/multimail/post-receive
index 4d46828..4f2cf9d 100755
--- a/contrib/hooks/multimail/post-receive
+++ b/contrib/hooks/multimail/post-receive
@@ -1,4 +1,4 @@
-#! /usr/bin/env python2
+#! /usr/bin/env python
 
 """Example post-receive hook based on git-multimail.
 
diff --git a/contrib/svn-fe/svnrdump_sim.py b/contrib/svn-fe/svnrdump_sim.py
index 4e78a1c..bf20819 100755
--- a/contrib/svn-fe/svnrdump_sim.py
+++ b/contrib/svn-fe/svnrdump_sim.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 """
 Simulates svnrdump by replaying an existing dump from a file, taking care
 of the specified revision range.
-- 
1.9.2+fc1.25.g15bd061
