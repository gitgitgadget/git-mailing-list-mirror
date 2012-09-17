From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] Add missing -z to git check-attr usage text for consistency with man page
Date: Mon, 17 Sep 2012 12:38:51 +0100
Message-ID: <1347881931-9129-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 13:39:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDZfJ-0001yI-BS
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 13:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab2IQLiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 07:38:54 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:42407 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab2IQLiy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 07:38:54 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id C99312E5D5
	for <git@vger.kernel.org>; Mon, 17 Sep 2012 12:38:52 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205674>

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/check-attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index e1ff575..075d01d 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -9,7 +9,7 @@ static int cached_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
 N_("git check-attr [-a | --all | attr...] [--] pathname..."),
-N_("git check-attr --stdin [-a | --all | attr...] < <list-of-paths>"),
+N_("git check-attr --stdin [-z] [-a | --all | attr...] < <list-of-paths>"),
 NULL
 };
 
-- 
1.7.12.147.g6d168f4
