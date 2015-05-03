From: Alangi Derick <alangiderick@gmail.com>
Subject: [PATCH] Fixed translation error (say(_())) functions
Date: Sun, 3 May 2015 23:05:53 +0100
Message-ID: <554769df.43c8c20a.4b7f.ffffc3cb@mx.google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon May 04 14:45:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpFkc-0000Tg-3a
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 14:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbbEDMp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 08:45:29 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34884 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbbEDMpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 08:45:21 -0400
Received: by widdi4 with SMTP id di4so120003227wid.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 05:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject;
        bh=7Rwep3wXFhuerHKkPZluxbvmt6H1uGZJMSwnQA4cIz8=;
        b=fwA2aQA+n7BnxXzYnVutMn4KktOfRWZfj/zlzRfOT3kNfIvSmAXLPc/TKoCI7oPJOy
         uTl6aoARqqIYq2csFT/KHFQYOLV/JyRRa6NfY6bJg/BiRXsfJyIryLI2WP0G0MePwfgK
         f6+KYaH6/1Oca+lPiWXVTeeFXFJtf2hXKCr/t1epHaNLJApXOC/zo/4Eg1NJYZGr/Rs+
         iRYvs0GALGd5qZXVL+Q40Bkf12GF+36ONbjdDX6lCvauNN6Mq2JM+e6Hko+u9iVhRK2n
         02h6n3lJWc6if3qOnJf4x90c3mXYs2O7M8J86v7FxZbjh01kTs3FsfDeWpfTmrA2T9cp
         qB8g==
X-Received: by 10.180.101.138 with SMTP id fg10mr1245269wib.46.1430743520106;
        Mon, 04 May 2015 05:45:20 -0700 (PDT)
Received: from localhost ([195.24.220.134])
        by mx.google.com with ESMTPSA id jq3sm20489039wjc.22.2015.05.04.05.45.18
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 05:45:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268322>

Signed-off-by: Alangi Derick <alangiderick@gmail.com>
---
 base85.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/base85.c b/base85.c
index 5ca601e..4160f44 100644
--- a/base85.c
+++ b/base85.c
@@ -78,7 +78,7 @@ int decode_85(char *dst, const char *buffer, int len)
 
 void encode_85(char *buf, const unsigned char *data, int bytes)
 {
-	say("encode 85");
+	say(_("encode 85"));
 	while (bytes) {
 		unsigned acc = 0;
 		int cnt;
@@ -96,7 +96,7 @@ void encode_85(char *buf, const unsigned char *data, int bytes)
 		}
 		buf += 5;
 	}
-	say("\n");
+	say(_("\n"));
 
 	*buf = 0;
 }
-- 
2.4.0.1.gd092831.dirty
