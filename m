From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 09/16] contrib/credential: use a lowercase "usage:" string
Date: Sat, 23 Feb 2013 16:50:17 -0800
Message-ID: <1361667024-49776-10-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
 <1361667024-49776-9-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoK-0007hj-LV
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091Ab3BXAu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:50:58 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:45853 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759390Ab3BXAu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:50:56 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so1123438pad.24
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=KRSDWNsC4wolEfR0oZjBMKRfzjxCNR8j/1DdZOysYg4=;
        b=WMFiKwPYElGUD0z8VlhTACU+BCauZ8Ffi9LaqcdNgg5QaZrzMDy15LACGme5QfftPs
         So00g4PChE8y3BBNuCzMe6KHqh+t+irkAUu2xBCn/erGSwnmNe3GiZI4GJzGUcqmvX0R
         lSKeOAPCyhVsk3qqdYrv9B9zoBcHTHElEUGmnXiPvkiGZvChu6sG/PSW2uXe9kmboVsz
         dGrIHSiUeOA1+FRJX2i9kWQ1Qrsxl0w/+Kdo/CWKBtO5ZixDRjjX49N/Ggk/pV0wF+TM
         WGsa0OUnWElasp1VtpJHKmAIK/8pJCFr0phcnWanMO498k8QvMW12ZxCkKQzdUIGSpts
         ok/w==
X-Received: by 10.66.251.129 with SMTP id zk1mr11814464pac.9.1361667056503;
        Sat, 23 Feb 2013 16:50:56 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:50:55 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-9-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216965>

Make the usage string consistent with Git.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
1.8.2.rc0.263.g20d9441
