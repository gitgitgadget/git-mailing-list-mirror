From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH] Enable threaded delta search on Mac OS X/Darwin
Date: Wed, 17 Dec 2008 09:20:25 +0100
Message-ID: <1229502025-15340-1-git-send-email-arjen@yaph.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 09:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrtG-0007yc-Vy
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641AbYLQIfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbYLQIfE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:35:04 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:2919 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbYLQIfC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:35:02 -0500
X-Greylist: delayed 867 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Dec 2008 03:35:01 EST
Received: from localhost.localdomain (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id mBH8KPEX061393;
	Wed, 17 Dec 2008 09:20:25 +0100 (CET)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.1.rc3.7.gc24a9e
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103318>

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---

This was tested on branch 'next' on an Intel dual-core Mac running OS X
10.5 and a single-CPU PowerPC G4 running OS X 10.4.

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5158197..aabf013 100644
--- a/Makefile
+++ b/Makefile
@@ -645,6 +645,7 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	THREADED_DELTA_SEARCH = YesPlease
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
-- 
1.6.1.rc3.294.g91f21
