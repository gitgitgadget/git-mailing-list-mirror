From: Dennis Stosberg <dennis@stosberg.net>
Subject: [PATCH 2/6] Solaris does not support C99 format strings before version 10
Date: Tue, 15 Aug 2006 11:01:22 +0200
Message-ID: <20060815090122.5223.85031.stgit@leonov.stosberg.net>
References: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Aug 15 11:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCuno-0001xX-R3
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752AbWHOJBb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932771AbWHOJBa
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:01:30 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:62399 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S932752AbWHOJB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 05:01:28 -0400
Received: from leonov.stosberg.net (p213.54.74.221.tisdip.tiscali.de [213.54.74.221])
	by ncs.stosberg.net (Postfix) with ESMTP id 5A8CEAEBA047
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:21 +0200 (CEST)
Received: from leonov.stosberg.net (leonov.stosberg.net [127.0.0.1])
	by leonov.stosberg.net (Postfix) with ESMTP id EC66A12173B
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:01:22 +0200 (CEST)
To: git@vger.kernel.org
In-Reply-To: <20060815090031.5223.27458.stgit@leonov.stosberg.net>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25445>

Signed-off-by: Dennis Stosberg <dennis@stosberg.net>
---

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 495631a..3cb6531 100644
--- a/Makefile
+++ b/Makefile
@@ -342,10 +342,12 @@ ifeq ($(uname_S),SunOS)
 		NEEDS_LIBICONV = YesPlease
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
+		NO_C99_FORMAT = YesPlease
 	endif
 	ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
+		NO_C99_FORMAT = YesPlease
 	endif
 	INSTALL = ginstall
 	TAR = gtar
