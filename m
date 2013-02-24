From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 09/16] contrib/credential: make usage text consistent
Date: Sat, 23 Feb 2013 16:20:47 -0800
Message-ID: <1361665254-42866-10-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PLo-000269-LM
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759363Ab3BXAVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:24 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:44186 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351Ab3BXAVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:19 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so932202dak.0
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Jr6lo0KhaW8vvuVpAnBo9LXwKJlM8tFXYjv/Y2jXRPQ=;
        b=e1zBYzeBQ0GsYrc9Ou2UFumzKvw8t9cyqg6gnXy/5JP8ti0K8DFG+xzL5tqp4AMaBQ
         3qKve0dakEaTzNXxWgEhddHk3Vt7R3521cViPR9QTN6wChSS7e+l/i84NS0A9WV+gNW0
         lHNvdl6aKXBQUz1kzTLltHDQJciYZNVqsI0Eu6lVnZlb0S26dTeuTJ/evktHs5X2V/3x
         sI/D0zE2KgYNE3CkgGmPLU7WaV/qhPrytGKeeaFGrOoRgAQTEp35H1YuA11vCbvH4yKs
         sfRRK7qar7d9xG742nNebTGZp9Tepc4uVnFMMQ0zkNDMbTCi6v4BrwyImYeBC8KbhFH2
         XZ4A==
X-Received: by 10.68.227.202 with SMTP id sc10mr10570439pbc.109.1361665278566;
        Sat, 23 Feb 2013 16:21:18 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:17 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-9-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216947>

Use a lowercase "usage:" string for consistency with Git.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/credential/gnome-keyring/git-credential-gnome-keyring.c | 2 +-
 contrib/credential/osxkeychain/git-credential-osxkeychain.c     | 2 +-
 contrib/credential/wincred/git-credential-wincred.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 41f61c5..f2cdefe 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -401,7 +401,7 @@ static void usage(const char *name)
 	const char *basename = strrchr(name,'/');
 
 	basename = (basename) ? basename + 1 : name;
-	fprintf(stderr, "Usage: %s <", basename);
+	fprintf(stderr, "usage: %s <", basename);
 	while(try_op->name) {
 		fprintf(stderr,"%s",(try_op++)->name);
 		if(try_op->name)
diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 6beed12..3940202 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -154,7 +154,7 @@ static void read_credential(void)
 int main(int argc, const char **argv)
 {
 	const char *usage =
-		"Usage: git credential-osxkeychain <get|store|erase>";
+		"usage: git credential-osxkeychain <get|store|erase>";
 
 	if (!argv[1])
 		die(usage);
diff --git a/contrib/credential/wincred/git-credential-wincred.c b/contrib/credential/wincred/git-credential-wincred.c
index cbaec5f..6619492 100644
--- a/contrib/credential/wincred/git-credential-wincred.c
+++ b/contrib/credential/wincred/git-credential-wincred.c
@@ -313,7 +313,7 @@ static void read_credential(void)
 int main(int argc, char *argv[])
 {
 	const char *usage =
-	    "Usage: git credential-wincred <get|store|erase>\n";
+	    "usage: git credential-wincred <get|store|erase>\n";
 
 	if (!argv[1])
 		die(usage);
-- 
1.8.2.rc0.247.g811e0c0
