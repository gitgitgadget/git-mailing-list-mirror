From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Documentation: Document diff.<tool>.* and filter.<driver>.* in config
Date: Fri,  1 Apr 2011 14:17:38 +0530
Message-ID: <1301647658-28047-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 10:49:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5a2T-0000Zs-7s
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 10:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab1DAItA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 04:49:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41590 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab1DAIs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 04:48:59 -0400
Received: by iyb14 with SMTP id 14so3257243iyb.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 01:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:message-id:x-mailer;
        bh=SoIvwdA0Wiea+qKTTpqkdY65eWB6XRSBI2HQJNxyNSE=;
        b=Oy2AApeUmdkcBBqWHUc1KqSCE0qi0OHWLJg4bt4B6XuB5WZoM9BVPTSc5CamGR+RPl
         Mpm+GaMv6aQnBKWfjL0bEcrXmzYJoWwTJL60CnYvvPT3MyNn97ZBOjTb81bf0ocR+3K3
         yTn240XQjnsQhEGNR3O+FnFgZHki5AN6FM0IA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=dRG7xacpHHZLUYsF7PkNaxVSEtAC9eL5oeKwP4ZiRiiWdlbJV7gQZAkeWtep0oLo6G
         mvRMWEanCmE1RQcwXOcStGz+dkMEtyeUsKo5siyxJwbslkJuz+kHjdy6B/2UKM6AlciE
         nutKw26cfp+HfMpxUbVvgw0eb7d5o7/gswqFk=
Received: by 10.43.63.212 with SMTP id xf20mr922704icb.265.1301647738364;
        Fri, 01 Apr 2011 01:48:58 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id wo15sm1175631icb.16.2011.04.01.01.48.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 01:48:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170563>

Although the gitattributes page contains comprehensive information
about these configuration options, they should be included in the
config documentation for completeness.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ea55d4..db1801e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -875,6 +875,24 @@ diff.tool::
 	the same valid values as `merge.tool` minus "tortoisemerge"
 	and plus "kompare".
 
+diff.<tool>.command::
+	Defines a human-readable name for a custom low-level diff
+	tool.  See linkgit:gitattributes[5] for details.
+
+diff.<tool>.xfuncname::
+	Defines the command that implements a custom low-level merge
+	tool.  See linkgit:gitattributes[5] for details.
+
+diff.<tool>.textconv::
+	Names a low-level merge tool to be used when performing an
+	internal merge between common ancestors.  See
+	linkgit:gitattributes[5] for details.
+
+diff.<tool>.cachetextconv::
+	Names a low-level merge tool to be used when performing an
+	internal merge between common ancestors.  See
+	linkgit:gitattributes[5] for details.
+
 difftool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
@@ -973,6 +991,16 @@ format.signoff::
     the rights to submit this work under the same open source license.
     Please see the 'SubmittingPatches' document for further discussion.
 
+filter.<driver>.clean::
+	Defines the command to be used to convert the contents of
+	worktree file upon checkin.  See linkgit:gitattributes[5] for
+	details.
+
+filter.<driver>.smudge::
+	Defines the command to be used to convert the blob object to
+	worktree file upon checkout.  See linkgit:gitattributes[5] for
+	details.
+
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-- 
1.7.4.rc1.7.g2cf08.dirty
