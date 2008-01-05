From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] builtin-reflog.c: typo ref --> argv[i], could cause segfault
Date: Fri, 04 Jan 2008 19:11:37 -0600
Message-ID: <477ED949.1030909@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 02:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAxa8-0007wr-Ny
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 02:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbYAEBLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 20:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYAEBLq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 20:11:46 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43684 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933AbYAEBLp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 20:11:45 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m051Bc71002706;
	Fri, 4 Jan 2008 19:11:38 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 19:11:38 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-OriginalArrivalTime: 05 Jan 2008 01:11:38.0052 (UTC) FILETIME=[EBF47040:01C84F37]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15638001
X-TM-AS-Result: : Yes--9.244900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNjQzLTE1MDY1Ny0xNTA2?=
	=?us-ascii?B?NzUtNzAwMTYwLTcwNDI1Ny0xODgwMTktNzA2MjkwLTcwNDc0Ny03?=
	=?us-ascii?B?MDIxMTgtNzAyMDM4LTcwNzc1MC0xNDgwMzktMTQ4MDUx?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69624>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-reflog.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index f422693..5e54989 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -394,7 +394,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 		int recno;
 
 		if (!spec) {
-			status |= error("Not a reflog: %s", ref);
+			status |= error("Not a reflog: %s", argv[i]);
 			continue;
 		}
 
-- 
1.5.4.rc2.1119.g6fdf-dirty
