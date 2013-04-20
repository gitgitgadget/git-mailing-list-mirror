From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 8/8] glossary: Update and rephrase the definition of a remote-tracking branch
Date: Sat, 20 Apr 2013 17:06:03 +0200
Message-ID: <1366470363-22309-9-git-send-email-johan@herland.net>
References: <1366470363-22309-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 20 17:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTZNK-0000Ee-No
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 17:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab3DTPGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 11:06:48 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:63627 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755427Ab3DTPGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 11:06:46 -0400
Received: by mail-la0-f41.google.com with SMTP id ee20so488465lab.14
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 08:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=dBf7d5lqPbtfnRrK6oJ2J0M6Nimno1gnprU+/9sSbb0=;
        b=EmFqvl2Qwqe2ADgfgck/DHZGqZb2A7sfJlFb+lZ4zsYJKCjxvLgS5ZNRdf5w4ZuFNv
         MGylW4U9dAJtrvMRup9d47Q+S39c8Pro7Mf4NT0ucHvXznIaMelyWn4RhjW/bsxL4K+q
         yR02GhEcOAqh2TYHlOf7XZMh63NhE+z5Y7Jh0jqyHbU+DRN5RB/qYcjqXmmiqAG+7kcL
         A/gkJfhwHDfOyjWAdHARqcUUDN21b1eiXkL8CvJK0ubUGTbE4SiJLKciVEI5Fa5wt6Jv
         XOE7zAxAD8gBpA7r8p5UPRhYebgmpUNDPhbIWFvpjNzWYRXOofVIYShthhXWdEZBJNRM
         pwjg==
X-Received: by 10.152.116.52 with SMTP id jt20mr10145336lab.52.1366470404748;
        Sat, 20 Apr 2013 08:06:44 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id sl5sm7539983lbb.10.2013.04.20.08.06.42
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 08:06:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366470363-22309-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221868>

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
