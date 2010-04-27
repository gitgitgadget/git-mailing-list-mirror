From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 11/16] host-HPUX11.patch
Date: Tue, 27 Apr 2010 13:57:19 +0000
Message-ID: <20100427135859.269153000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 16:00:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lKX-0003LI-6u
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756034Ab0D0N7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:59:04 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:54669 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N7A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:59:00 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 3651F5CDE
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:20:07 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 3651F5CDE
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 79EEFADC;
	Tue, 27 Apr 2010 13:58:59 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 707D511D4D1; Tue, 27 Apr 2010 13:58:59 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-HPUX11.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145914>

There is no nanosecond field on HPUX.
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -970,6 +970,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
+	NO_NSEC = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	ifeq ($(uname_R),B.10.20)
 		NO_PREAD = YesPlease

-- 
Gary V. Vaughan (gary@thewrittenword.com)
