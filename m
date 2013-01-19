From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] INSTALL: git-p4 doesn't support Python 3
Date: Sat, 19 Jan 2013 12:01:58 +0000
Message-ID: <20130119120158.GH31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 13:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwX82-0000ex-Ih
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 13:02:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab3ASMCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 07:02:08 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:53697 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab3ASMCH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 07:02:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 5E92A22CAA;
	Sat, 19 Jan 2013 12:02:05 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TCQMMgfJsGN1; Sat, 19 Jan 2013 12:02:04 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id B731722B46;
	Sat, 19 Jan 2013 12:02:03 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 70F4C161E547;
	Sat, 19 Jan 2013 12:02:03 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4o-j4CI50Rfu; Sat, 19 Jan 2013 12:02:03 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6BAC8161E276;
	Sat, 19 Jan 2013 12:01:59 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213974>

git-p4 supports Python 2.6 and later versions of Python 2.  Since Pyhton
2.8 will never exist [1], it is most concise to just list the supported
versions.

[1] http://www.python.org/dev/peps/pep-0404/

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 INSTALL | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/INSTALL b/INSTALL
index 28f34bd..c456d1c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -131,7 +131,7 @@ Issues of note:
 	  use English. Under autoconf the configure script will do this
 	  automatically if it can't find libintl on the system.
 
-	- Python version 2.6 or later is needed to use the git-p4
+	- Python version 2.6 or 2.7 is needed to use the git-p4
 	  interface to Perforce.
 
  - Some platform specific issues are dealt with Makefile rules,
-- 
1.8.1
