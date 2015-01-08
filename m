From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] show-branch: Indentation for show-branch usage
Date: Fri,  9 Jan 2015 00:08:36 +0600
Message-ID: <1420740516-20836-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 19:15:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9Hap-0000pj-60
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 19:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810AbbAHSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 13:13:54 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33450 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbbAHSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 13:13:53 -0500
Received: by mail-lb0-f175.google.com with SMTP id z11so4301307lbi.6
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 10:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=YPcyxlxMtXFI4QMfmtQlCuRcjvbavAscH1p3/SusRNg=;
        b=DFat2Qdk97pLSma+0JYhdPK144xLmGSD0Kwlcc7DXicdff4AeXn2b0uFT8jqy4tywF
         Qsvl/TE9AG2D0PdIkq8GULvo1pMMZV8ItBzCuMYdhchihll30FY+ctCGKHPKbFUTi8Kn
         nHFEKmRhNT84pj+lZQWzsLY3wiVwLd8QcCP1uorC//RjNFptILXEVrGgo7hZgmtqRFRJ
         zg2Xtn6eIKShw7Gp2YewHjNxJnDlJRtkfEPOU5vKEPC52lnV2dhJN8oH8O85wQLEh+em
         +q2/k2a6N0Yz1yCSDFDTMTKMmZmY55RBQAeso4WpK/FtXXa561zfe9iU8uLJXDQOcEbB
         CXkw==
X-Received: by 10.112.203.196 with SMTP id ks4mr15782225lbc.39.1420740522040;
        Thu, 08 Jan 2015 10:08:42 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.28])
        by mx.google.com with ESMTPSA id j19sm1296971lbl.23.2015.01.08.10.08.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 10:08:41 -0800 (PST)
X-Mailer: git-send-email 2.2.1.268.g1e6f5b2.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262204>

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 builtin/show-branch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 270e39c..2e60107 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,7 +6,10 @@
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
-    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order]\n\
+                       [--current] [--color[=<when>] | --no-color] [--sparse]\n\
+                       [--more=<n> | --list | --independent | --merge-base]\n\
+                       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
     N_("git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
 };
-- 
2.2.1.268.g1e6f5b2.dirty
