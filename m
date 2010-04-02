From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/4] builtin/commit: fix duplicated sentence in a comment
Date: Fri,  2 Apr 2010 14:27:18 +0200
Message-ID: <1270211241-10795-2-git-send-email-markus.heidelberg@web.de>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 14:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxfwz-0003SR-KY
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 14:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab0DBMZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 08:25:53 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51500 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab0DBMZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 08:25:44 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 28F1615B2B6B5;
	Fri,  2 Apr 2010 14:25:43 +0200 (CEST)
Received: from [91.19.8.199] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NxfwV-0001ud-00; Fri, 02 Apr 2010 14:25:43 +0200
X-Mailer: git-send-email 1.7.0.4.300.gc535b
In-Reply-To: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX181v879HScpDPjKA7TC20LnJQnHhXcLNvK2TkEP
	Bd/7kYD89n+1miTEGp7qxd2+B0MnoHGXpPO79KFoN8F5tZyg90
	BiGQVRQaruXsAjAmpX6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143810>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 builtin/commit.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8dd104e..8cc9293 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -322,8 +322,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 *
 	 * (1) return the name of the real index file.
 	 *
-	 * The caller should run hooks on the real index, and run
-	 * hooks on the real index, and create commit from the_index.
+	 * The caller should run hooks on the real index,
+	 * and create commit from the_index.
 	 * We still need to refresh the index here.
 	 */
 	if (!pathspec || !*pathspec) {
-- 
1.7.0.4.300.gc535b
