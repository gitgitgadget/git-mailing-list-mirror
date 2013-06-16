From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v4 3/6] t7403: add missing && chaining
Date: Sun, 16 Jun 2013 15:18:15 +0100
Message-ID: <1f972ee320a1d59c516a962adb853561233c17f7.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>, John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 16 16:19:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoDnZ-0001ST-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 16:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab3FPOTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 10:19:14 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:37984 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3FPOTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 10:19:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 8BF456064EC;
	Sun, 16 Jun 2013 15:19:12 +0100 (BST)
X-Quarantine-ID: <yrp-vwy1PUz8>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yrp-vwy1PUz8; Sun, 16 Jun 2013 15:19:12 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id EBA9F6064D5;
	Sun, 16 Jun 2013 15:19:11 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id DB20D161E2F4;
	Sun, 16 Jun 2013 15:19:11 +0100 (BST)
X-Quarantine-ID: <xnQdZSvlORLQ>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnQdZSvlORLQ; Sun, 16 Jun 2013 15:19:11 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C4713161E3F1;
	Sun, 16 Jun 2013 15:19:00 +0100 (BST)
X-Mailer: git-send-email 1.8.3.779.g691e267
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
In-Reply-To: <cover.1371391740.git.john@keeping.me.uk>
References: <cover.1371391740.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228011>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7403-submodule-sync.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 38f6cc4..bf90098 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -174,7 +174,7 @@ test_expect_success '"git submodule sync" handles origin URL of the form foo/bar
 			cd submodule &&
 			#actual foo/submodule
 			test "$(git config remote.origin.url)" = "../foo/submodule"
-		)
+		) &&
 		(
 			cd submodule/sub-submodule &&
 			test "$(git config remote.origin.url)" != "../../foo/submodule"
@@ -191,7 +191,7 @@ test_expect_success '"git submodule sync --recursive" propagates changes in orig
 			cd submodule &&
 			#actual foo/submodule
 			test "$(git config remote.origin.url)" = "../foo/submodule"
-		)
+		) &&
 		(
 			cd submodule/sub-submodule &&
 			test "$(git config remote.origin.url)" = "../../foo/submodule"
-- 
1.8.3.779.g691e267
