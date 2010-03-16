From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 09/15] host-HPUX11.patch
Date: Tue, 16 Mar 2010 05:42:29 +0000
Message-ID: <20100316054342.328815000@mlists.thewrittenword.com>
References: <20100316054220.075676000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 06:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrPiW-0002vN-7P
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 06:53:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935340Ab0CPFxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 01:53:07 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:59156 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757474Ab0CPFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 01:52:57 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 720B95CDA
	for <git@vger.kernel.org>; Tue, 16 Mar 2010 06:03:04 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 720B95CDA
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 7DF2BDE9;
	Tue, 16 Mar 2010 05:43:42 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 7848A11D4D5; Tue, 16 Mar 2010 05:43:42 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=host-HPUX11.patch
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142303>

There is no nanosecond field on HPUX.
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

Index: b/Makefile
===================================================================
--- a/Makefile
+++ b/Makefile
@@ -928,6 +928,7 @@ ifeq ($(uname_S),HP-UX)
 	NO_UNSETENV = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_SYS_SELECT_H = YesPlease
+	NO_NSEC = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
 	ifeq ($(uname_R),B.10.20)
 		NO_PREAD = YesPlease

-- 
Gary V. Vaughan (gary@thewrittenword.com)
