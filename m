From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH v2] git.txt: add missing info about --git-dir command-line option
Date: Thu, 13 Dec 2012 18:57:19 +0100
Message-ID: <1355421439-14024-1-git-send-email-manlio.perillo@gmail.com>
Cc: Manlio Perillo <manlio.perillo@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 13 18:58:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjD31-0000uS-Mt
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 18:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab2LMR56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 12:57:58 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61504 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab2LMR55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2012 12:57:57 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1257847bkw.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gtBb2T3GvFXr/R+UyZ2bYKHg7EABXw6da5RZy9nigXk=;
        b=h14eyGKjd2tn6Tde+8fulmEyU0ZO3BCFrAMx05W/KZKvGGGcYER3H5aZKTinJOgBmt
         woDfIXK6yT4i+Ko82j23uHCL9+smThKClUvwhgtCE3JfOIJr05R4eUYU/d34OgKftixZ
         yscxWm/NRhf4FCMjosA0td/RkEfIDMZjvtGw8tEolNrjfzjkDg4mKzWKDjHUU15+dy5t
         eYwKEyvPBsrQENYNL/HzTK5fVKH4c/ewiqpzFAT2ieKh5mGaNBLJPCORrHHaXgWAF6SG
         fj4+y4hWbrUAUNmgJM4crm/o+sxjz7udSVEiI7ja4E5cEl7TAyAVeuPSC27tGCowBEu7
         yPkQ==
Received: by 10.204.146.6 with SMTP id f6mr1419825bkv.69.1355421476693;
        Thu, 13 Dec 2012 09:57:56 -0800 (PST)
Received: from synapsis.synapsis ([151.70.213.162])
        by mx.google.com with ESMTPS id i20sm2220451bkw.5.2012.12.13.09.57.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Dec 2012 09:57:55 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.19.g2021cc5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211459>

Unlike other environment variables (e.g. GIT_WORK_TREE,	GIT_NAMESPACE),
the Documentation/git.txt file did not mention that the GIT_DIR
environment variable can also be set using the --git-dir command line
option.

Signed-off-by: Manlio Perillo <manlio.perillo@gmail.com>
---
 Documentation/git.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e643683..60db292 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -650,6 +650,7 @@ git so take care if using Cogito etc.
 	If the 'GIT_DIR' environment variable is set then it
 	specifies a path to use instead of the default `.git`
 	for the base of the repository.
+	The '--git-dir' command-line option also sets this value.
 
 'GIT_WORK_TREE'::
 	Set the path to the working tree.  The value will not be
-- 
1.8.1.rc1.19.g2021cc5.dirty
