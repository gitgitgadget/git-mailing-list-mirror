From: Max Kirillov <max@max630.net>
Subject: [PATCH] blame: fix option name in error message
Date: Mon, 26 Oct 2015 07:29:00 +0200
Message-ID: <1445837340-4333-1-git-send-email-max@max630.net>
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 06:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqaLK-0002iH-GX
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 06:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbbJZF3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 01:29:09 -0400
Received: from p3plsmtpa09-04.prod.phx3.secureserver.net ([173.201.193.233]:33121
	"EHLO p3plsmtpa09-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbbJZF3I (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 01:29:08 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-04.prod.phx3.secureserver.net with 
	id ZhV21r00W5B68XE01hV7SR; Sun, 25 Oct 2015 22:29:08 -0700
X-Mailer: git-send-email 2.3.4.2801.g3d0809b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280177>

The option name used in blame's UI is `--reverse`.

Signed-off-by: Max Kirillov <max@max630.net>
---
 builtin/blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 98b1810..f89bc9e 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2697,7 +2697,7 @@ parse_done:
 		sb.commits.compare = compare_commits_by_commit_date;
 	}
 	else if (contents_from)
-		die("--contents and --children do not blend well.");
+		die("--contents and --reverse do not blend well.");
 	else {
 		final_commit_name = prepare_initial(&sb);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
-- 
2.3.4.2801.g3d0809b
