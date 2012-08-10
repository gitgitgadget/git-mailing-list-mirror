From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetool,difftool: Document --tool-help consistently
Date: Fri, 10 Aug 2012 00:39:22 -0700
Message-ID: <1344584363-5933-1-git-send-email-davvid@gmail.com>
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:39:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szjoj-00010U-PL
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754856Ab2HJHj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:39:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42760 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595Ab2HJHj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:39:26 -0400
Received: by pbbrr13 with SMTP id rr13so2291700pbb.19
        for <git@vger.kernel.org>; Fri, 10 Aug 2012 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=HGNhgNvbuTPgDpBJNijuOur4UnF6uh39str/65cs4bY=;
        b=nbRouXIePvFX+etWz19ox8LvNCaR/3atOAjKOogVxMyfNm4vmmRYUE7l9T46rcONDs
         QzgBgiEJ4lk5R4F02gJtR3SzFVvG1DPbr5/kyrrDukt7hofPIqO3ubL7UK/2sbQLAv3P
         E9+w8v4kHybamZr5ODXpF+bT7/b+VZEpHp7YMEukamvCABiQo+6bs0DAivasaYOCGv4m
         AmXkXIjDVXP1tyBBs9NgXyMxDZ/aNPVlsx38f3EZ1fBNE4BH/CpXUGoGAPF0iK2Et57V
         K+TU5BY3bdYp6ZoOgRhXW2sk3OFpioWq2iiQuTVZOLwiezE+Ja5PXcCV2Klbf+EZTceD
         yanA==
Received: by 10.68.236.4 with SMTP id uq4mr10256976pbc.158.1344584366261;
        Fri, 10 Aug 2012 00:39:26 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id tv6sm2834734pbc.24.2012.08.10.00.39.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Aug 2012 00:39:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc2.16.g034161a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203204>

Add an entry for --tool-help to the mergetool documentation.

Move --tool-help in the difftool documentation so that it is
listed immediately after --tool so that it is easier to find.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
If you want to have --tool-help mentioned, use this patch.

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
index d7207bd..6b563c5 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -64,6 +64,9 @@ variable `mergetool.<tool>.trustExitCode` can be set to `true`.
 Otherwise, 'git mergetool' will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
+--tool-help::
+	Print a list of merge tools that may be used with `--tool`.
+
 -y::
 --no-prompt::
 	Don't prompt before each invocation of the merge resolution
-- 
1.7.12.rc2.16.g034161a
