From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] revert: add missing va_end
Date: Sat, 21 Apr 2012 23:15:19 +0200
Message-ID: <20120421211520.2797.87418.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 23:16:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLhez-0006D7-SI
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 23:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab2DUVP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 17:15:57 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:59166 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab2DUVP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2012 17:15:56 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E2B51A6196;
	Sat, 21 Apr 2012 23:15:48 +0200 (CEST)
X-git-sha1: 29967d913c11058be8dda2c482be5b84f58a49df 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196061>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index e6840f2..e4ed023 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -86,6 +86,7 @@ static void verify_opt_mutually_compatible(const char *me, ...)
 				break;
 		}
 	}
+	va_end(ap);
 
 	if (opt1 && opt2)
 		die(_("%s: %s cannot be used with %s"),	me, opt1, opt2);
-- 
1.7.10.rc0.17.g74595
