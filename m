From: Sup Yut Sum <ch3cooli@gmail.com>
Subject: [PATCH 2/2] userdiff: support Java try keyword
Date: Mon,  2 Jun 2014 12:13:25 +0800
Message-ID: <1401682405-3319-2-git-send-email-ch3cooli@gmail.com>
References: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
Cc: gitster@pobox.com, Sup Yut Sum <ch3cooli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 06:13:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrJdC-0001AP-0L
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 06:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbaFBENq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 00:13:46 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49085 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbaFBENp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 00:13:45 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so2991097pdi.30
        for <git@vger.kernel.org>; Sun, 01 Jun 2014 21:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ujnd2KmxO4/HmGgyWSWWBiZ4RNmSjYum9aS/5wlTJF4=;
        b=j4tjhspTMcr78a6PLiT7mRMsSLJNboNB5812dN28CP/8soE2kMgiAKk0NylV+HaiV/
         FU7iKLw389UXcrN8HlD6n3w1xtXO2JH5Vs1L2/XP7tGrsnJNSAV2AF16/3gsaYLNOxok
         5KaOOrGqR8ndwbpNvjnYygpBk8COb4eDcSPzKIgXEsG5TK35OPsEaWXo0ulcynIHm8be
         UFXMUIbd5mLcOiZjVAdTDFi7ZJJagVakFIAZlYpsYcmvxjpwBlge7KwBUlv7Pgn7HXO7
         oArK0WIFua4HJG1O4MOoP8Nh9Od4vr62xof2ufTWgXUhmCF6LiCBcQsGIdFTCVQLm4k5
         NswA==
X-Received: by 10.68.240.68 with SMTP id vy4mr36868005pbc.127.1401682425072;
        Sun, 01 Jun 2014 21:13:45 -0700 (PDT)
Received: from localhost.localdomain (n219079230136.netvigator.com. [219.79.230.136])
        by mx.google.com with ESMTPSA id pn4sm9593164pbb.7.2014.06.01.21.13.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Jun 2014 21:13:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1401682405-3319-1-git-send-email-ch3cooli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250549>

try keyword is enhanced in Java 7, see try-with-resources Statement
try (XX yy = new XX()) {
} catch (Exception e){
}

Signed-off-by: Sup Yut Sum <ch3cooli@gmail.com>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index 96eda6c..49e898b 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -39,7 +39,7 @@ IPATTERN("fortran",
 PATTERNS("html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$",
 	 "[^<>= \t]+"),
 PATTERNS("java",
-	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
+	 "!^[ \t]*(try|catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
-- 
1.9.1
