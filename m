From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-blame: fix lapsus
Date: Wed,  9 Jul 2008 22:47:38 +0200
Message-ID: <1215636458-17687-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 22:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGgak-0003fU-Iw
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 22:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYGIUrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 16:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbYGIUrq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 16:47:46 -0400
Received: from pan.madism.org ([88.191.52.104]:59120 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbYGIUrq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 16:47:46 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id AFCCC34710;
	Wed,  9 Jul 2008 22:47:39 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 55EA485E5; Wed,  9 Jul 2008 22:47:38 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.397.gf2a8c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87911>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-blame.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 99f5140..73d26c6 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -25,7 +25,7 @@ static char blame_usage[] = "git-blame [options] [rev-opts] [rev] [--] file";
 static const char *blame_opt_usage[] = {
 	blame_usage,
 	"",
-	"[rev-opts] are documented in git-rev-parse(1)",
+	"[rev-opts] are documented in git-rev-list(1)",
 	NULL
 };
 
-- 
1.5.6.2.397.gf2a8c
