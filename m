From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 8/8] glossary: Update and rephrase the definition of a remote-tracking branch
Date: Sun, 21 Apr 2013 23:52:06 +0200
Message-ID: <1366581126-3880-9-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2C9-0000fI-MA
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab3DUVxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:53:01 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34510 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752712Ab3DUVw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:58 -0400
Received: by mail-la0-f52.google.com with SMTP id fd20so1050929lab.39
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dBf7d5lqPbtfnRrK6oJ2J0M6Nimno1gnprU+/9sSbb0=;
        b=VUfdDioh1nswT5REVNa1z3U0uIG5B0VcOXwSLSli4opI3COLis01lkbvwpvC/Ni0rO
         3cj3SbEirNgEOuTHBecPh1xiXG+ekyy4VvhVAoKRhYhUsX8oX4rhzirSZlH3EBYCovQc
         bOr5M4FxOs0o/rT1cjuk767/2H7UZtMGvaCpDhyKsMFM0r0PQtjGQcCETTdqXcWnG9IY
         D/TxvWyIeEIOVKn/oYSvA02QbYZnC/TQjJ+N7YXztsCNK5Ff/8OV+RCIyNfYmdrQ2DTy
         Ulua2az+mAIXQYss+zocaieelV8Cz13UlLaA5UbvNoyTMwnNcJzVk/Q5CaRwEJVMZbSO
         WeJg==
X-Received: by 10.152.87.116 with SMTP id w20mr2120728laz.0.1366581176293;
        Sun, 21 Apr 2013 14:52:56 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221977>

The definition of a remote-tracking branch in the glossary have been
out-of-date for a while (by e.g. referring to "Pull:" from old-style
$GIT_DIR/remotes files).

Also, the preceding patches have formalized that a remote-tracking branch
must match a configured refspec in order to be usable as an upstream.

This patch rewrites the paragraph on remote-tracking branches accordingly.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/glossary-content.txt | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 2478a39..7a79f26 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -423,12 +423,13 @@ should not be combined with other pathspec.
 	linkgit:git-push[1].
 
 [[def_remote_tracking_branch]]remote-tracking branch::
-	A regular Git <<def_branch,branch>> that is used to follow changes from
-	another <<def_repository,repository>>. A remote-tracking
-	branch should not contain direct modifications or have local commits
-	made to it. A remote-tracking branch can usually be
-	identified as the right-hand-side <<def_ref,ref>> in a Pull:
-	<<def_refspec,refspec>>.
+	A <<def_ref,ref>> that is used to follow changes from another
+	<<def_repository,repository>>. It typically looks like
+	'refs/remotes/foo/bar' (indicating that it tracks a branch named
+	'bar' in a remote named 'foo'), and matches the right-hand-side of
+	a configured fetch <<def_refspec,refspec>>. A remote-tracking
+	branch should not contain direct modifications or have local
+	commits made to it.
 
 [[def_repository]]repository::
 	A collection of <<def_ref,refs>> together with an
-- 
1.8.1.3.704.g33f7d4f
