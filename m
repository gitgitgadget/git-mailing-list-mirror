From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 4/6] contrib/credential/osxkeychain/git-credential-osxkeychain.c: reduce scope of variables
Date: Wed, 16 Apr 2014 02:33:29 -0700
Message-ID: <1397640811-17719-4-git-send-email-gitter.spiros@gmail.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaMEK-0005aN-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 11:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbaDPJeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 05:34:04 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:37668 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbaDPJdp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 05:33:45 -0400
Received: by mail-pb0-f50.google.com with SMTP id md12so10632948pbc.23
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 02:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=54ViKScdOGLCnPdaNWGeCdv/A5mno6ayXS2B50LNamI=;
        b=Ud9Rqos39MJCRdSy9Acy1kh8vHPYRmsFIdL3dKrfpz7eqCbejVAlwxALdHOktgYVsf
         4933/f8f2pmU9rqA7i1k1DXJpBVkIAmfdm4e67HgOK70aWGJnSQiuAhsLnNjsinB/126
         sI4/7lNvHDeS7E7DkPIb9V4zpH+1mwT4NjD+KZHcmo3xULM5VGPkduAzIdiJpi+u86sX
         wxEgeGGtRSO4uDK3si89DnxRsGxC+AYo/r87k/gbZHTELVxN5PhHkYPfM3VVIPC0YZUu
         YfSoqB6K8wNzCvccr8zhWTNyD1Ebr3JALPwFcfRS/JNre3vCdFybzCHUD8Xr6ve7JBrV
         vWdg==
X-Received: by 10.69.19.161 with SMTP id gv1mr7207930pbd.143.1397640825287;
        Wed, 16 Apr 2014 02:33:45 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id de5sm45687493pbc.66.2014.04.16.02.33.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 02:33:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246322>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 contrib/credential/osxkeychain/git-credential-osxkeychain.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index bcd3f57..5ae09f6 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -163,12 +163,12 @@ static void read_credential(void)
 
 int main(int argc, const char **argv)
 {
-	const char *usage =
-		"usage: git credential-osxkeychain <get|store|erase>";
-
 	if (!argv[1])
+	   {
+	       const char *usage =
+			"usage: git credential-osxkeychain <get|store|erase>";
 		die(usage);
-
+	   }
 	read_credential();
 
 	if (!strcmp(argv[1], "get"))
-- 
1.7.10.4
