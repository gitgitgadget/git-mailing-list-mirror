From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] test-genrandom: Add newline to usage string
Date: Thu, 23 Apr 2009 00:25:33 -0700
Message-ID: <1240471533-21124-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 09:27:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwtL6-0006re-4q
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 09:27:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbZDWHZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 03:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753516AbZDWHZj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 03:25:39 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:43485 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbZDWHZi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 03:25:38 -0400
Received: by wf-out-1314.google.com with SMTP id 26so347565wfd.4
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Cuc07heCMVM2z+dRZTeDA3FCyRZkTXQmJwHr66hbObE=;
        b=NPqiQDVa2kasrSgOPSWTW6BjD6M7rmmBjrGpaytQTz3a5EJ2iDacQH6BqkPVmqiQgk
         bL2qWJWKbiCeyaV+Bcg+2sZ7wrYh4FK0/6IfxS7t6zJlgTwcXR1dlIH51r14rns1qt8w
         Cgvp1wBmnYKacA5N9wPdaJ9cHjJJtJohf7dn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=aXuv+dJpRN35aVAoJC5HRT6U7/7wBsVoGJSFRLm0DONwq7XpjTQ/FDrJ71mNRyE4Ar
         w7+Ug6RnGLNk7zAgDlWc0O4aFEj7VkRdSXDLz8rCs39ctDEu0HvV7o7FhaSVVslXyjJF
         ueu5d77jT3jUb8iUAAmaJLhmqwlLnmLBQZnHY=
Received: by 10.142.144.16 with SMTP id r16mr254666wfd.84.1240471537319;
        Thu, 23 Apr 2009 00:25:37 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id 22sm2331045wfi.12.2009.04.23.00.25.35
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 23 Apr 2009 00:25:36 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Thu, 23 Apr 2009 00:25:33 -0700
X-Mailer: git-send-email 1.6.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117304>

A minor fix to place the terminal input on a new line if test-genrandom
is run with no arguments.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 test-genrandom.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test-genrandom.c b/test-genrandom.c
index 8cefe6c..b81ad67 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -13,7 +13,7 @@ int main(int argc, char *argv[])
 	unsigned char *c;
 
 	if (argc < 2 || argc > 3) {
-		fprintf( stderr, "Usage: %s <seed_string> [<size>]", argv[0]);
+		fprintf( stderr, "Usage: %s <seed_string> [<size>]\n", argv[0]);
 		return 1;
 	}
 
-- 
1.6.2.3
