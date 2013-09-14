From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/5] sha1-name: trivial style cleanup
Date: Sat, 14 Sep 2013 01:38:34 -0500
Message-ID: <1379140717-12940-3-git-send-email-felipe.contreras@gmail.com>
References: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 14 08:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKjaP-0003XB-8t
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 08:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab3INGn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 02:43:57 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:33250 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392Ab3INGnz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 02:43:55 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so1897613obc.37
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 23:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/fJS+zwCFmh18vgghXYBMbtEHyVJlTX+gABl2fcob0=;
        b=yJbFOUjI2XsFGknaz15iG4+170NdhT3/nYxH8ulveBdPSv8Am8uyCqxTbw0eqgVVMx
         a5dSr5wJwEa4qbuaq3RFLsU8ViFNBYVsWSHhWTnvaiJ6kxhtauvkA11SVwgJnFBX1/P3
         LdfLSQFdFyp//EBpSWYoiQ/t94cFWKl0Otv6UjVWJUUH85ChyF3ufz181cELBrxwd7/X
         QH6YsbqdmqaR7RUtbMGGvTfj9HumJS2VZtu82WUnFDR0r1YBSKm/Yhz7yIXyKJo/cyNm
         3bJRT+uf1BZE408t2zCoDyTB2zHBOhYeZ06DJW/vBLEqlLplDP5xVVkZQ9TvFhY/ijR6
         ys7A==
X-Received: by 10.60.131.41 with SMTP id oj9mr15933994oeb.40.1379141035414;
        Fri, 13 Sep 2013 23:43:55 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm20379888obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Sep 2013 23:43:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1379140717-12940-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234798>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sha1_name.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 65ad066..9f3e340 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -343,7 +343,6 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
-
 int for_each_abbrev(const char *prefix, each_abbrev_fn fn, void *cb_data)
 {
 	char hex_pfx[40];
-- 
1.8.4-fc
