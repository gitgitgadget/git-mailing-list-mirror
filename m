From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/8] Makefile: use /usr/ucb/install on SunOS platforms rather than ginstall
Date: Fri,  5 Jun 2009 18:36:09 -0500
Message-ID: <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:36:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCixt-0002dR-HS
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbZFEXgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbZFEXgm
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:36:42 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51673 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbZFEXgl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:36:41 -0400
Received: by mail.nrlssc.navy.mil id n55NaRha019246; Fri, 5 Jun 2009 18:36:27 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:27.0583 (UTC) FILETIME=[723A84F0:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120845>

From: Brandon Casey <drafnel@gmail.com>

We can avoid a GNU dependency by using /usr/ucb/install.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 06c39e4..baa05f5 100644
--- a/Makefile
+++ b/Makefile
@@ -726,7 +726,7 @@ ifeq ($(uname_S),SunOS)
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
