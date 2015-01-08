From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] show-branch: line-wrap for show-branch usage
Date: Fri,  9 Jan 2015 02:30:27 +0600
Message-ID: <1420749027-25951-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, 0xAX <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:31:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9JjD-0001Bs-31
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbAHUam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 15:30:42 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:49225 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbAHUam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 15:30:42 -0500
Received: by mail-la0-f42.google.com with SMTP id gd6so11330250lab.1
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Mu/Hl5kKz0d3gNu9QXMVB96vtqQCHGGamzs2jHizh/c=;
        b=EJLwXGyhBQB5gHqtxEJESuLhHuaIyAy8kvKphR1F5c+ubdheERPNuuOG1AxThTrCpL
         4A8r2MBvocfTjO/1CGA2yRFmtPq1z5JdO6s2/Et+cV57p2RK3kernA2SxEha+KNNyNd2
         YuJ5AjhuzAcMzNGjdYxp136fXBTsquGg6U2S2DXVrPYCislm/OtwopUIiipI+Rj6w5+7
         xWB7nve3kB9SGCzVFLkn/uiUkRoymB8xdj79/cJADIK8D/eGToBm8MAvXHQObds8bACN
         +Vxg2DaDQ+AHCu0Wfh41BQIw2+/H04l++sSQRnj+d6bnsWWNeqEcEchVZdEGTCanNbKo
         rFyw==
X-Received: by 10.152.1.2 with SMTP id 2mr17357046lai.89.1420749040459;
        Thu, 08 Jan 2015 12:30:40 -0800 (PST)
Received: from localhost.localdomain ([95.59.128.28])
        by mx.google.com with ESMTPSA id jq14sm1362079lab.14.2015.01.08.12.30.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Jan 2015 12:30:39 -0800 (PST)
X-Mailer: git-send-email 2.2.1.269.gb441311.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262222>

Signed-off-by: 0xAX <kuleshovmail@gmail.com>
---
 builtin/show-branch.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 270e39c..18245ad 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,9 +6,11 @@
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
-    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
-    N_("git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]"),
-    NULL
+	N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order]\n"
+"                       [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base]\n"
+"                       [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+	N_("git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]"),
+	NULL
 };
 
 static int showbranch_use_color = -1;
-- 
2.2.1.269.gb441311.dirty
