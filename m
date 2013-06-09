From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 03/36] build: trivial cleanup
Date: Sun,  9 Jun 2013 14:24:17 -0500
Message-ID: <1370805890-3453-4-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGb-0003FB-ME
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab3FIT0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:26:53 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:55201 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3FIT0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:26:52 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so8971170obb.28
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RMVXDyDg9uNpPD7m4lZTUlWb4RlMJzKCmqm9q+g8zjg=;
        b=IQR9Nggc8TwZH4TBBqhttuvpd+7IvWnU1961P/WK5ngbkDUz403p8fK9mtmNItYz/g
         +jMSPf/SoVgLtimCWZ7TZDpuCfOu5L3p0yrWaUHnEQusLdWLHW+yIf1yKQmwO8dlTgOG
         9r5cXy64BsqIcx2BqeNhtawA+QnTsseBNbg2zvyQ8ov1FIEpNP3OnQ2BmaLhkVI+QowD
         784Uze/+HMefvnIMv7PWBx7Izamic/KmIr5CNdEVVAArt9WUx2gr/2tFX1ZzP3pePHOL
         MtjZh+qpZ0axWCSf6wMua7fmBOi5PjSqdAT1hGwr2VDZEjgL2VuOgHKG4BPCQAxSoQOQ
         t4pQ==
X-Received: by 10.60.121.33 with SMTP id lh1mr5433123oeb.98.1370806011818;
        Sun, 09 Jun 2013 12:26:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i2sm15949218obz.11.2013.06.09.12.26.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:26:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227113>

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
