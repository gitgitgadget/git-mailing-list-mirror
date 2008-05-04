From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 06/10] test-lib.sh: Fix some missing path quoting
Date: Sun,  4 May 2008 01:37:56 -0400
Message-ID: <1209879480-16910-7-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-4-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-5-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-6-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:39:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWw8-0004Pv-PW
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbYEDFiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbYEDFiL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:38:11 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37786 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbYEDFiK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:38:10 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Ml-Ud; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvB-0004PH-4u; Sun, 04 May 2008 01:38:01 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-6-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81135>

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index d7ad13b..04e098b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -345,7 +345,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
+	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >/dev/null 2>&1 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.5.5.1.128.g03a943
