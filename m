From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 4/8] test-lib.sh: Fix some missing path quoting
Date: Tue,  8 Apr 2008 21:30:00 -0400
Message-ID: <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:31:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPAD-0007qD-3A
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYDIBax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYDIBax
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:30:53 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49021 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYDIBaw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:30:52 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dM-FZ; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007vB-Gq; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79061>

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7c2a8ba..17d4bc0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -329,7 +329,7 @@ test_create_repo () {
 	repo="$1"
 	mkdir "$repo"
 	cd "$repo" || error "Cannot setup test environment"
-	"$GIT_EXEC_PATH/git" init --template=$GIT_EXEC_PATH/templates/blt/ >/dev/null 2>&1 ||
+	"$GIT_EXEC_PATH/git" init "--template=$GIT_EXEC_PATH/templates/blt/" >/dev/null 2>&1 ||
 	error "cannot run git init -- have you built things yet?"
 	mv .git/hooks .git/hooks-disabled
 	cd "$owd"
-- 
1.5.5.8.gbbd98
