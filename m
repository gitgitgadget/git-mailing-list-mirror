From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH v2 1/2] Add top-level maintainers file with email/canonical repository information
Date: Mon, 31 Dec 2012 17:19:34 -0500
Message-ID: <1356992375-11116-2-git-send-email-jason.k.holden.swdev@gmail.com>
References: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: gitster@pobox.com, th.acker@arcor.de, paulus@samba.org,
	patthoyts@users.sourceforge.net, worldhello.net@gmail.com,
	Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 23:21:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpnjf-0005Cz-IN
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 23:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931Ab2LaWVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 17:21:11 -0500
Received: from mail-vc0-f177.google.com ([209.85.220.177]:57726 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2LaWVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 17:21:09 -0500
Received: by mail-vc0-f177.google.com with SMTP id m8so13057280vcd.22
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 14:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=sUfG0DybdQk46MsMrWMiFxRDZDVpiLQCSA0RMybbuJs=;
        b=OfoLGIZBMh+sb/VUhgrYUqDKCd+jmA+Z52MSVCR5HfyXVZyZLbwIHRauaH16hKJjVu
         2MnzVunOeKyTLnLtgGcKQlWcajmSEXXwjdozIGf0wFVgvOm/G4DfYA1R+gRLIlD1pwD7
         2QXjQK7guTjrGMOE7N1FbjGX65zHQJk1fulJ6CiWKUQUYepeQns00j4wDKJABHFl3Pd8
         Dk0Xxuk6QiNMYuTrD2dTDf+xAH81smMgxjJXHA8+yYCdQ334OkZ/ybk2akO27urF03oo
         rhy+rCzM/mkLg2UXT9Ia9XKHbq24nVP3N43utWCnbZffzu00zJoI3Pz4vM+DRJ3GvLPa
         jlzg==
X-Received: by 10.221.10.6 with SMTP id oy6mr63421395vcb.65.1356992468296;
        Mon, 31 Dec 2012 14:21:08 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id di16sm39824172vdb.11.2012.12.31.14.21.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 14:21:07 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
In-Reply-To: <1356992375-11116-1-git-send-email-jason.k.holden.swdev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212362>

Certain parts of git have a semi-formalized workflow for
incoming patches.  This file documents the maintainers, their area of
specialization, their email address, and their canonical repository against
which patches should be submitted.

Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
---
 MAINTAINERS | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
new file mode 100644
index 0000000..c3a96b4
--- /dev/null
+++ b/MAINTAINERS
@@ -0,0 +1,21 @@
+Core Git/Overall Maintainer:
+ Junio C Hamano <gitster@pobox.com>
+ git://git.kernel.org/pub/scm/git/git.git
+
+
+Certain utilities packaged with git (git-gui, gitk, and git-po) are maintained
+upstream of the core git repository.  Their contact information
+and canonical repositories are below.  Patches to improve these utilities
+should be made against the tree's referenced below
+
+gitk:
+ Paul Mackerras <paulus@samba.org>
+ git://ozlabs.org/~paulus/gitk
+
+git-gui:
+ Pat Thoyts <patthoyts@users.sourceforge.net>
+ git://repo.or.cz/git-gui
+
+git-po:
+ Jiang Xin <worldhello.net@gmail.com>
+ https://github.com/git-l10n/git-po/
-- 
1.8.1.rc3.28.g0ab5d1f
