From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/16] pretty: trivial style fix
Date: Thu, 31 Oct 2013 03:25:42 -0600
Message-ID: <1383211547-9145-12-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocj-0008Ez-A0
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab3JaJc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:57 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44899 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3JaJcz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:55 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so2728351obb.4
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pfySE7PSoVdXZMIS09JiOsTGKWt6ssPXjDVxAS/iuOo=;
        b=nRDdkNeqq9od1jV3eUPHiiU25UKk3DAYch3z60aW5bCD6sDuDvjoYB0jClSesarGKE
         LqvIfM3Asxezf2+Ukntxavel+GrJmE7STZuXFhCy/VDHcyyOuV5NkNTt7gFqqWaDOrye
         9EXFCaA/hoQ4XOpeRxZ4OpEmfjCiQPxzBybJSGl4Xr/U4nfR5tOqpLbix/giQ7i8ueQL
         n2f4ukQQniTCo8pzMZpUMMbDvmE+qHkrX0VyC+CDS9SMyV6yzmuFf/gJnnnZCLQKzTmB
         kjN3hEgO917UOKVlMjN2hibKatpnJ+BKBXcISDsq9gB3ZAhgn7thGKEVEV4qyH6dj35b
         pnbQ==
X-Received: by 10.182.40.201 with SMTP id z9mr1806221obk.45.1383211975293;
        Thu, 31 Oct 2013 02:32:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id eg8sm4486218obd.6.2013.10.31.02.32.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237095>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 pretty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index b4e32b7..962e82b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -497,7 +497,7 @@ void pp_user_info(struct pretty_print_context *pp,
 static int is_empty_line(const char *line, int *len_p)
 {
 	int len = *len_p;
-	while (len && isspace(line[len-1]))
+	while (len && isspace(line[len - 1]))
 		len--;
 	*len_p = len;
 	return !len;
-- 
1.8.4.2+fc1
