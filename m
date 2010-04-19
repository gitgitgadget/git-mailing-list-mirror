From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] MSVC: Fix build by adding missing termios.h dummy
Date: Mon, 19 Apr 2010 09:37:20 +0200
Message-ID: <4BCC0830.9050207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 09:37:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3lXu-0003Dv-UG
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 09:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab0DSHh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 03:37:26 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49174 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab0DSHhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 03:37:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O3lXl-00040z-Ig; Mon, 19 Apr 2010 09:37:21 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 39D7E1660F;
	Mon, 19 Apr 2010 09:37:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145272>

From: Johannes Sixt <j6t@kdbg.org>

A use of this header file was introduced in eb80042 (Add missing #include
to support TIOCGWINSZ on Solaris, 2010-01-11).

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/vcbuild/include/termios.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 compat/vcbuild/include/termios.h

diff --git a/compat/vcbuild/include/termios.h
b/compat/vcbuild/include/termios.h
new file mode 100644
index 0000000..0d8552a
--- /dev/null
+++ b/compat/vcbuild/include/termios.h
@@ -0,0 +1 @@
+/* Intentionally empty file to support building git with MSVC */
-- 
1.7.1.rc1.1114.g601ca
