From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 03/15] remote-helpers: fix failure message
Date: Sun, 11 Nov 2012 14:59:40 +0100
Message-ID: <1352642392-28387-4-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY5l-0007eN-Am
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640Ab2KKOAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:00:40 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab2KKOAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:00:40 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VzUcZAJ7AdHhFHV6GuaHwW8agHjGbbH4hNPM+5MuKDs=;
        b=aUGS1T3KuqPX6MZiEylKmW43kb9bvNMPc4wbq9Umfv47RTza70SVovrpfbig3tzbNT
         oLGeLBS6KuSpwhfXZKbV9xBcnJEYuB0td/14zRGEb+B4yuQBtAOZWQWMo2WMF4dyLm5W
         TOkBhH4V/PPrzflhSrwI1dFb5Ejiqupbjv7xrf4GhzLv33219lzV8S/Eox6+Lvrry+Rq
         omgr1t5XVDsCZ1UKpfzFjLFtsQKM5DO2e7mwcLA7tj4uluVxK6/cvwI3DfhQpyI82a57
         1bGKBE6gSUc+Jsoap3sp0+f/ZWtf76DGU4L1vuuiZNVmajDJuGGqt8LI+2Hb9gicA1zh
         zjAQ==
Received: by 10.205.137.7 with SMTP id im7mr5885645bkc.25.1352642439094;
        Sun, 11 Nov 2012 06:00:39 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id n27sm1494770bkw.0.2012.11.11.06.00.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:00:38 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209357>

This is remote-testgit, not remote-hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5800-remote-helpers.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index e7dc668..d46fa40 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -8,7 +8,7 @@ test_description='Test remote-helper import and export commands'
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON ; then
-	skip_all='skipping git-remote-hg tests, python not available'
+	skip_all='skipping remote-testgit tests, python not available'
 	test_done
 fi
 
@@ -17,7 +17,7 @@ import sys
 if sys.hexversion < 0x02040000:
     sys.exit(1)
 ' || {
-	skip_all='skipping git-remote-hg tests, python version < 2.4'
+	skip_all='skipping remote-testgit tests, python version < 2.4'
 	test_done
 }
 
-- 
1.8.0
