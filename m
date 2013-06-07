From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] build: do not install git-remote-testgit
Date: Fri,  7 Jun 2013 17:03:07 -0500
Message-ID: <1370642587-32352-3-git-send-email-felipe.contreras@gmail.com>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:05:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul4md-0001M4-3L
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab3FGWFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:05:09 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:51640 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FGWFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:05:04 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so3887857oag.31
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sPxsUmanHxC+nsdNwnMvhOgEkvuSw5as6Wm63vsdWmU=;
        b=OjKBL+8XiA8Y773/5k01fidmyMgB9T967DEplDnGj5YSogM/AC5KKpxfJh4/mOeM2b
         3XDbJir9lA5+VGIT137LAoxuDRdHXUfaIuham9lqn+zV7Lxs5ndBg1tVVj0EhOQCjk6Q
         g75ngr9t6KJrSQNqQvJYKrM1hrsEs3qCsfdZQ73gPDbHjdsFFfJNChl+hZcmi3ExWaEJ
         I1IPz4HZy9uV03Otg2fYnRhTKGEDFRDwVQFzvP0sN1aLWRvdsHVGkl/q9WMaAY6JNgz4
         Urr58lLphNvvbaHyOW46qY51tHGxh/PWj6077tU8VMqGD4hYmZgQzFMBRmwWU09JepTH
         T8GA==
X-Received: by 10.60.149.167 with SMTP id ub7mr497467oeb.55.1370642703305;
        Fri, 07 Jun 2013 15:05:03 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d5sm966951oex.0.2013.06.07.15.05.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:05:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226748>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 126be01..02e3d43 100644
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
