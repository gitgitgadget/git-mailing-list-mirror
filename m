From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH v2 2/2] show-branch: fix description of --date-order
Date: Thu, 18 Jul 2013 14:26:56 +0200
Message-ID: <20119b8c1bd92aa914d6d07d49f56f6df89d4baa.1374150389.git.trast@inf.ethz.ch>
References: <a3c2312256eb222459ae92ad073a95834e51da1a.1374150389.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <jk@jk.gs>, <stimming@tuhh.de>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 14:27:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UznIb-0000lR-26
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 14:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758241Ab3GRM1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 08:27:02 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:16250 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757900Ab3GRM1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 08:27:00 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 18 Jul
 2013 14:26:49 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 18 Jul
 2013 14:26:57 +0200
X-Mailer: git-send-email 1.8.3.3.1053.g4beaad1
In-Reply-To: <a3c2312256eb222459ae92ad073a95834e51da1a.1374150389.git.trast@inf.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230688>

The existing description reads as if it somehow applies a filter.
Change it to explain that it is merely about the ordering.

Message-proposed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 builtin/show-branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 99ec4af..9788eb1 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -673,8 +673,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		OPT_SET_INT(0, "sparse", &dense,
 			    N_("show merges reachable from only one tip"), 0),
 		OPT_SET_INT(0, "date-order", &sort_order,
-			    N_("show commits where no parent comes before its "
-			       "children"),
+			    N_("topologically sort, maintaining date order "
+			       "where possible"),
 			    REV_SORT_BY_COMMIT_DATE),
 		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
-- 
1.8.3.3.1053.g4beaad1
