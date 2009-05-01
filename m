From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/4] user-manual: use 'fast-forward' instead of 'fast forward'
Date: Fri,  1 May 2009 11:44:20 +0300
Message-ID: <1241167462-5984-3-git-send-email-felipe.contreras@gmail.com>
References: <1241167462-5984-1-git-send-email-felipe.contreras@gmail.com>
 <1241167462-5984-2-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 10:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzoMg-0003LM-1w
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 10:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZEAIot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 04:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbZEAIos
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 04:44:48 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:61813 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbZEAIoi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 04:44:38 -0400
Received: by fxm2 with SMTP id 2so2231051fxm.37
        for <git@vger.kernel.org>; Fri, 01 May 2009 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/zjioEBpAwCW3cp5XeaqR61nh8dmwKh61ZLoEHCNQYI=;
        b=BS2CVwF1pOG631j2hH3Y1cSQR4a22krTxdYKTBWzbgBC8/yJgPMrNzyy6qHB2jcNJL
         n7+/eAKhSoKh3XbyBibxkaNP9nNogEVweTyPWHHosuf5j6TsPTAjHVVYX2/mXEXlZUmG
         efqqL94wcUMuQPgk0AGDvJ1M3BfNgYHzvKyFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nTJ5+TB496i2LiIJIBnFsVkS3/eyay/jJ9D/smxKow85A2mSZw6X7Uwz6bklquE7hz
         ytmlcnFSQ3MLcHM4JkKSqmWmYYg0ymD2S21KMHQrnKKDyJTeACHuJyyFiaJSqfXFlZQ/
         SLVlXKIHPaxlB+qw8sVPcj5pjamYdxeFqw2O0=
Received: by 10.86.82.6 with SMTP id f6mr2669242fgb.69.1241167477499;
        Fri, 01 May 2009 01:44:37 -0700 (PDT)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id l12sm1378354fgb.6.2009.05.01.01.44.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 01 May 2009 01:44:37 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc3.13.g195b.dirty
In-Reply-To: <1241167462-5984-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118062>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a8558a1..9978027 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1384,7 +1384,7 @@ were merged.
 
 However, if the current branch is a descendant of the other--so every
 commit present in the one is already contained in the other--then git
-just performs a '``fast forward'''; the head of the current branch is moved
+just performs a 'fast-forward'; the head of the current branch is moved
 forward to point at the head of the merged-in branch, without any new
 commits being created.
 
@@ -1719,7 +1719,7 @@ producing a default commit message documenting the branch and
 repository that you pulled from.
 
 (But note that no such commit will be created in the case of a
-<<fast-forwards,fast forward>>; instead, your branch will just be
+<<fast-forwards,fast-forward>>; instead, your branch will just be
 updated to point to the latest commit from the upstream branch.)
 
 The `git pull` command can also be given '"."' as the 'remote' repository,
@@ -1943,7 +1943,7 @@ $ git push ssh://yourserver.com/~you/proj.git master
 -------------------------------------------------
 
 As with `git fetch`, `git push` will complain if this does not result in a
-<<fast-forwards,fast forward>>; see the following section for details on
+<<fast-forwards,fast-forward>>; see the following section for details on
 handling this case.
 
 Note that the target of a 'push' is normally a
@@ -1976,7 +1976,7 @@ details.
 What to do when a push fails
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If a push would not result in a <<fast-forwards,fast forward>> of the
+If a push would not result in a <<fast-forwards,fast-forward>> of the
 remote branch, then it will fail with an error like:
 
 -------------------------------------------------
@@ -2115,7 +2115,7 @@ $ git checkout release && git pull
 
 *Important note!*  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a 'fast forward' merge).  Many people dislike
+changes git will simply do a 'fast-forward' merge).  Many people dislike
 the ``noise'' that this creates in the Linux history, so you should avoid
 doing this capriciously in the 'release' branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
@@ -2729,9 +2729,9 @@ In the previous example, when updating an existing branch, "git fetch"
 checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
-commit.  Git calls this process a <<fast-forwards,fast forward>>.
+commit.  Git calls this process a <<fast-forwards,fast-forward>>.
 
-A 'fast forward' looks something like this:
+A 'fast-forward' looks something like this:
 
 ................................................
  o--o--o--o <-- old head of the branch
-- 
1.6.3.rc3.13.g195b.dirty
