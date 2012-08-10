From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool,difftool: Document --tool-help consistently
Date: Thu,  9 Aug 2012 21:52:45 -0700
Message-ID: <1344574365-5534-1-git-send-email-davvid@gmail.com>
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 06:52:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzhDU-00088I-43
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 06:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921Ab2HJEwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 00:52:50 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34429 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544Ab2HJEwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 00:52:49 -0400
Received: by pbbrr13 with SMTP id rr13so2082343pbb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 21:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mNDcFerqfUvqbbOlUSl6BKZkdfYUsgI27BJ6DP8uNh4=;
        b=WjhEwGvzDaSHR08+kn1RxBLsouWh08OzLzKBURO4dWUoYiOUxQ213DYR8tCt4abA7S
         9JIXIY6JfRt0XXdPrtPKol6jYRB9KZ4wAz4URFtqoyjeXhKRWJVJP9Q/HtZTC044pkR0
         VcQuXyRE4Tbcdk8QLxRtr7wJ5dAGExIOospvfVhLU4fFe1h7eygFCDOFH6WuitkVL3k/
         j9pqdrQ85v2RLNup5S8lroFYWvWxqbHFB77QJlOFlftUYp2bEhpbzbIjZgdUOJSRgEKJ
         LrI6yHFLvwsHvReP/qho3ny8Tjs1Gf4v6MoUBulQgK/0juP2LQO9Ik7SyjTLFETa94x4
         XQCA==
Received: by 10.68.219.166 with SMTP id pp6mr9460164pbc.35.1344574369470;
        Thu, 09 Aug 2012 21:52:49 -0700 (PDT)
Received: from lustrous.local.fas.fa.disney.com (cpe-76-94-86-69.socal.res.rr.com. [76.94.86.69])
        by mx.google.com with ESMTPS id nv6sm2543357pbc.42.2012.08.09.21.52.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 21:52:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc2.16.g034161a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203201>

Add an entry for --tool-help to the mergetool documentation.

Move --tool-help in the difftool documentation so that it is
listed immediately after --tool so that it is easier to find.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Based on work in next.

This is not urgent as the current difftool topics are cooking
and will not be in the current release cycle.

 Documentation/git-difftool.txt  | 6 +++---
 Documentation/git-mergetool.txt | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 313d54e..73ca702 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -66,6 +66,9 @@ of the diff post-image.  `$MERGED` is the name of the file which is
 being compared. `$BASE` is provided for compatibility
 with custom merge tool commands and has the same value as `$MERGED`.
 
+--tool-help::
+	Print a list of diff tools that may be used with `--tool`.
+
 --symlinks::
 --no-symlinks::
 	'git difftool''s default behavior is create symlinks to the
@@ -74,9 +77,6 @@ with custom merge tool commands and has the same value as `$MERGED`.
 	Specifying `--no-symlinks` instructs 'git difftool' to create
 	copies instead.  `--no-symlinks` is the default on Windows.
 
---tool-help::
-	Print a list of diff tools that may be used with `--tool`.
-
 -x <command>::
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index d7207bd..7100237 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -64,6 +64,9 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
+--tool-help::
+	Print a list of diff tools that may be used with `--tool`.
+
 -y::
 --no-prompt::
 	Don't prompt before each invocation of the merge resolution
-- 
1.7.12.rc2.16.g034161a
