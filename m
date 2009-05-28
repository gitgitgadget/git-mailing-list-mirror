From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/4] Makefile: use /usr/ucb/install on SunOS platforms rather than ginstall
Date: Wed, 27 May 2009 21:17:05 -0500
Message-ID: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil>
Cc: Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 04:17:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9VBS-0001BF-50
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 04:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939AbZE1CRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 22:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbZE1CRV
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 22:17:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48229 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbZE1CRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 22:17:21 -0400
Received: by mail.nrlssc.navy.mil id n4S2HMGB009392; Wed, 27 May 2009 21:17:22 -0500
X-OriginalArrivalTime: 28 May 2009 02:17:21.0876 (UTC) FILETIME=[6EEAF940:01C9DF3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120134>

From: Brandon Casey <drafnel@gmail.com>

We can avoid a GNU dependency by using /usr/ucb/install.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


This works for me on Solaris 7 and 10.  Any reason not to use it instead
of ginstall?

-brandon


 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index eaae45d..ba78077 100644
--- a/Makefile
+++ b/Makefile
@@ -715,7 +715,7 @@ ifeq ($(uname_S),SunOS)
 		NO_C99_FORMAT = YesPlease
 		NO_STRTOUMAX = YesPlease
 	endif
-	INSTALL = ginstall
+	INSTALL = /usr/ucb/install
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__
 endif
-- 
1.6.3.1.24.g152f4
