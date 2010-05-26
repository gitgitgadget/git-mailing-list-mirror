From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 103/104] show-branch: use DEFAULT_ABBREV instead of 7
Date: Wed, 26 May 2010 18:01:13 +1200
Message-ID: <1274853674-18521-103-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9mM-0005GU-LF
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934101Ab0EZGHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:07:35 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49309 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933961Ab0EZGGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 6505333840;
	Wed, 26 May 2010 18:02:11 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ScBa2jr0AQpx; Wed, 26 May 2010 18:02:07 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 89EE9338F3;
	Wed, 26 May 2010 18:01:41 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147770>

From: Tay Ray Chuan <rctay89@gmail.com>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/show-branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e20fcf3..e8719aa 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -313,7 +313,8 @@ static void show_one_commit(struct commit *commit, int no_name)
 		}
 		else
 			printf("[%s] ",
-			       find_unique_abbrev(commit->object.sha1, 7));
+			       find_unique_abbrev(commit->object.sha1,
+						  DEFAULT_ABBREV));
 	}
 	puts(pretty_str);
 	strbuf_release(&pretty);
-- 
1.7.1.rc2.333.gb2668
