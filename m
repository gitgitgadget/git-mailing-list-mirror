From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 1/2] quote: fix broken sq_quote_buf() related comment
Date: Thu,  8 Oct 2015 00:05:49 +0200
Message-ID: <1444255550-27631-1-git-send-email-chriscool@tuxfamily.org>
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 00:06:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zjwqq-0005W6-4m
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 00:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbbJGWGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2015 18:06:16 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37799 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757AbbJGWGP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2015 18:06:15 -0400
Received: by wicfx3 with SMTP id fx3so216723wic.0
        for <git@vger.kernel.org>; Wed, 07 Oct 2015 15:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LZl07g6M7FOaqRDotvbLumud4sh+7flFUbbI9I8RbRw=;
        b=vzb1QmvjjGsl7j2d54X6YKu2OKvTFmFPflqQ0NC9fgi8Sh7ebEo6Z2IVmrlqlEScIx
         CBX3EIA1wlLWUJAu8AiokpdXd5g+qYyY07Yr5fSG2TvOu6yt9de9s8fS8QZeMVNG0ta8
         6uEM5aQ7Gwn7uCLQbSs6n/h/C50oA0DpdxbXDkwXJbIF1E2DRBB2KCZJNBg+Gxx1+1zZ
         vevC4+7eFEXUdCDMX8EdiaiqIq9VaGnV3gbrxXfetHmzkRjlWUz36amYXog54DB1Hzkt
         4CkFgaKJYr1d41w6xDq0yaLNpVTPonbwcA8uM11+JCKhWWdxcZT7gYVKK/eCRJDd+QvG
         z/dw==
X-Received: by 10.180.104.38 with SMTP id gb6mr19983wib.86.1444255574319;
        Wed, 07 Oct 2015 15:06:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id hd1sm4385289wib.5.2015.10.07.15.06.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Oct 2015 15:06:13 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279204>

Since 77d604c (Enhanced sq_quote(), 10 Oct 2005), the
comment at the beginning of quote.c is broken.
Let's fix it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
The only change in this v2 is the added Signed-off-by ;-)
Sorry for the spam.

 quote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/quote.c b/quote.c
index 7920e18..890885a 100644
--- a/quote.c
+++ b/quote.c
@@ -7,6 +7,7 @@ int quote_path_fully = 1;
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
+ * single quote pair.
  *
  * E.g.
  *  original     sq_quote     result
-- 
2.6.0
