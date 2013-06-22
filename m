From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 09/14] ls-remote doc: rewrite <repository> paragraph
Date: Sat, 22 Jun 2013 13:28:16 +0530
Message-ID: <1371887901-5659-10-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:03:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqImo-0000qp-UV
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423187Ab3FVIC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:02:59 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35840 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423756Ab3FVICA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:02:00 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so8755444pbb.5
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Kbg8T8BL716SRo/wch5h3Cr4Q5y6H+Vj3eQMotuLyPo=;
        b=D6AnNzgIGArU4mHpkLiM/LTVF64cnf5F0WvdG7WBtlQgaAOjatR0RqGR3ZLYXI2FJF
         mealh5C4vec7pF3CLm+gurB1ViYPO9RnfWrMflOmUG7N23OBAZAetU4/CFJyYYtWmoq8
         5l/YO7KBRZmjXiR8WSBHOUQ7F1vPQvYugf7VNoEmYtUNLQiMLw2Bt1pkIYtPFxCo1ugY
         QvdbYw6QSgAgfTklMNme/Y6vD8szb5WQkfxumLuim9J+UfM4LBlt50gm1w654vExVyTc
         GNHjSsEMLCMezmWM2zmTY6SDHouzb3S3BVFppYNqgMNWErZXwNR8S4+m1Ub8SFJqrXYX
         mygw==
X-Received: by 10.68.164.97 with SMTP id yp1mr15594319pbb.77.1371888120425;
        Sat, 22 Jun 2013 01:02:00 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228689>

Replace the <repository> paragraph containing specific references to
$GIT_DIR/branches and "." with a generic urls-or-remotes paragraph
referencing the relevant sections in the git-fetch(1) manpage.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-ls-remote.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index cce4f93..283fc0c 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -48,9 +48,9 @@ OPTIONS
 	exit without talking to the remote.
 
 <repository>::
-	Location of the repository.  The shorthand defined in
-	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
-	the local repository.
+	The "remote" repository to query.  This parameter can be
+	either a URL or the name of a remote (see the GIT URLS and
+	REMOTES sections of linkgit:git-fetch[1]).
 
 <refs>...::
 	When unspecified, all references, after filtering done
-- 
1.8.3.1.498.gacf2885
