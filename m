From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 10/10] Make <identifier> lowercase as per CodingGuidelines
Date: Tue, 15 Feb 2011 14:09:13 +0100
Message-ID: <225b45c4590c105d69aa9e1c65aa5e89c2528556.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 14:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpKi8-0004O3-5R
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 14:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab1BONMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 08:12:40 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59284 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752969Ab1BONMf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 08:12:35 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 29D17207CE;
	Tue, 15 Feb 2011 08:12:35 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 15 Feb 2011 08:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=ie/h90EgjuRa7ecY0bX8cEsSyRc=; b=jfNvtsPmQBAooHrFp8VdDttRuFyAu8rjm8aH0EWmDaLYAExJlQRuwfOvGcEjN59x0Joc+I67DC5ubBycGhs78+Bran7JZ7JWvJxeQ3ICl5yOIXRvy1G8Lf9zMo4h5pinxMDbPR6PMfIG1uFcvZnNOPA8PKW43vy9J42Mo7paH2k=
X-Sasl-enc: JZ4Pd6yKWUQ+3x41T7KqbyAgokhHQKNeChwaipLmK7cf 1297775554
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A9411405C7B;
	Tue, 15 Feb 2011 08:12:34 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475.dirty
In-Reply-To: <cover.1297695910.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1297775122.git.git@drmicha.warpmail.net>
References: <cover.1297775122.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166851>

*.c part for matches with '<[A-Z]+>' (and affected test).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t0040-parse-options.sh |    2 +-
 test-parse-options.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 2092450..ae26614 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -19,7 +19,7 @@ usage: test-parse-options <options>
     --set23               set integer to 23
     -t <time>             get timestamp of <time>
     -L, --length <str>    get length of <str>
-    -F, --file <FILE>     set file to <FILE>
+    -F, --file <file>     set file to <file>
 
 String options
     -s, --string <string>
diff --git a/test-parse-options.c b/test-parse-options.c
index 0828592..4e3710b 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -46,7 +46,7 @@ int main(int argc, const char **argv)
 		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
-		OPT_FILENAME('F', "file", &file, "set file to <FILE>"),
+		OPT_FILENAME('F', "file", &file, "set file to <file>"),
 		OPT_GROUP("String options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
-- 
1.7.4.1.74.gf39475.dirty
