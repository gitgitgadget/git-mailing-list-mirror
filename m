From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] Documentation: Minor language improvements to merge-config
Date: Wed,  6 Apr 2011 15:27:34 +0530
Message-ID: <1302083854-2448-5-git-send-email-artagnon@gmail.com>
References: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
 <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 12:00:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7PX5-0006WV-0w
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 12:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755522Ab1DFKAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 06:00:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61516 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab1DFKAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 06:00:06 -0400
Received: by iwn34 with SMTP id 34so1277719iwn.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=SGp+ql8bu1E9UBsZMZLlSfB7IUKgBU+pZbUioTXr6ko=;
        b=GAW2bI7PLO+IUmr8ihovo3AlQjLTUYrzhR7916lX8BMU8hhMjtjZ342ZTq6N3BC07w
         WVonMlm2wSvQ1q9+7BzjP2P/CCMiHytyq/b/GGVkAa9EaNAO2OWeuyaYgej6iPSUgLE0
         I8+tbYrS3dpY4GEvIMmuFefJT0yJL7GsQ8rYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j+sGG1QVNdru2O3BxVbu8l0FzaaLtm2fL6gUCKfUpLwbTmcKtXRS60BFyDfLlz3i19
         eVh01t8XviIxoPqIWOdZnrAnl+3jLkDAGqxpTl2TZ9cxEuS4TRElMaDfrFXWwKpbov2f
         SbSrqIi4HjI0pu2D4J+X9iy/c/QMnRjAe4iwQ=
Received: by 10.42.213.202 with SMTP id gx10mr1098656icb.498.1302083940535;
        Wed, 06 Apr 2011 02:59:00 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id c1sm318477ibe.51.2011.04.06.02.58.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2011 02:58:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302083854-2448-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170962>

Improve readability by dropping superflous verbs like "specifies",
"controls", and "defines".  Describe the `merge.tool` option just
before the `mergetool.*` options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/merge-config.txt |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 33bf74c..d3dd640 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,5 +1,5 @@
 merge.conflictstyle::
-	Specify the style in which conflicted hunks are written out to
+	The style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
 	shows a `<<<<<<<` conflict marker, changes made by one side,
 	a `=======` marker, changes made by the other side, and then
@@ -28,19 +28,11 @@ merge.renormalize::
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
 
 merge.verbosity::
-	Controls the amount of output shown by the recursive merge
+	The amount of output shown by the recursive merge
 	strategy.  Level 0 outputs nothing except a final error
 	message if conflicts were detected. Level 1 outputs only
 	conflicts, 2 outputs conflicts and file changes.  Level 5 and
@@ -48,15 +40,22 @@ merge.verbosity::
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
+	corresponding mergetool.<tool>.cmd option.
-- 
1.7.4.rc1.7.g2cf08.dirty
