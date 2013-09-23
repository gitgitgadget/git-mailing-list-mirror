From: Brandon Casey <bcasey@nvidia.com>
Subject: [PATCH v2 03/16] contrib/git-credential-gnome-keyring.c: *style* use "if ()" not "if()" etc.
Date: Mon, 23 Sep 2013 11:49:04 -0700
Message-ID: <1379962157-1338-4-git-send-email-bcasey@nvidia.com>
References: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <john@szakmeister.net>, <pah@qo.cx>, <felipe.contreras@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 23 20:49:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBCb-0007aR-OU
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 20:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab3IWSt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 14:49:27 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9055 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3IWStZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 14:49:25 -0400
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
	id <B52408d200000>; Mon, 23 Sep 2013 11:49:04 -0700
Received: from hqemhub01.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2013 11:45:51 -0700
X-PGP-Universal: processed;
	by hqnvupgp08.nvidia.com on Mon, 23 Sep 2013 11:45:51 -0700
Received: from sc-xterm-13.nvidia.com (172.20.144.16) by hqemhub01.nvidia.com
 (172.20.150.30) with Microsoft SMTP Server id 8.3.327.1; Mon, 23 Sep 2013
 11:49:24 -0700
X-Mailer: git-send-email 1.8.4.rc4.6.g5555d19
In-Reply-To: <1379962157-1338-1-git-send-email-bcasey@nvidia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235216>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../gnome-keyring/git-credential-gnome-keyring.c     | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 4334f23..809b1b7 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -117,10 +117,10 @@ static char* keyring_object(struct credential *c)
 		return object;
 
 	object = (char*) malloc(strlen(c->host)+strlen(c->path)+8);
-	if(!object)
+	if (!object)
 		die_errno(errno);
 
-	if(c->port)
+	if (c->port)
 		sprintf(object,"%s:%hd/%s",c->host,c->port,c->path);
 	else
 		sprintf(object,"%s/%s",c->host,c->path);
@@ -314,14 +314,14 @@ int credential_read(struct credential *c)
 	{
 		line_len = strlen(buf);
 
-		if(buf[line_len-1]=='\n')
+		if (buf[line_len-1]=='\n')
 			buf[--line_len]='\0';
 
-		if(!line_len)
+		if (!line_len)
 			break;
 
 		value = strchr(buf,'=');
-		if(!value) {
+		if (!value) {
 			warning("invalid credential line: %s", key);
 			return -1;
 		}
@@ -379,9 +379,9 @@ static void usage(const char *name)
 
 	basename = (basename) ? basename + 1 : name;
 	fprintf(stderr, "usage: %s <", basename);
-	while(try_op->name) {
+	while (try_op->name) {
 		fprintf(stderr,"%s",(try_op++)->name);
-		if(try_op->name)
+		if (try_op->name)
 			fprintf(stderr,"%s","|");
 	}
 	fprintf(stderr,"%s",">\n");
@@ -400,15 +400,15 @@ int main(int argc, char *argv[])
 	}
 
 	/* lookup operation callback */
-	while(try_op->name && strcmp(argv[1], try_op->name))
+	while (try_op->name && strcmp(argv[1], try_op->name))
 		try_op++;
 
 	/* unsupported operation given -- ignore silently */
-	if(!try_op->name || !try_op->op)
+	if (!try_op->name || !try_op->op)
 		goto out;
 
 	ret = credential_read(&cred);
-	if(ret)
+	if (ret)
 		goto out;
 
 	/* perform credential operation */
-- 
1.8.4.rc4.6.g5555d19


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
