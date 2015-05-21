From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH v5 1/3] config.txt: clarify allowTipSHA1InWant with camelCase
Date: Thu, 21 May 2015 22:23:37 +0200
Message-ID: <1432239819-21794-1-git-send-email-fredrik.medley@gmail.com>
References: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 22:28:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvX4V-0001En-34
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbbEUU17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:27:59 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36032 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347AbbEUUYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:24:03 -0400
Received: by lagv1 with SMTP id v1so111587485lag.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XF8PrRQIWdIwOrx6FhXC0BHuE39Z98e8h7xaVjteu+M=;
        b=zBl6cyAl/HmoSDOdo2wWRfpEy6eJ38JGrVBe9BWjrFz4trWsDMNaRCB08YFScThbCI
         2t4WdkKlMsJZ5RF/ZuuvjllW2TIFezzyotDftMDicJL8nalt0TUSi1tbqgttI4ikDxlD
         8dGbk+ZSprHS4rf9DyZNb8shYJ8DcostibZeJAiLCkNBnZi/SctYH/VmY7cZ9zxkcp6k
         oXE4glRnXM/XcRNMv9U7EldipSkelV5xTdX+HNeZhHC7WF9KpNlhG6OF0Ps8fFuC1lF7
         F6kfnDlZhbKfZGd9/aLZFI+clD6LAa7qfi0RvVsO+u6YZ0SlW8m3qMCocNAIJM+0bvGd
         lxrA==
X-Received: by 10.152.28.97 with SMTP id a1mr3709521lah.9.1432239841212;
        Thu, 21 May 2015 13:24:01 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id ba4sm5500565lab.31.2015.05.21.13.24.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 13:24:00 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432068269-14895-1-git-send-email-fredrik.medley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269656>

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
index 948b8b0..1311383 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2539,9 +2539,9 @@ uploadpack.hideRefs::
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
