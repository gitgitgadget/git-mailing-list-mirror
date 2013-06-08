From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] build: trivial cleanup
Date: Sat,  8 Jun 2013 17:38:58 -0500
Message-ID: <1370731138-32681-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 00:41:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlRor-0003gR-LK
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 00:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab3FHWkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 18:40:51 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47422 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358Ab3FHWku (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 18:40:50 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8264915obc.20
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=fdzqFHbabEQdV11V9ZcjrGgU5wdwm1qmI652vnKVr2s=;
        b=yF3FDUVw7BiY30qDSqNXqGyAhqqi+WKqKu+p8ZknMoir8/qqjLqwnSJhbKOM/CPCe+
         oqdoQrG2Vlonb0kXK20fF7Wa0zm/gW/5Es74jCtKLQD804QHKxhP0LnE99ZXv7sJ2VMn
         7cGaTlpYWXVD7kqfAZtDjqfcs1pkTL8rF0VIsJ268eqAZeKBRXsEasvM0VudHztz5a/u
         um3XEWQqQTozR3hdPQ4Cp5eWBji3z1UgLOEPq4uCIdunL3U5xnAMCO0I5Fv/TcmTVRN8
         2h2qaAuj92HzKVMjb1pMbCQ1niWnkrU5nFIIue51ezREK9I0AQ91sbSXPNpD0kKlMD/L
         H4Lw==
X-Received: by 10.182.118.129 with SMTP id km1mr3449939obb.15.1370731249814;
        Sat, 08 Jun 2013 15:40:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wx1sm9160361obb.8.2013.06.08.15.40.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 15:40:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226863>

There's no need to list again the prerequisites.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 03524d0..fda98d6 100644
--- a/Makefile
+++ b/Makefile
@@ -2067,13 +2067,13 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(XDIFF_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
 $(VCSSVN_LIB): $(VCSSVN_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(VCSSVN_OBJS)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $^
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
-- 
1.8.3.698.g079b096
