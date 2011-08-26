From: pangyanhan@gmail.com
Subject: [PATCH] Documentation/show-ref: correct order of --heads and --tags
Date: Fri, 26 Aug 2011 10:26:16 +0800
Message-ID: <1314325576-1574-1-git-send-email-pangyanhan@gmail.com>
Cc: Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 04:26:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwm7s-0000UF-Sv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 04:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab1HZC02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 22:26:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34772 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850Ab1HZC02 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 22:26:28 -0400
Received: by gwaa12 with SMTP id a12so2350098gwa.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 19:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=C5Wxm5aCyW5mfGRTV9bzd7SMbZxaEhjlZu52OoYnbD8=;
        b=QoT80TMfNdNkFlXOMV9aw1Mu0Tve1dTpXENITftgOAd49WGAGa8mZNzti4DeTYX9hE
         qF8+WLcBxGKFi61pFWv361Iua8Dp9hLQAU37rR5rrs0JfITIaTnaqeUrSCetjtvANdrI
         jaTlcoEZbFm9PsB+ntiyuPTjSGInmvdxQ4Pq0=
Received: by 10.236.189.100 with SMTP id b64mr3154265yhn.42.1314325587315;
        Thu, 25 Aug 2011 19:26:27 -0700 (PDT)
Received: from localhost (nusnet-228-5.dynip.nus.edu.sg [137.132.228.5])
        by mx.google.com with ESMTPS id s62sm1581063yhn.5.2011.08.25.19.26.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Aug 2011 19:26:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180146>

From: Pang Yan Han <pangyanhan@gmail.com>

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 Documentation/git-show-ref.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 3c45895..5a646e4 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -34,8 +34,8 @@ OPTIONS
 
 	Show the HEAD reference.
 
---tags::
 --heads::
+--tags::
 
 	Limit to only "refs/heads" and "refs/tags", respectively.  These
 	options are not mutually exclusive; when given both, references stored
-- 
1.7.6
