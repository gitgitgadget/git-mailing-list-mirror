From: Lars Vogel <lars.vogel@gmail.com>
Subject: [PATCH] Adds *~ to the .gitignore
Date: Thu,  9 Jun 2016 23:10:29 +0200
Message-ID: <1465506629-16577-1-git-send-email-Lars.Vogel@vogella.com>
Cc: Lars Vogel <Lars.Vogel@vogella.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 23:11:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB7EV-0006f9-22
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 23:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbcFIVKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 17:10:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35645 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbcFIVKw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 17:10:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id k184so13540677wme.2
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KgmyVLv0taPkfGvazsz6VG1X3fTSXx7HTwuS4sxsIEg=;
        b=bF3bFF6sfSEZERg4Z+P30wenDu5ypLjHtes6b3mARYoVado0EFfnAL19u9WxMxkb2i
         +9l5apyfKPSMHfEuBK+TdomhWvJg7Rg7MXfzMxTdAQ5cYtjWf0qXReodjfnsiCGgu83u
         yCUQMauLH1f8RjfjlTZ4ik3TdFvGQitTxm1T7psBKsA6iEAtryIPeuAJhwIw+Nbduqxt
         WyBjzpgzDLRLGBgJn7NjNEKCpR53mSb9c29EBnEPnEIBJuKaJQVJGWl7HXnfJAuBa/cB
         Se+nhXe2WXw2unhDL5CcL58ZEr4ffRI3/T2y0MmBiF2OIs1QI7J0En9mUcZDBuD6dFjt
         x+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KgmyVLv0taPkfGvazsz6VG1X3fTSXx7HTwuS4sxsIEg=;
        b=OLdiWAN9gmIOVh3ehtWNjVN95KNgKGmsQGWzOjRsGntMeyk5h9a8lfAOmm17/Kwnx8
         omuI4mVosa5zhOtZaG5wBOS/lFYqYZmkHsB9trehFUCk+eaFDzLtahRfqA2hmoOIOSFw
         dXwVt4067RFw/kMu7Y3X1JFf/MMMEhiw0GzBgEK0lOVcu1J1RjmaODfMEyNL1lFGFLeB
         vBU1TDztI9uZ/Z0KI1GPsihINu3R28Em9ablq4sr7SaBWhJP4LlX+a7HJPAEeTWB4vBo
         480ajACRhqp9yICGZb9V/V8X1n8OvfDHlUMXrkDDW3UOGculUxTonrQOYlO5K7nSfpyv
         ppyg==
X-Gm-Message-State: ALyK8tIhIG/TGXRD/qIhTKnBWl9lyr8kW72E2V/17dCY0NwGVtpSz6PNjT0XTFVnAOM1Eg==
X-Received: by 10.28.145.21 with SMTP id t21mr14564421wmd.21.1465506651107;
        Thu, 09 Jun 2016 14:10:51 -0700 (PDT)
Received: from Frodo.railnet.train ([88.128.80.181])
        by smtp.gmail.com with ESMTPSA id c4sm8898309wjb.38.2016.06.09.14.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Jun 2016 14:10:48 -0700 (PDT)
X-Google-Original-From: Lars Vogel <Lars.Vogel@vogella.com>
X-Mailer: git-send-email 2.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296926>

This helps contributors (like me) using editors which automatically create ~ copies of the changed data

Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 05cb58a..13c7403 100644
--- a/.gitignore
+++ b/.gitignore
@@ -219,3 +219,4 @@
 *.pdb
 /Debug/
 /Release/
+*~
-- 
2.8.1
