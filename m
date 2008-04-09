From: Bryan Donlan <bdonlan@fushizen.net>
Subject: [PATCH 7/8] Use test_set_editor in t9001-send-email.sh
Date: Tue,  8 Apr 2008 21:30:03 -0400
Message-ID: <1207704604-30393-7-git-send-email-bdonlan@fushizen.net>
References: <>
 <cover.1207702130.git.bdonlan@fushizen.net>
 <1207704604-30393-1-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-2-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-3-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-4-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-5-git-send-email-bdonlan@fushizen.net>
 <1207704604-30393-6-git-send-email-bdonlan@fushizen.net>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Roben <aroben@apple.com>, gitster@pobox.com,
	Bryan Donlan <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 03:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjPAd-0007yb-0M
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 03:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbYDIBbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbYDIBbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 21:31:25 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:49041 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYDIBbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 21:31:24 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bd@fushizen.net>)
	id 1JjP8b-0007dR-Fe; Wed, 09 Apr 2008 01:30:09 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bd@shion.is.fushizen.net>)
	id 1JjP8W-0007vH-MT; Tue, 08 Apr 2008 21:30:04 -0400
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1207704604-30393-6-git-send-email-bdonlan@fushizen.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79065>

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
1.5.5.8.gbbd98
