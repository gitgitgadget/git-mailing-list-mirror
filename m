From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] user-manual: use 'fast-forward' instead of 'fast forward'
Date: Sat,  4 Apr 2009 12:38:26 +0300
Message-ID: <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 11:41:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq2N8-00020I-1E
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 11:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079AbZDDJiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 05:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755598AbZDDJiy
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 05:38:54 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49844 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756338AbZDDJiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 05:38:51 -0400
Received: by fxm2 with SMTP id 2so1259915fxm.37
        for <git@vger.kernel.org>; Sat, 04 Apr 2009 02:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ie6hZEjAhFrMwkR97ZrU0b+89G4RdMSejV8V6ZemHuw=;
        b=g9FLCicQQMpulLxb8SMZ74F5Si71fCq9LIp91RbzyEZQhLrdj68NwuK39bgfFt7Y+x
         C/7Aw9FOY2/Vc1RNo0x+XPlU3VQNyvk/iZAa6CZiYWD2I++wooYuksqLAo99qrIyed4E
         RKgGhUlqRcXY2QZfS+M6jZI4mbPaTzaNQH7zo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YHYIGTE6FGB0UwM7fbMypM4qW/XxkE5+Cehn8ob7cjuKXHBXBfjmGUZ9PPRgCFMFpc
         xdSNtoXGQ1+dC/6R4APNKzkL48L9l+Q5fCZZ24cBaOh9F1VaBWofKJFkyGv88RwPOHzP
         WTnc+d/4ywY6OpPjWMva0WEsEUxpdDGxwd/Bo=
Received: by 10.204.119.71 with SMTP id y7mr764036bkq.24.1238837929088;
        Sat, 04 Apr 2009 02:38:49 -0700 (PDT)
Received: from localhost (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id y15sm656463fkd.12.2009.04.04.02.38.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Apr 2009 02:38:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
In-Reply-To: <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115575>

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
1.6.2.2.404.ge96f3
