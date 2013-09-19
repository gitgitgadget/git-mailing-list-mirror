From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH jk/config-int-range-check] compat/mingw.h: define PRId64
Date: Thu, 19 Sep 2013 09:17:07 +0200
Message-ID: <523AA4F3.6010406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 19 09:17:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMYUF-0005Ul-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 09:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919Ab3ISHRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 03:17:11 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254]:52338 "EHLO
	theia.linz.viscovery" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752735Ab3ISHRL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 03:17:11 -0400
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D727C16613;
	Thu, 19 Sep 2013 09:17:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235003>

From: Johannes Sixt <j6t@kdbg.org>

Provide PRId64 alongside PRIuMAX.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I thought I had compiled 'next' on Windows recently...

 This is an emergency fix for a compile error in 'master'.

 compat/mingw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/compat/mingw.h b/compat/mingw.h
index bd0a88b..9eb3b17 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -322,6 +322,7 @@ static inline char *mingw_find_last_dir_sep(const char *path)
 #define find_last_dir_sep mingw_find_last_dir_sep
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
+#define PRId64 "I64d"
 
 void mingw_open_html(const char *path);
 #define open_html mingw_open_html
-- 
1.8.4.1573.g0cbe1bc
