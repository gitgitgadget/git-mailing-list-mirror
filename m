From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] INSTALL: git-p4 doesn't support Python 3
Date: Sun, 20 Jan 2013 11:06:20 +0000
Message-ID: <20130120110620.GJ31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 12:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Twsjl-0005bU-AL
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 12:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679Ab3ATLGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 06:06:30 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:47676 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404Ab3ATLG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 06:06:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 7FDA1606538;
	Sun, 20 Jan 2013 11:06:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xL0IKd4E7p6p; Sun, 20 Jan 2013 11:06:27 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 177786064D3;
	Sun, 20 Jan 2013 11:06:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 10657161E560;
	Sun, 20 Jan 2013 11:06:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TNQHQ+5qURbQ; Sun, 20 Jan 2013 11:06:26 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 8F81A161E54F;
	Sun, 20 Jan 2013 11:06:22 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214003>

git-p4 supports Python 2.6 and later versions of Python 2.  Since Python
2.8 will never exist [1], it is most concise to just list the supported
versions.

[1] http://www.python.org/dev/peps/pep-0404/

Signed-off-by: John Keeping <john@keeping.me.uk>
Acked-by: Pete Wyckoff <pw@padd.com>
---
Since v1:
 - Fixed a typo in the commit message.

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
1.8.1.353.gc992d5a.dirty
