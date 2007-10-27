From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] Remove outdated references to cogito in documentation
Date: Sat, 27 Oct 2007 11:53:29 -0500
Message-ID: <1193504009-30689-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 18:54:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlovN-0005ai-56
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 18:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829AbXJ0Qxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753286AbXJ0Qxf
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 12:53:35 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:46022 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbXJ0Qxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 12:53:34 -0400
Received: by py-out-1112.google.com with SMTP id u77so1997042pyb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=TTbm8WG4CTUoWPD2mgBdMVil7oi2VLhb6jv0u4N/fbo=;
        b=V3k5JVtFfT/E0OPVImyeyV8+9ZgHXbb1ZqVXELJPjaCfW2EeiuvsAiTRnmw79Tar7KWBxbK6qIn/Z+4yGXCekm7/iNfu4OKdlHhxeEz38CmS9Dz5hd4Sc1PJbKwkywOB6Hh6HpG59qRgreDDj7Az9UzMb6+GQj3vxaoK/i/Uw/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=RcwbWAs+DqrcOAwteCqqRiR20pMW1fPY/UEWc9KWfUYGoTEqV2IZWZbxQFfrcpSZ7SOvl6CraKudCZPZMhL0USfz4qUFe7t3kniuB5m/gsGl1jsnPWQt7GACDvcUCBAuPe3N6rpoW2K68YyS2NE/cEheRKOmHGtiWuhVSs2PXjU=
Received: by 10.35.102.1 with SMTP id e1mr4983758pym.1193504013345;
        Sat, 27 Oct 2007 09:53:33 -0700 (PDT)
Received: from localhost ( [76.197.214.134])
        by mx.google.com with ESMTPS id f6sm9657479pyh.2007.10.27.09.53.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 09:53:31 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62505>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 Documentation/core-tutorial.txt |   10 ----------
 Documentation/git-tools.txt     |    3 ++-
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 6b2590d..58ac8c1 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -551,16 +551,6 @@ a bit more interesting.
 With that, you should now be having some inkling of what git does, and
 can explore on your own.
 
-[NOTE]
-Most likely, you are not directly using the core
-git Plumbing commands, but using Porcelain like Cogito on top
-of it. Cogito works a bit differently and you usually do not
-have to run `git-update-index` yourself for changed files (you
-do tell underlying git about additions and removals via
-`cg-add` and `cg-rm` commands). Just before you make a commit
-with `cg-commit`, Cogito figures out which files you modified,
-and runs `git-update-index` on them for you.
-
 
 Tagging a version
 -----------------
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 10653ff..480c557 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -20,7 +20,8 @@ Alternative/Augmentative Porcelains
    Cogito is a version control system layered on top of the git tree history
    storage system. It aims at seamless user interface and ease of use,
    providing generally smoother user experience than the "raw" Core GIT
-   itself and indeed many other version control systems.
+   itself and indeed many other version control systems. Cogito is no longer
+   maintained as most of its functionality is now in core GIT.
 
 
    - *pg* (http://www.spearce.org/category/projects/scm/pg/)
-- 
1.5.3.4
