From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] string-list: rename the include guard to STRING_LIST_H
Date: Fri,  8 Jan 2010 17:45:08 -0500
Message-ID: <1262990708-1375-1-git-send-email-tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 23:45:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNa9-00044W-LU
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0AHWpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 17:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754014Ab0AHWpS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:45:18 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:33875 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0AHWpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 17:45:17 -0500
Received: by qyk30 with SMTP id 30so9213668qyk.33
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 14:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=2l8e7au1Z08RX1wFfzaQY3V4JjXpLKsceujEKqj28VE=;
        b=rhBDMKnZL2TVyNCXdDKMKPVPyJMls756j5WNNlZF5L0m4cdumiY4kbBnrK/WTyp+NF
         /Ygjj1wv/eKchhwTIJ94sMNh+Hz2aPHtBiU4bmB6sIb5g/xZDCnK2la0Dv5YEEORWieM
         V0kxiUJ+whdcaDFJTNuXRc3z2PxDxDZAkRoGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=ccNZlF8GAdBRON6OSiCDv7NLIexcEB6YG7oOYxg2cYSJHZEtMZUouOzsfDXl8+a7D8
         uHuQfr0sSJsBnSCriQtwfo0ca7Dom0W9YTUjQUoSzHPlYvbwaNhX+d4hYS4+s2kHMy9Q
         hCTKJsPd6LYlpT7NYzqAeeeQhpK1hGvPWO56M=
Received: by 10.224.1.28 with SMTP id 28mr14862400qad.313.1262990715834;
        Fri, 08 Jan 2010 14:45:15 -0800 (PST)
Received: from localhost ([201.53.2.165])
        by mx.google.com with ESMTPS id 7sm25207069qwb.12.2010.01.08.14.45.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Jan 2010 14:45:15 -0800 (PST)
X-Mailer: git-send-email 1.6.6.75.g37bae
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136485>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 string-list.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/string-list.h b/string-list.h
index 14bbc47..6569cf6 100644
--- a/string-list.h
+++ b/string-list.h
@@ -1,5 +1,5 @@
-#ifndef PATH_LIST_H
-#define PATH_LIST_H
+#ifndef STRING_LIST_H
+#define STRING_LIST_H
 
 struct string_list_item {
 	char *string;
@@ -39,4 +39,4 @@ struct string_list_item *string_list_append(const char *string, struct string_li
 void sort_string_list(struct string_list *list);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 
-#endif /* PATH_LIST_H */
+#endif /* STRING_LIST_H */
-- 
1.6.6.75.g37bae
