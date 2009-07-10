From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI 4/5] Makefile: add section for SGI IRIX 6.5
Date: Fri, 10 Jul 2009 12:10:46 -0500
Message-ID: <39niBtmtFs5Sy_fjtaztVnLg9Lrx8Lsu5hbcnz9Fsc7tFJx0Z7UST-sRmKU2bdVlCmfkGTgtbs4@cipher.nrlssc.navy.mil>
References: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVmZBc5gMLjrIQhevVkHr5EAuPYiuRd5i__yABkFEZOZNG-W8HrgSclE@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVioF-DSUgPaeb2z2kLxvo9ZK1x9ZQKe11vCjlSyOtjKf_tm_u4WsJQY@cipher.nrlssc.navy.mil> <39niBtmtFs5Sy_fjtaztVs0m0Z6eHu_U8OSsTLFxj4rzNA1wRn0zCZA2fZ7PNTjvs9tczSQBvpc@cipher.nrlssc.navy.mil>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 19:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPJdy-0004x3-KS
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 19:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbZGJRL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 13:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754594AbZGJRL6
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 13:11:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57320 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbZGJRL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 13:11:56 -0400
Received: by mail.nrlssc.navy.mil id n6AHBtWo024487; Fri, 10 Jul 2009 12:11:55 -0500
In-Reply-To: <39niBtmtFs5Sy_fjtaztVs0m0Z6eHu_U8OSsTLFxj4rzNA1wRn0zCZA2fZ7PNTjvs9tczSQBvpc@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 10 Jul 2009 17:11:55.0256 (UTC) FILETIME=[86820F80:01CA0181]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123069>

---
 Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index faaab5e..d404524 100644
--- a/Makefile
+++ b/Makefile
@@ -830,6 +830,19 @@ ifeq ($(uname_S),GNU)
 	NO_STRLCPY=YesPlease
 	NO_MKSTEMPS = YesPlease
 endif
+ifeq ($(uname_S),IRIX)
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_MEMMEM = YesPlease
+	NO_MKSTEMPS = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MMAP = YesPlease
+	NO_EXTERNAL_GREP = UnfortunatelyYes
+	SNPRINTF_RETURNS_BOGUS = YesPlease
+	SHELL_PATH = /usr/gnu/bin/bash
+	NEEDS_LIBGEN = YesPlease
+endif
 ifeq ($(uname_S),IRIX64)
 	NO_IPV6=YesPlease
 	NO_SETENV=YesPlease
-- 
1.6.4.rc0.5.g76f7cf
