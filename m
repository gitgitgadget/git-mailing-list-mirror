From: Alexei Sholik <alcosholik@gmail.com>
Subject: [PATCH] docs: fix grammar in gitattributes.txt
Date: Fri, 18 Mar 2011 15:14:27 +0200
Message-ID: <1300454067-9934-1-git-send-email-alcosholik@gmail.com>
Cc: Alexei Sholik <alcosholik@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 14:12:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ZTE-00038v-UL
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 14:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756402Ab1CRNL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 09:11:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45966 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758Ab1CRNLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 09:11:55 -0400
Received: by bwz15 with SMTP id 15so3321216bwz.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Vo4X3twY+WbbNhV8DjM5CBW2VKdLOx0hS1oDxcnO/Q8=;
        b=s4gmNyaAyCem0wXUReKz+rC1JnMYbDCK9Vs43q0B3kxKptwkDWK5lBrYeNj9mEPAuQ
         /bNT0IaWue6LzRTPR0ST+UYRJhDXUANxzYK71SP5WwpV9Ok1FsS5NVqUGh/IgFB84zOM
         7N+RVErtwB3YKG0T/xyUMe5aLAtx0E3qz0Fqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CZ6tykhctjr5+FQEE9ykcteJKGQZ61ebVvIgmcyiu7Sc8B4Qdzin3fJrmEb5k3k9r/
         lI7FsM23gOa9buE5XFUzK6Zlth5zvSUdiG2sYP2Hc4s1OsG0osUoTDOhFTXWt7T2nG2W
         SClO4NsqbKcRXOPrf0YPgndivbyrOoo7eb8P8=
Received: by 10.204.19.6 with SMTP id y6mr902006bka.159.1300453914062;
        Fri, 18 Mar 2011 06:11:54 -0700 (PDT)
Received: from localhost.localdomain ([193.254.233.10])
        by mx.google.com with ESMTPS id t1sm2132364bkx.19.2011.03.18.06.11.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 06:11:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169316>

Signed-off-by: Alexei Sholik <alcosholik@gmail.com>
---
 Documentation/gitattributes.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 7e7e121..c151657 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -632,7 +632,7 @@ Performing a three-way merge
 `merge`
 ^^^^^^^
 
-The attribute `merge` affects how three versions of a file is
+The attribute `merge` affects how three versions of a file are
 merged when a file-level merge is necessary during `git merge`,
 and other commands such as `git revert` and `git cherry-pick`.
 
@@ -646,15 +646,15 @@ Unset::
 
 	Take the version from the current branch as the
 	tentative merge result, and declare that the merge has
-	conflicts.  This is suitable for binary files that does
+	conflicts.  This is suitable for binary files that do
 	not have a well-defined merge semantics.
 
 Unspecified::
 
 	By default, this uses the same built-in 3-way merge
-	driver as is the case the `merge` attribute is set.
+	driver as is the case when the `merge` attribute is set.
 	However, `merge.default` configuration variable can name
-	different merge driver to be used for paths to which the
+	different merge driver to be used with paths for which the
 	`merge` attribute is unspecified.
 
 String::
-- 
1.7.2.3
