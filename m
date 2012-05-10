From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 18:45:12 +0200
Message-ID: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 18:45:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWUu-0000kG-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab2EJQpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:45:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62265 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab2EJQpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:45:43 -0400
Received: by yenm10 with SMTP id m10so1672268yen.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=yEZcFJdvJvs8sIGY6OhTqI0MT9/DBRyl6CjKj2DPfoE=;
        b=RNrKIYDU2fifWE4RggaCKceD8JNqOSnEb3OksvJ1hm48Bkwl7wEuEA7qp8fLkckv3f
         0oNvgDBaWAn49xrv6FIpmKIk0rOuRYKT2acjeUKHapvwgWtdRIx9mCTwoO+fI2eP8wDk
         k7fFFJuOCOl8ZA4JVF7zsZBUnGV9AKlku9AFRKTa7wH9iOdifHpOFs6P5SUX3c/6rYuJ
         nd5Aiq1Ho5XIO1zeaiwia4zPk2JKY7ljLa0u6aEF3MAVH7yrrkjVjZtu9DdbsjK8HJFJ
         +hUJ8kp76YtAmLVeowErmpiXdeoIC1RFOdqRcxypCSg7mO41LRehqqrVsFfViphGzEh9
         B+ng==
Received: by 10.50.190.202 with SMTP id gs10mr3108099igc.45.1336668342556;
 Thu, 10 May 2012 09:45:42 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 09:45:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197596>

Here's a patch removing the weird bits. I spoke about in my previous message.

Philippe


Signed-off-by: Philippe Vaucher <philippe.vaucher@gmail.com>
---
 Documentation/git-commit-tree.txt |    9 ---------
 Documentation/git-var.txt         |    9 ---------
 2 files changed, 18 deletions(-)

diff --git a/Documentation/git-commit-tree.txt
b/Documentation/git-commit-tree.txt
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
