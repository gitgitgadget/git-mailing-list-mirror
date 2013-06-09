From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 02/36] build: do not install git-remote-testgit
Date: Sun,  9 Jun 2013 14:24:16 -0500
Message-ID: <1370805890-3453-3-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGb-0003FB-4B
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab3FIT0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:26:51 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:59817 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3FIT0t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:26:49 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so9072099obc.16
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yD26oqegaXL81sSqv5da513H4KIhemhdNyw8lKyFmOg=;
        b=u8ogk7H+PaYY7K+CyQ2kIiUIqPWeBBDiAXLYG8WDeqYnqkh0rX/TlDcXgDch9j6YsJ
         SPGfZQNSY1o6Z+NQ0lpaWx2B9D1ubAefAToG/eLuuHSSTDFJ74iL6UtZMJQOas9COsFg
         6FhREbaJ2+gwhEwmMmtVR8GYotZLFPF7F1DrlKOIijmKZRl+GXlDUZgl4EdIKaBMDbhe
         hHTcRsmft9DHFifnD+m+mn+zyxtNlMwvME1xVYP9tdUoshfjsD9XaYsKllxhb3lJsDkA
         j/PXH7Rr3HpM+73CjKAkm38q7cxeT0fiWFwZSfQZszg3KQQRFvE3fLJ/fn3AH52ReLjK
         +o4A==
X-Received: by 10.60.59.74 with SMTP id x10mr5542422oeq.48.1370806008812;
        Sun, 09 Jun 2013 12:26:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d5sm16302005oex.0.2013.06.09.12.26.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:26:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227112>

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
