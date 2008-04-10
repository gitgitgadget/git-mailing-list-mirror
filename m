From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 06/10] test-lib.sh: Fix some missing path quoting
Date: Thu, 10 Apr 2008 02:50:12 -0400
Message-ID: <1207810216-27871-7-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-6-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:52:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqdz-0003BM-Bs
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753314AbYDJGve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYDJGve
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:51:34 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34045 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbYDJGvd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:51:33 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wC-OL; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbx-0007G1-36; Thu, 10 Apr 2008 02:50:17 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-6-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79177>

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
1.5.5.33.gc0a39.dirty
