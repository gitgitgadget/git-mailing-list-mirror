From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 10/14] ls-remote doc: don't encourage use of branches-file
Date: Sat, 22 Jun 2013 13:28:17 +0530
Message-ID: <1371887901-5659-11-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIlx-0008JZ-Ry
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423773Ab3FVICJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:09 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:59491 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423731Ab3FVICD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:02:03 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl14so8850632pab.34
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=pNu9hn/dwmIytMbIWNq+YzK4nfs89NGvgn6hJ9ayGtw=;
        b=OquMWY/RjPw1aePi3tzOM9daZV4fvW/aoUdwchDmUecpPG6byDYPYFNBkNNY42C2Ve
         r8QLE2iIvz7zTnpOhWHHK9I1+bljXXQ8Fz1sPkbxDhX2jxmWLLCRsRzsxqM8tlDOXPWD
         BXMS9hrlF5jYoXVqDzpl6YvJGCznvnz0qflWgQ5wcw3HNaBYh5fb8Ag9OKO3x1UVo1cc
         cRmvWSa2NR/eglj4v+jQsxB1+UADF5CeDPowvI2BRIZVpuO3INPKaJZwMIWlNWDwNqfZ
         JFRaoZxUZzAMfPY9qPdWkQtb/yYZI3LyEE7vF/53qDkYuzBsGLcInecUyu/7NigoA7Bf
         6T6g==
X-Received: by 10.68.224.228 with SMTP id rf4mr15920930pbc.50.1371888122662;
        Sat, 22 Jun 2013 01:02:02 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.02.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:02:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228684>

One outdated example encourages the use of $GIT_DIR/branches files.
Replace it with an equivalent example using a remote.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-ls-remote.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 283fc0c..2e22915 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -70,8 +70,8 @@ EXAMPLES
 	$ git ls-remote http://www.kernel.org/pub/scm/git/git.git master pu rc
 	5fe978a5381f1fbad26a80e682ddd2a401966740	refs/heads/master
 	c781a84b5204fb294c9ccc79f8b3baceeb32c061	refs/heads/pu
-	$ echo http://www.kernel.org/pub/scm/git/git.git >.git/branches/public
-	$ git ls-remote --tags public v\*
+	$ git remote add korg http://www.kernel.org/pub/scm/git/git.git
+	$ git ls-remote --tags korg v\*
 	d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
 	f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
 	c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
-- 
1.8.3.1.498.gacf2885
