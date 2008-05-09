From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] wt-status.h: declare global variables as extern
Date: Fri,  9 May 2008 10:05:27 +0200
Message-ID: <1210320327-24403-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 10:06:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuNcX-0001Cb-4w
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 10:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757073AbYEIIFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 04:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757048AbYEIIFe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 04:05:34 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10893 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755010AbYEIIFc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 04:05:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1JuNbb-0004qV-QI; Fri, 09 May 2008 10:05:28 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 97097546; Fri,  9 May 2008 10:05:27 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 5C28AFA49; Fri,  9 May 2008 10:05:27 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.125.gb9f88
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81607>

There are linkers out there that complain if a global non-static variable
is defined multiple times.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 wt-status.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.h b/wt-status.h
index 02afaa6..7d61410 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -28,8 +28,8 @@ struct wt_status {
 };
 
 int git_status_config(const char *var, const char *value);
-int wt_status_use_color;
-int wt_status_relative_paths;
+extern int wt_status_use_color;
+extern int wt_status_relative_paths;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 
-- 
1.5.5.1.125.gb9f88
