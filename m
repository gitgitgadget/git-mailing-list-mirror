From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 02/15] contrib/git-credential-gnome-keyring.c: remove unused die() function
Date: Sun, 22 Sep 2013 22:07:58 -0700
Message-ID: <1379912891-12277-3-git-send-email-drafnel@gmail.com>
References: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Cc: pah@qo.cx, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 23 07:09:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNyPC-0002Ga-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 07:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab3IWFJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 01:09:05 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:58071 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156Ab3IWFJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 01:09:03 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so2732312pbb.13
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 22:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5nEDweWVubqFQZ80QZTzKcEtAjdUFDcnSRfTsVURYk0=;
        b=Eq1tbg97KiuExs7+KYoCEU+UMJ+Vz3xd9CzEdRhiA9a0nTAiHlE2FlseGFJ3pT2oap
         NWVrQEt1kaouh6ZoGeF/Cwcbp5ODphB/WAiqTx4mWXU6hs+FFC9pwEUWxDSy2KLVJxSV
         o5rKvN8oSRHOpJ5O6zhX1SGP75Y8K+bujJB02nve9ZmDdWpb1E/VYHKU7uAQrcgwae5B
         5wwAxHC7rI/sOQzaF0Xj0+TCVPVBvAd5z7zmd4G5GHP4C4+mYsH3E4HXPmgVYuyzfwS9
         Gfg+9BnrxMus0xhfVClakS5YNoqQSFD3ZnLV3fd/BaNy6MIYtBpzce8BlA8UxmhSQ1QW
         QNjw==
X-Received: by 10.66.122.40 with SMTP id lp8mr22566383pab.82.1379912942690;
        Sun, 22 Sep 2013 22:09:02 -0700 (PDT)
Received: from charliebrown.hsd1.ca.comcast.net (c-98-248-40-161.hsd1.ca.comcast.net. [98.248.40.161])
        by mx.google.com with ESMTPSA id sb9sm31437553pbb.0.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 22 Sep 2013 22:09:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.489.g545bc72
In-Reply-To: <1379912891-12277-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235200>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 .../credential/gnome-keyring/git-credential-gnome-keyring.c    | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
index 15b0a1c..4334f23 100644
--- a/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
+++ b/contrib/credential/gnome-keyring/git-credential-gnome-keyring.c
@@ -91,16 +91,6 @@ static inline void error(const char *fmt, ...)
 	va_end(ap);
 }
 
-static inline void die(const char *fmt, ...)
-{
-	va_list ap;
-
-	va_start(ap,fmt);
-	error(fmt, ap);
-	va_end(ap);
-	exit(EXIT_FAILURE);
-}
-
 static inline void die_errno(int err)
 {
 	error("%s", strerror(err));
-- 
1.8.4.489.g545bc72
