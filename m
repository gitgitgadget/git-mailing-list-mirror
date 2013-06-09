From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 02/45] build: do not install git-remote-testgit
Date: Sun,  9 Jun 2013 11:40:14 -0500
Message-ID: <1370796057-25312-3-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulii5-0006RE-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab3FIQnD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:03 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:64774 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3FIQm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:42:56 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so417358oag.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yD26oqegaXL81sSqv5da513H4KIhemhdNyw8lKyFmOg=;
        b=e7WdBBflRy+v07x2Y6vyxww2j82aI32dWV6+zXOszZBVfYE38uP0f4ylYY+q4OhV29
         z/a63ljmO5s1sjO03kr5lYWufMdtbRkvoxVRFBRgeNkbn2Vbha/O4FT3rlRmnp0I9NdT
         UZ/8A3wAzK/zt0l7MeW/v4ew5swnkT7VZKjZIGeRdQKgTulsPPCprz236fNZRQB1Rcb5
         IEatCp4ZdnUQ5iijjRUPJjVxv02pR/FXPqq0t96at8w+TVOzl4nU855k7PgTTemGU7Sp
         OyPdm+EDnmTmtTZFgMISkxgzOt1oCbeP2bExKlUiiA+TUgX1UZ9VqxmXrEfB25rxnWmF
         osag==
X-Received: by 10.182.66.170 with SMTP id g10mr5360494obt.64.1370796176176;
        Sun, 09 Jun 2013 09:42:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm212108oed.5.2013.06.09.09.42.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:42:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226974>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 51c812d..34f1240 100644
--- a/Makefile
+++ b/Makefile
@@ -491,6 +491,7 @@ SCRIPT_PERL += git-svn.perl
 SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
+NO_INSTALL += git-remote-testgit
 NO_INSTALL += git-remote-testpy
 
 # Generated files for scripts
-- 
1.8.3.698.g079b096
