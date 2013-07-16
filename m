From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/2] show-branch: fix description of --date-order
Date: Tue, 16 Jul 2013 11:22:00 +0200
Message-ID: <8768923c2d317d02beabbf1bff2f61927e126f81.1373966389.git.trast@inf.ethz.ch>
References: <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:22:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1SU-0003r5-Id
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab3GPJWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:22:06 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:5548 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753693Ab3GPJWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:22:03 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:21:58 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:21:59 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
In-Reply-To: <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230552>

The existing description reads as if it somehow applies a filter.
Change it to explain that it is merely about the ordering.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 builtin/show-branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 99ec4af..d5fdebc 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -673,7 +673,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		OPT_SET_INT(0, "sparse", &dense,
 			    N_("show merges reachable from only one tip"), 0),
 		OPT_SET_INT(0, "date-order", &sort_order,
-			    N_("show commits where no parent comes before its "
+			    N_("sort commits such that no parent comes before its "
 			       "children"),
 			    REV_SORT_BY_COMMIT_DATE),
 		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
-- 
1.8.3.2.998.g1d087bc
