From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 1/2] Makefile: Windows lacks /dev/tty
Date: Mon, 12 Dec 2011 22:10:03 +0100
Message-ID: <4EE66DAB.5070407@kdbg.org>
References: <20111210103943.GA16478@sigill.intra.peff.net> <20111210104130.GI16648@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 22:10:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaD8c-0001fY-Jj
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 22:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135Ab1LLVKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 16:10:11 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:45703 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753529Ab1LLVKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 16:10:09 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 6C1C5A7EC2;
	Mon, 12 Dec 2011 22:10:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 1784319F5F7;
	Mon, 12 Dec 2011 22:10:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <20111210104130.GI16648@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186947>

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
These two patches go on top of jk/credentials.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2c506b3..5b7f6a8 100644
--- a/Makefile
+++ b/Makefile
@@ -1139,6 +1139,7 @@ ifeq ($(uname_S),Windows)
 	NO_CURL = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	NO_DEV_TTY = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	NATIVE_CRLF = YesPlease
 
@@ -1232,6 +1233,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	ETAGS_TARGET = ETAGS
 	NO_INET_PTON = YesPlease
 	NO_INET_NTOP = YesPlease
+	NO_DEV_TTY = YesPlease
 	NO_POSIX_GOODIES = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-- 
1.7.8.216.g2e426
