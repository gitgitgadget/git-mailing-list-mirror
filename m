From: Keshav Kini <keshav.kini@gmail.com>
Subject: [PATCH v2 2/4] git-svn.txt: reword description of gc command
Date: Sun, 29 Sep 2013 18:45:58 -0500
Message-ID: <1380498360-18387-3-git-send-email-keshav.kini@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 30 01:46:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQQhE-0000PL-EI
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 01:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab3I2Xqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 19:46:37 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:37643 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3I2Xqg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 19:46:36 -0400
Received: by mail-oa0-f50.google.com with SMTP id j1so3381501oag.23
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzPhxvG54KcHbdVgRcYLn4HobpgglHx071koNZAV95M=;
        b=G9DtfeF1F3sJTEoP29pj6UcqlARDr/JJ4rhghhlPGlyfM4ge+AwiBEhikjuc8r8OxZ
         PmKKATWbqUpdIUbOW6o5hYb/l4EEQE8/V5b+Q5YilBbMjOpyRWCuZ9m9nhdJ8R8pvHvl
         InAWy8Q/nPgMxc2xFqanottCcW5nDkWvuI6VAK2DzuKkHb66K2/KaPu9jpNQ+GV43Nr9
         SsNlzgpKSe+tJxYlVDCs646DAxPbDvCsJ5+WUZGYEj9B9DXLd1hW1sk5BGewxGGTJ0PW
         nN7N+JK/q64WbvfPcRdKGn8unP7xfPCFLGCo/kb7RWvLD92qJKM1x5rvcZhTqlP+kOJY
         SxQQ==
X-Received: by 10.60.155.166 with SMTP id vx6mr17554899oeb.28.1380498395471;
        Sun, 29 Sep 2013 16:46:35 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id gc8sm25720096obb.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 16:46:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235610>

It's redundant to say that $GIT_DIR/svn/<refname>/unhandled.log or
$GIT_DIR/svn/<refname>/index is in .git/svn when $GIT_DIR is '.git', and
is wrong when $GIT_DIR is not '.git'

Also, a '/' was missing from the pathname $GIT_DIR/svn/<refname>/index .

Signed-off-by: Keshav Kini <keshav.kini@gmail.com>
---
 Documentation/git-svn.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 239c33c..62ec727 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -435,8 +435,8 @@ Any other arguments are passed directly to 'git log'
 	specific revision.
 
 'gc'::
-	Compress $GIT_DIR/svn/<refname>/unhandled.log files in .git/svn
-	and remove $GIT_DIR/svn/<refname>index files in .git/svn.
+	Compress $GIT_DIR/svn/<refname>/unhandled.log files and remove
+	$GIT_DIR/svn/<refname>/index files.
 
 'reset'::
 	Undoes the effects of 'fetch' back to the specified revision.
-- 
1.8.3.2
