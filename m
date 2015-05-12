From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: [PATCH 1/3] config.txt: Clarify allowTipSHA1InWant with camelCase
Date: Tue, 12 May 2015 23:14:23 +0200
Message-ID: <1431465265-18486-1-git-send-email-fredrik.medley@gmail.com>
References: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Dan Johnson <computerdruid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 23:14:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHVu-000370-R3
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:14:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbbELVOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:14:51 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34618 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbELVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:14:50 -0400
Received: by laat2 with SMTP id t2so15627721laa.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q4Nkn+F0po5Yvj9scas+m3tBcXYdMGv3aNcrEHAxr78=;
        b=vbDKiH/+gO8dP5oVOIRT8eHzhAX0AUXTVIWbQzOhTqjWznBU6EBJxQB66PzzbVN7eX
         +Yb05ssbPiHKT0dtZSQiifrT/XdadPqk+oaRB66CHK0Fps/NqWjl1F/EKVpIlIjm8kr3
         LYni0vXZ6UQ3f8CNzykwpmNkwhjlwwuyHs12PF1+BaXuIzSjmcx3aV/JvS8iSWz9sHcW
         aq5OAK96O1HvrdpL9/U+FhWCpdrVgJeD3SrD6f8eHuopq5n/RrzDmkduNxs/LBY0vUMy
         oB5qfPhObjTS8qhhj2VicF9uw/slyy8bxYvYXRCnG4c8WlmiTmSDSRTeYItFkT8vQYD4
         x2kw==
X-Received: by 10.112.147.73 with SMTP id ti9mr13633513lbb.108.1431465289119;
        Tue, 12 May 2015 14:14:49 -0700 (PDT)
Received: from localhost.localdomain (c83-252-232-146.bredband.comhem.se. [83.252.232.146])
        by mx.google.com with ESMTPSA id o8sm4242695lal.2.2015.05.12.14.14.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 May 2015 14:14:48 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <xmqqy4l1sblq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268885>

Most of the options in config.txt are camelCase. Improve the readability
for allowtipsha1inwant by changing to allowTipSHA1InWant.
---
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
