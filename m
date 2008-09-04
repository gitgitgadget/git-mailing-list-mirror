From: Christian Stimming <stimming@tuhh.de>
Subject: [PATCH] git-gui: Mark forgotten strings for translation.
Date: Thu, 4 Sep 2008 11:50:53 +0200
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200809041150.53502.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 11:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbBVh-0005Ub-3E
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 11:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755108AbYIDJur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 05:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbYIDJur
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 05:50:47 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:46621 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbYIDJuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 05:50:46 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m849ohjm010661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 4 Sep 2008 11:50:43 +0200
Received: from [192.168.0.101] (e176223161.adsl.alicedsl.de [85.176.223.161])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m849ofdL012800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 4 Sep 2008 11:50:43 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94918>

---
 lib/index.tcl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index 7c27f2a..d011406 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -416,11 +416,11 @@ proc do_revert_selection {} {
 
 	if {[array size selected_paths] > 0} {
 		revert_helper \
-			{Reverting selected files} \
+			[mc "Reverting selected files"] \
 			[array names selected_paths]
 	} elseif {$current_diff_path ne {}} {
 		revert_helper \
-			"Reverting [short_path $current_diff_path]" \
+			[mc "Reverting %s" [short_path $current_diff_path]] \
 			[list $current_diff_path]
 	}
 }
-- 
1.6.0.rc1.34.g0fe8c
