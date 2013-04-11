From: Samuel Bronson <naesten@gmail.com>
Subject: [PATCH] git-cherry.txt: cross reference "git log --cherry"
Date: Thu, 11 Apr 2013 17:39:39 -0400
Message-ID: <5167369f.ea15340a.5e12.0282@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 12 00:18:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQPot-0003by-VP
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 00:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944Ab3DKWSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 18:18:11 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:42271 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab3DKWSK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 18:18:10 -0400
Received: by mail-vc0-f180.google.com with SMTP id m16so1697319vca.39
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 15:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:resent-message-id:resent-from:resent-date
         :resent-to:from:date:subject:to:x-rmail-attributes;
        bh=6z0hlt/mvH0hjVn1PPIXWkAFnF4VB7sDC4j+i9+nZaY=;
        b=tLR4zIe74wT1bdcErBJ5dMu8zdXcNz37pcdRWHPKKW3T2Qd4Lg4LwoWrIWU0OMFYrc
         fxchoCjmsja5bwyofobnyKtbRVS4wOgVTrmNGoh5RMy1VjQXg59tau3KpMpFk/L6Hz81
         watU5mcFjSnx7t+REk1DxyIbsrlJkN1oKC+FnuVaOOEKG9rdZImRmmAxN5Vq2d5I0RO0
         o8ycHtP+Sp8ANXHks7gqkzud6pRVjQQlLPyRFwi+pCBqld7NM9zTXqU1pDUGCnfpDTpz
         b62uiVRhZyowzlDaoV8aFj9O/JIyNCmCEACJyqQGnSQx4PY8jrTH2qpHfSvFc3I+J4CO
         blJw==
X-Received: by 10.52.23.205 with SMTP id o13mr5561631vdf.78.1365718689607;
        Thu, 11 Apr 2013 15:18:09 -0700 (PDT)
Received: from hydrogen (naesten-pt.tunnel.tserv4.nyc4.ipv6.he.net. [2001:470:1f06:57::2])
        by mx.google.com with ESMTPS id y10sm6098420vde.0.2013.04.11.15.18.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 15:18:07 -0700 (PDT)
Received: from naesten by hydrogen with local (Exim 4.80)
	(envelope-from <naesten@gmail.com>)
	id 1UQPoi-0003jV-QA
	for git@vger.kernel.org; Thu, 11 Apr 2013 18:18:04 -0400
X-RMAIL-ATTRIBUTES: --------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220935>

I learned of "git cherry" some days ago, but only learned of --cherry
and related options to "git log" today (more-or-less by chance).

If the git-cherry(1) manpage had mentioned --cherry, I would have
learned of these options sooner.

Signed-off-by: Samuel Bronson <naesten@gmail.com>
---
 Documentation/git-cherry.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index f6c19c7..076fe68 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -62,7 +62,8 @@ OPTIONS
 
 SEE ALSO
 --------
-linkgit:git-patch-id[1]
+linkgit:git-patch-id[1],
+the `--cherry` option to linkgit:git-log[1]
 
 GIT
 ---
-- 
1.8.2.1
