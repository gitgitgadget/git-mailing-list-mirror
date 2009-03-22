From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 5/8] user-manual: use 'fast-forward' instead of 'fast forward'
Date: Sun, 22 Mar 2009 20:05:18 +0200
Message-ID: <1237745121-6325-6-git-send-email-felipe.contreras@gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-4-git-send-email-felipe.contreras@gmail.com>
 <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 19:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlS5f-0000xY-CE
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 19:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbZCVSF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 14:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbZCVSFz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 14:05:55 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:51137 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbZCVSFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 14:05:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so669137fkq.5
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2O8UThodU72fVxaYXVoTUQwpW7/ey9HCo2tEjLrAX60=;
        b=xeVJse2GjBvNX0uodjC7dndS7XXJRmHMYh7+l7DWuVSPhY6ou2sPWE7CbLGY0DsTr5
         it/6BUtC7Avvqf7J192NWN9TU7jNFpnbJNnJ35CNEE/ISu8GSaGoqzDgpKRe1qGm1vKA
         2TuWr38HLfHRbQ3aGkbuJwYCzQL2iWMth602U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KNR84JNTN738jEkbu8ppeM5z6Csoeuul6mdf6S4/NGcHCJsndbNOku49F/jo6yudXD
         MS8qcVumJgpM9n+w2eY1b5gHPNVrtXiVXhbZ7jW5wnxmWWE5+fPgNgvsgypZ/lxGRhBN
         r/cS4VfFWRMXzmGED22f+hP9yFwAJeEGUK9kw=
Received: by 10.223.113.132 with SMTP id a4mr5243060faq.75.1237745148238;
        Sun, 22 Mar 2009 11:05:48 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id 13sm5286267fks.7.2009.03.22.11.05.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Mar 2009 11:05:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.352.gae594
In-Reply-To: <1237745121-6325-5-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114162>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/user-manual.txt |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 0d5726c..118bbe2 100644
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
1.6.2.1.352.gae594
