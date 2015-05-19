From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH 1/3] config.txt: clarify allowTipSHA1InWant with camelCase
Date: Tue, 19 May 2015 22:44:27 +0200
Message-ID: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
References: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 22:45:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuoOP-0005Om-AI
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 22:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbbESUpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 16:45:32 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:32786 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbESUpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 16:45:32 -0400
Received: by lagr1 with SMTP id r1so43172348lag.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+0FR8zn5liUDv66OcwpCNO3uIr0g0e5vDhx2uNkBnb4=;
        b=VFOHAuQyy5WdM9NXrVM193L12ZYyQFnjcGVSoPXy/X8ZTw8ol/WNoKx56bXzzKy/yR
         a/RML96c6y1nvhaDoEDcEx6gc1/drqH1G3cTcNAAxQb51gMOywpDgo2oeMXU4Lm0UfEb
         uAKjbZyzRA39pS1ZUq0uYrN7J+Cg6t79oP8k5gcYx3z9YAlUwPND9SSDJfJ0HCh7o1kZ
         G5N5tMvCvoQ0rNP30VuMdtQs8TpNPCxm7Rsd9nS1yS7LP9QNestRQ48NTXFX4aCXTpAK
         AuBHwPm8w5FXBXu51Jmz6WBVg3WiANFYVZc8GnogW7iSm9IZgseH1ys6ZOXZb5HrjnwF
         MGtw==
X-Received: by 10.152.22.34 with SMTP id a2mr23713271laf.59.1432068330312;
        Tue, 19 May 2015 13:45:30 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id ln6sm4002256lac.45.2015.05.19.13.45.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 May 2015 13:45:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <CAPig+cQe3=Y15+RBZCxry7-78kbNL6H0PfdYs=OV_DMifOWxaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269399>

Most of the options in config.txt are camelCase. Improve the readability
for allowtipsha1inwant by changing to allowTipSHA1InWant.

Signed-off-by: Fredrik Medley <fredrik.medley@gmail.com>
---
This patch is optional. There has been work on fixing the whole
Documentation/config.txt which has not been merged yet. When adding
allowReachableSHA1InWant later, it would be good to already have changed
to allowTipSHA1InWant.

 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2e5ceaf..2b86fe6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2530,9 +2530,9 @@ uploadpack.hideRefs::
 	are under the hierarchies listed on the value of this
 	variable is excluded, and is hidden from `git ls-remote`,
 	`git fetch`, etc.  An attempt to fetch a hidden ref by `git
-	fetch` will fail.  See also `uploadpack.allowtipsha1inwant`.
+	fetch` will fail.  See also `uploadpack.allowTipSHA1InWant`.
 
-uploadpack.allowtipsha1inwant::
+uploadpack.allowTipSHA1InWant::
 	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
 	to accept a fetch request that asks for an object at the tip
 	of a hidden ref (by default, such a request is rejected).
-- 
1.9.1
