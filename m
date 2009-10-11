From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/3] user-manual: use 'fast-forward'
Date: Sun, 11 Oct 2009 23:46:13 +0300
Message-ID: <1255293973-17444-4-git-send-email-felipe.contreras@gmail.com>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>
 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 22:49:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx5Lz-0001qp-3g
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 22:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbZJKUq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZJKUq7
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 16:46:59 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:54217 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZJKUq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 16:46:58 -0400
Received: by fxm27 with SMTP id 27so8435176fxm.17
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=heoSMywHfm9LuyLjjIjIq6UJ1nArWI4lNjdXyXV/+zk=;
        b=w5i8GYZWd0H9VfB67JJ6Gr6OwPVJK5hIl6b3yaeraGm0PO9I/tBSbrUNh8oSCk2aoN
         y7LDAegAPmIabtYouLGVgMVuGC837pxcSqsMV8GvsGLUq4knBXuENqP9aW0DrvcbIMFU
         yLhDUTCV9ws7bN8fdLK5umjet5PFa7EPYpo10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Y6s1XoGnG6I0vHvMCcnqxD+bA0H8FytgH/WZn5iuV1X7n3lApwBNfInfxJl8Q3qFti
         snd4m5AFnUzRJ7aITPk2XYPGQe4bF4d17CgDcbZwQvhEoiSPQa40ZgSnOAbaVzhiWvOY
         EJ4HwznMTY4+74iG869vXPgh9yO8ZLsBA54pw=
Received: by 10.86.254.23 with SMTP id b23mr291885fgi.21.1255293981293;
        Sun, 11 Oct 2009 13:46:21 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 4sm3000918fge.27.2009.10.11.13.46.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 13:46:20 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.4.g31fc3
In-Reply-To: <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129952>

It's a compound word.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 67ebffa..42d92fd 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1384,7 +1384,7 @@ were merged.
 
 However, if the current branch is a descendant of the other--so every
 commit present in the one is already contained in the other--then git
-just performs a "fast forward"; the head of the current branch is moved
+just performs a "fast-forward"; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
 
@@ -1719,7 +1719,7 @@ producing a default commit message documenting the branch and
 repository that you pulled from.
 
 (But note that no such commit will be created in the case of a
-<<fast-forwards,fast forward>>; instead, your branch will just be
+<<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
 The `git pull` command can also be given "." as the "remote" repository,
@@ -1943,7 +1943,7 @@ $ git push ssh://yourserver.com/~you/proj.git master
 -------------------------------------------------
 
 As with `git fetch`, `git push` will complain if this does not result in a
-<<fast-forwards,fast forward>>; see the following section for details on
+<<fast-forwards,fast-forward>>; see the following section for details on
 handling this case.
 
 Note that the target of a "push" is normally a
@@ -1976,7 +1976,7 @@ details.
 What to do when a push fails
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If a push would not result in a <<fast-forwards,fast forward>> of the
+If a push would not result in a <<fast-forwards,fast-forward>> of the
 remote branch, then it will fail with an error like:
 
 -------------------------------------------------
@@ -2115,7 +2115,7 @@ $ git checkout release && git pull
 
 Important note!  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a "Fast forward" merge).  Many people dislike
+changes git will simply do a fast-forward merge).  Many people dislike
 the "noise" that this creates in the Linux history, so you should avoid
 doing this capriciously in the "release" branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
@@ -2729,9 +2729,9 @@ In the previous example, when updating an existing branch, "git fetch"
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
-commit.  Git calls this process a <<fast-forwards,fast forward>>.
+commit.  Git calls this process a <<fast-forwards,fast-forward>>.
 
-A fast forward looks something like this:
+A fast-forward looks something like this:
 
 ................................................
  o--o--o--o <-- old head of the branch
-- 
1.6.5.4.g31fc3
