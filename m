From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 1/2] quote: fix broken sq_quote_buf() related comment
Date: Sat,  3 Oct 2015 21:10:46 +0200
Message-ID: <1443899447-8665-1-git-send-email-chriscool@tuxfamily.org>
Cc: Christian Couder <chriscool@tuxfamily.org>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 03 21:12:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiSE9-00035h-Vl
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 21:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbbJCTLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 15:11:42 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36093 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbbJCTLl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 15:11:41 -0400
Received: by wicgb1 with SMTP id gb1so71275667wic.1
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=to8p4PE4m5TnmccGoPrJV3t7cEejYDGI/F61pM3vY9k=;
        b=COi4AdRczPfcb1csWfPlUmavuq2TKhZVUxvvgpIIshcuBuASzR4//h3PRGL/lhuFIT
         TzJeVA/sYfE7GyfN059g+RO5EHqlgO3eZQmwQVTa6lQ0rghPTDYknNmbVKtfhgh1k2vG
         YOj4KbhkJPZFQiHE6uGdqLvz1c7Xaxn5pcmsn3x+VknHZzbT1ZyvV+k9r7BqIaee2Ak6
         UJEfPfZG5kDOOdMGOmhzZ5KpLI0L5P+cdJhbpJISZc9PjZjV6yaiTvpbjF9W4lDTK8UW
         uoqGPNwUohi5cbwxT/6gfDdGaW66EnIfEgU+qIfF9REVNWWx3paFosyNc3V758l8Nsgt
         ig3Q==
X-Received: by 10.180.107.1 with SMTP id gy1mr3968489wib.56.1443899500613;
        Sat, 03 Oct 2015 12:11:40 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id lj12sm5499262wic.0.2015.10.03.12.11.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Oct 2015 12:11:39 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.0.rc2.23.g0e57679
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278982>

Since 77d604c (Enhanced sq_quote(), 10 Oct 2005), the
comment at the beginning of quote.c is broken.
Let's fix it.
---
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
2.6.0.rc2.23.g0e57679
