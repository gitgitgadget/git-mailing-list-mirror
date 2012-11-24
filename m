From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 03/14] remote-helpers: fix failure message
Date: Sat, 24 Nov 2012 04:17:03 +0100
Message-ID: <1353727034-24698-4-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
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
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Fq-0001zJ-5J
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583Ab2KXDRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:17:40 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab2KXDRi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:17:38 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VzUcZAJ7AdHhFHV6GuaHwW8agHjGbbH4hNPM+5MuKDs=;
        b=y/3vUYJMxYUqA8ZTCgLKgbTdmbONkCYCKewX2fi37JgITqPMpS4rMFgx23X8qyAODk
         IUxZ4COcLJ+wWnp2mpVnJUQ3GNi01ml2lj54GERA+uUks5wQai0oi9aeLIub1j+aJ38F
         IwdhWUbKa7/YJ4H8JTshET/9IdSO4wbdEE58agIkWKkRRJ8Ilu9uu7k9ESFY0fR0NN2T
         5nu0pNS6xnNETud6rMrJnwIKYNBKELQPN48QmNpQBz4MCFIPjLXC4dvN38w8Y8kQxyYw
         SoaBVUD679jtdnKKOR67oZrbqlyFOcuOBeNqDNnUG+124TGyPotgsgHCUtJvASwqxMjI
         MgMw==
Received: by 10.204.151.21 with SMTP id a21mr1719826bkw.124.1353727057439;
        Fri, 23 Nov 2012 19:17:37 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id hm8sm2493473bkc.10.2012.11.23.19.17.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:17:36 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210287>

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
