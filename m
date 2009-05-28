From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 3/4] Makefile: add section for SunOS 5.7
Date: Wed, 27 May 2009 21:17:07 -0500
Message-ID: <8D9Pn2N3FZLQcyxrPABrG-BSSbTCg9PE0lVG9rBAr5BVQibQYcIzXrxDf4S0P9Pb6AZO5MBuasg@cipher.nrlssc.navy.mil>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 04:17:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9VBo-0001II-9V
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 04:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbZE1CRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 22:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754068AbZE1CRX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 22:17:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48231 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbZE1CRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 22:17:21 -0400
Received: by mail.nrlssc.navy.mil id n4S2HM5L009401; Wed, 27 May 2009 21:17:22 -0500
In-Reply-To: <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 28 May 2009 02:17:22.0236 (UTC) FILETIME=[6F21E7C0:01C9DF3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120136>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 32b28ea..8b377f3 100644
--- a/Makefile
+++ b/Makefile
@@ -707,6 +707,15 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	OLD_ICONV = UnfortunatelyYes
+	ifeq ($(uname_R),5.7)
+		NO_IPV6 = YesPlease
+		NO_SOCKADDR_STORAGE = YesPlease
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRLCPY = YesPlease
+		NO_C99_FORMAT = YesPlease
+		NO_STRTOUMAX = YesPlease
+	endif
 	ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
-- 
1.6.3.1.24.g152f4
