From: Adrian Aichner <adrian.aichner@gmail.com>
Subject: [PATCH/RFC] simple typo fix
Date: Sun, 26 Aug 2012 05:21:34 +0200
Message-ID: <1345951295-2261-1-git-send-email-adrian.aichner@gmail.com>
Cc: jdl@jdl.com, adrian.aichner@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 05:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5TQw-00009v-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 26 Aug 2012 05:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab2HZDVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 23:21:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63872 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2HZDVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 23:21:52 -0400
Received: by wgbdr13 with SMTP id dr13so2618668wgb.1
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 20:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0t5lGVJ87hEnG410hGkqIzEe56Acp45W35HophoD1IE=;
        b=0DBSbkY20QMpBmp/aZNDYEz53fpe3KgIgeatpNLd6RM0yaIxT1DyRomvFhq4ZRtQ+n
         X6McNbv56dzuzrUrDfESbsV+VuskCnqrTTDJwjyXwdkq3s59oog4zuivjv6aM4d2FvkF
         /j2WJ+12scpUApm0HOuJrPL3dnX7TC46pczIJm8Z8N7fR+Bj1NUmSVpkr9lDH0fVr9Ml
         1i5jUXOQpJcQtOf3hHCgwwEEbRiqy94RL2VYhjmxHdUmE6sm71HAF6ivHzwSdhocysR3
         q2DS9eGKcXIsCl1KygItbKtBZCwdWYcehPY8NJN7z7a8bKjG9NnnwaNfanGrNw4N9f7p
         chbg==
Received: by 10.180.91.228 with SMTP id ch4mr15755701wib.7.1345951310555;
        Sat, 25 Aug 2012 20:21:50 -0700 (PDT)
Received: from localhost.localdomain (port-87-234-83-23.dynamic.qsc.de. [87.234.83.23])
        by mx.google.com with ESMTPS id bc2sm10194402wib.0.2012.08.25.20.21.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 20:21:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204292>

From: AichnerAd <adrian.aichner@gmail.com>

Please let me know what you think of this patch.

The test mail I sent myself in gmail looked good with "Show original".

Best regards
Adrian
---
 Documentation/git-daemon.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index e8f7577..4799e35 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -220,7 +220,7 @@ git		9418/tcp		# Git Version Control System
 	To set up 'git daemon' as an inetd service that handles any
 	repository under the whitelisted set of directories, /pub/foo
 	and /pub/bar, place an entry like the following into
-	/etc/inetd all on one line:
+	/etc/inetd.conf all on one line:
 +
 ------------------------------------------------
 	git stream tcp nowait nobody  /usr/bin/git
@@ -233,7 +233,7 @@ git		9418/tcp		# Git Version Control System
 	To set up 'git daemon' as an inetd service that handles
 	repositories for different virtual hosts, `www.example.com`
 	and `www.example.org`, place an entry like the following into
-	`/etc/inetd` all on one line:
+	`/etc/inetd.conf` all on one line:
 +
 ------------------------------------------------
 	git stream tcp nowait nobody /usr/bin/git
-- 
1.7.9
