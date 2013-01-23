From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Ignore gitk-wish buildproduct
Date: Wed, 23 Jan 2013 19:55:40 +0100
Message-ID: <1358967340-3642-1-git-send-email-hjemli@gmail.com>
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 23 19:56:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty5Ue-00039Y-St
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:56:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab3AWSzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:55:51 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:42533 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab3AWSzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:55:49 -0500
Received: by mail-la0-f41.google.com with SMTP id fo12so3685699lab.28
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=HerUdqI5KHsWU9owWuYCBSF848t1xeiAvPtLceSadIg=;
        b=VhD5oxUs3SsVLkfby4X1jKKT+avQ3gUGDAoqYpnWuIFIN9rVq6VCVrJcoH1+ICzWQv
         JLEz9HjCuX0mORHsz85CcoNAD4wfrb7mxTINRyb/EdlEg/Y4VyIF1Y6Al50r/Zd/f2DI
         yCOu9uctQjpImXH9iXrBQJTjt5sDQldF/qwNhkcTsVJqzRxp6E+E1qeTHpUZIwUEbsSz
         K0BLfETdc9rf3hqq6M4um7OUSwC6XEfgB4M56UgvUX5ZHlvKFyrAtohq74TG+w2At5lG
         +J8Hc6FZkCTS/koGxDw+VcwUUh+5P5yjaze+M5O6r5FPSkYSrp9vgnMU34Oi5aSHNZen
         Sy+g==
X-Received: by 10.112.83.133 with SMTP id q5mr1150393lby.40.1358967347820;
        Wed, 23 Jan 2013 10:55:47 -0800 (PST)
Received: from slacko.getinternet.no (cm-84.212.47.55.getinternet.no. [84.212.47.55])
        by mx.google.com with ESMTPS id ft8sm8758858lab.9.2013.01.23.10.55.46
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 10:55:47 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.296.g725455c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214345>

After running `make` on latest master, gitk-git/gitk-wish shows up as
untracked. This fixes it.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>

---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index aa258a6..63d4904 100644
--- a/.gitignore
+++ b/.gitignore
@@ -171,6 +171,7 @@
 /git-whatchanged
 /git-write-tree
 /git-core-*/?*
+/gitk-git/gitk-wish
 /gitweb/GITWEB-BUILD-OPTIONS
 /gitweb/gitweb.cgi
 /gitweb/static/gitweb.js
-- 
1.8.1.1.296.g725455c
