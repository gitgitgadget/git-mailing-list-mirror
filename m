From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/45] build: trivial cleanup
Date: Sun,  9 Jun 2013 11:40:15 -0500
Message-ID: <1370796057-25312-4-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulihx-0006M4-55
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab3FIQnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:04 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:59750 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab3FIQnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:00 -0400
Received: by mail-oa0-f44.google.com with SMTP id n10so81039oag.3
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RMVXDyDg9uNpPD7m4lZTUlWb4RlMJzKCmqm9q+g8zjg=;
        b=COE4t+AusqDj3dfYA5fkAahcg8YrFylzmUdzJ4gv37TySpq8xfXQjRjKmujnkhSx5g
         2mhqPP7HVrlgYl/FH5N/LJ3fcefZZD24Qvw0Dcx8KopUvQfc4ntSkSEIeycVkzvNws8f
         gHZ1F/FWH4Vs/NgtloWIiPEbKFBYiV7ThJebXjO4bkZ/8PYaQezdtAtMkxuCeilLk4Fe
         m7Vy7RU7wEgs8dCQZ65b7hqeCG0bIspm08zvedmdbhKfx5l8rmEhTXF3kn7cIrVTxS7w
         GD0Tzb90I7lYWei35DHbzJGLUhEN11JWqAJZYP953ePO8jksDNu5rjrLj9SY/RMpeChm
         lytA==
X-Received: by 10.182.96.168 with SMTP id dt8mr5181790obb.91.1370796179477;
        Sun, 09 Jun 2013 09:42:59 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wv8sm14950988obb.2.2013.06.09.09.42.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:42:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226973>

There's no need to list again the prerequisites.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 34f1240..3b6cd5a 100644
--- a/Makefile
+++ b/Makefile
@@ -2068,13 +2068,13 @@ $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS
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
