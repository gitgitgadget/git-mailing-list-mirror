From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] Documentation: Minor language improvements to merge-config
Date: Thu,  7 Apr 2011 00:16:51 +0530
Message-ID: <1302115611-1950-5-git-send-email-artagnon@gmail.com>
References: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
 <1302115611-1950-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 20:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7XmQ-0007ED-4c
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 20:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756550Ab1DFSsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 14:48:18 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756507Ab1DFSsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 14:48:16 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so1697854iyb.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JfL3MhZAVIbFc4EVy4BvaCpYuqB2SNsYcOYcIggHCJs=;
        b=fs5upvsgwk6/SuTvxvNEJZ4xsV4H83xB2P5lfvCgNSC+5iQZONVSqKISGYDu6PrtLD
         ULOYRJRT4FZ+V6Qkm37kZp9HbQB6e8HYwVD1jTnAes8XQLBf2UQ7eNdRkg57wj7H9+0G
         GGlp58ePLq5OuvzaYBG31wAre+zG5c+WWoslk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Tl1q/LFSGwAnukGJUE7xHEZ8GK+qKBWW297jtNvJ8WzD9dPjeXlM1iPhTtALDxsZzX
         CzAeu2XGQtF28yJvj7SIQWM0pJetTPLCVF7yJHgzi2Psbg06sIwzDLbKNtYF4B8vAzNK
         o8wTIj1BJpddwHyfZwNxBr1wkWHz716NRqXF8=
Received: by 10.42.179.3 with SMTP id bo3mr1402776icb.316.1302115695849;
        Wed, 06 Apr 2011 11:48:15 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id vr5sm495851icb.0.2011.04.06.11.48.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 11:48:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302115611-1950-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171004>

Improve readability by dropping superflous verbs like "specifies",
"controls", and "defines".  Describe the `merge.tool` option just
before the `mergetool.*` options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/merge-config.txt |   39 ++++++++++++++++++++-------------------
 1 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 8920258..6cd5127 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,5 +1,5 @@
 merge.conflictstyle::
-	Specify the style in which conflicted hunks are written out to
+	The style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
 	shows a `<<<<<<<` conflict marker, changes made by one side,
 	a `=======` marker, changes made by the other side, and then
@@ -38,19 +38,12 @@ merge.renormalize::
 	attributes" in linkgit:gitattributes[5].
 
 merge.stat::
-	Whether to print the diffstat between ORIG_HEAD and the merge result
-	at the end of the merge.  True by default.
-
-merge.tool::
-	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
-	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
-	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
-	and "xxdiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
+	Set this option to false to omit printing the diffstat between
+	ORIG_HEAD and the merge result at the end of the merge.
+	Defaults to true.
 
 merge.verbosity::
-	Controls the amount of output shown by the recursive merge
+	The amount of output shown by the recursive merge
 	strategy.  Level 0 outputs nothing except a final error
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
@@ -58,14 +51,22 @@ merge.verbosity::
 	Can be overridden by the 'GIT_MERGE_VERBOSITY' environment variable.
 
 merge.<driver>.name::
-	Defines a human-readable name for a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
+	The name of the custom merge driver.  See
+	linkgit:gitattributes[5] for details.
 
 merge.<driver>.driver::
-	Defines the command that implements a custom low-level
-	merge driver.  See linkgit:gitattributes[5] for details.
+	The command that implements the custom merge driver.  See
+	linkgit:gitattributes[5] for details.
 
 merge.<driver>.recursive::
-	Names a low-level merge driver to be used when
-	performing an internal merge between common ancestors.
-	See linkgit:gitattributes[5] for details.
+	The merge driver to be used when performing an internal merge
+	between common ancestors.  See linkgit:gitattributes[5] for
+	details.
+
+merge.tool::
+	The merge tool to be used by linkgit:git-mergetool[1].  Valid
+	built-in values are: "araxis", "bc3", "diffuse", "ecmerge",
+	"emerge", "gvimdiff", "kdiff3", "meld", "opendiff", "p4merge",
+	"tkdiff", "tortoisemerge", "vimdiff" and "xxdiff".  Any other
+	value is treated as a custom merge tool, and there must be a
+	corresponding `mergetool.<tool>.cmd` option.
-- 
1.7.4.rc1.7.g2cf08.dirty
