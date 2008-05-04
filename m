From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v3 05/10] Use test_set_editor in t9001-send-email.sh
Date: Sun,  4 May 2008 01:37:55 -0400
Message-ID: <1209879480-16910-6-git-send-email-bdonlan@fushizen.net>
References: <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-1-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-2-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-3-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-4-git-send-email-bdonlan@fushizen.net>
 <1209879480-16910-5-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 07:40:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsWxB-0004ce-Er
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 07:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYEDFjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 01:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbYEDFjI
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 01:39:08 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:37817 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYEDFjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 01:39:07 -0400
Received: from cpe-74-69-246-7.maine.res.rr.com ([74.69.246.7] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JsWvG-0001Me-UP; Sun, 04 May 2008 05:38:07 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JsWvA-0004PF-V1; Sun, 04 May 2008 01:38:00 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1209879480-16910-5-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81142>

Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
---
 t/t9001-send-email.sh |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 030f66c..0a65785 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -144,10 +144,7 @@ test_expect_success 'setup fake editor' '
 	chmod +x fake-editor
 '
 
-FAKE_EDITOR="$(pwd)/fake-editor"
-export FAKE_EDITOR
-GIT_EDITOR='"$FAKE_EDITOR"'
-export GIT_EDITOR
+test_set_editor "$(pwd)/fake-editor"
 
 test_expect_success '--compose works' '
 	clean_fake_sendmail &&
-- 
1.5.5.1.128.g03a943
