From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] use "up-to-date" in messages instead of "uptodate" for consistency
Date: Tue,  6 Jul 2010 11:13:57 +0200
Message-ID: <7012ea639b8beddcd42eceff0898e33ce7c455e9.1278407491.git.nicolas.s.dev@gmx.fr>
References: <ACE6C748-1F26-473B-BC69-33C59A3969BD@wincent.com>
Cc: Wincent Colaiuta <win@wincent.com>, <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 11:14:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW4Ea-000174-HM
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 11:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081Ab0GFJO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 05:14:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50912 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab0GFJO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 05:14:26 -0400
Received: by bwz1 with SMTP id 1so3334775bwz.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=5S5vyqSC725Bu+0cFAdQcHS/OQTZ9P/pdSYpaxiTflw=;
        b=a4My5IAn1qjcYE5h/+6NTNytgGz/pCeM1ZsfOXQlmUCrnuCCEbHptiBU6JJvQU9b/g
         23qPdBMNTy2ERtaV5h7y3B2a8wiNHrrjRWlD0cFwrbv+EmklX8Y54+mdFcPxNuZR9wup
         23jUW2H685DqUwhdIsasSyor0Iy40u++Dt+Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=KjAjH+bZv0KaG93bT1UC3wKkRj4P31OmLiqnOKe24dJoT0X+BexukHkCPx47AIQzyO
         F419fEDnSTeWL01adWyN6GIkfZIbXAC75KzklNJuwNaLfmnTS2Juqbk6HUxRkRd0jp1o
         8j7340dEz2kAkcBAjWyRYgDo0rh8YAimNqIz0=
Received: by 10.204.163.134 with SMTP id a6mr3399997bky.162.1278407664926;
        Tue, 06 Jul 2010 02:14:24 -0700 (PDT)
Received: from localhost (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id bq20sm21306374bkb.16.2010.07.06.02.14.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 02:14:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.210.g7b476
In-Reply-To: <ACE6C748-1F26-473B-BC69-33C59A3969BD@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150338>

Signed-off-by: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
---
 merge-recursive.c |    2 +-
 unpack-trees.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 856e98c..fb6aa4a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1214,7 +1214,7 @@ int merge_trees(struct merge_options *o,
 	}
 
 	if (sha_eq(common->object.sha1, merge->object.sha1)) {
-		output(o, 0, "Already uptodate!");
+		output(o, 0, "Already up-to-date!");
 		*result = head;
 		return 1;
 	}
diff --git a/unpack-trees.c b/unpack-trees.c
index 8cf0da3..024846e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -22,7 +22,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
 	"Entry '%s' would be overwritten by merge. Cannot merge.",
 
 	/* not_uptodate_file */
-	"Entry '%s' not uptodate. Cannot merge.",
+	"Entry '%s' not up-to-date. Cannot merge.",
 
 	/* not_uptodate_dir */
 	"Updating '%s' would lose untracked files in it",
@@ -34,7 +34,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
 	"Entry '%s' overlaps with '%s'.  Cannot bind.",
 
 	/* sparse_not_uptodate_file */
-	"Entry '%s' not uptodate. Cannot update sparse checkout.",
+	"Entry '%s' not up-to-date. Cannot update sparse checkout.",
 
 	/* would_lose_orphaned */
 	"Working tree file '%s' would be %s by sparse checkout update.",
-- 
1.7.2.rc1.210.g7b476
