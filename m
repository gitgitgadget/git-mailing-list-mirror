From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 8/8] Makefile: add section for SunOS 5.7
Date: Fri,  5 Jun 2009 18:36:16 -0500
Message-ID: <67hZHClrEWQHxCRdWosE25x46gbs5mk4cBr-7yXBpcpjvPDOYiInnlMoifjngR6R06unonkmtmc@cipher.nrlssc.navy.mil>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org> <67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE24FbCSWPktK230jx86LzLj0Aqa5g5XoJb3Iv805pzfx5wCPameuSp6M@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE28bOBU_EdMUdyv6uENKCaQfOLQjhGBq3kLwxe6mMrfW4HauaUwWt5eM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE26gwuGblUI8bcWLxyoPZhmfzJAibRVMtix-zkRUKYe5Y8R8-GRcIkUI@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2-yxscBzIn8DiQogVPM7EAgcGyYg61V8vYLxFiW6A4ovZp6SOuP0pDM@cipher.nrlssc.navy.mil> <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHM
 fucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil>
Cc: gitster@pobox.com, peff@peff.net, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 01:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCixs-0002dR-47
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 01:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbZFEXgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 19:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbZFEXgh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 19:36:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51662 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZFEXgd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 19:36:33 -0400
Received: by mail.nrlssc.navy.mil id n55NaS19019262; Fri, 5 Jun 2009 18:36:30 -0500
In-Reply-To: <67hZHClrEWQHxCRdWosE2_PLKo8HHFSCQIZrHMfucFNo_Bdy4p79XNP-MU8gnsUflWndiCqfhFM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 05 Jun 2009 23:36:28.0677 (UTC) FILETIME=[72E17350:01C9E636]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120843>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 Makefile |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ca09572..0fe8ec9 100644
--- a/Makefile
+++ b/Makefile
@@ -720,6 +720,16 @@ ifeq ($(uname_S),SunOS)
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
+	ifeq ($(uname_R),5.7)
+		NEEDS_RESOLV = YesPlease
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
