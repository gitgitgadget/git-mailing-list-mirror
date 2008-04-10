From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH v2 05/10] Use test_set_editor in t9001-send-email.sh
Date: Thu, 10 Apr 2008 02:50:11 -0400
Message-ID: <1207810216-27871-6-git-send-email-bdonlan@fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net>
 <1207810216-27871-1-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-2-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-3-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-4-git-send-email-bdonlan@fushizen.net>
 <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 08:52:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjqeS-0003IA-G3
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbYDJGv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755438AbYDJGv6
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:51:58 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:34053 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbYDJGv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:51:57 -0400
Received: from [130.111.236.232] (helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1Jjqbz-0003wA-OJ; Thu, 10 Apr 2008 06:50:19 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1Jjqbx-0007Fz-15; Thu, 10 Apr 2008 02:50:17 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207810216-27871-5-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79179>

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
1.5.5.33.gc0a39.dirty
