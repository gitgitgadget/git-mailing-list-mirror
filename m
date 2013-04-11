From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] RelNotes: few typofixes in notes for recent releases
Date: Thu, 11 Apr 2013 19:21:51 +0200
Message-ID: <5677389039f3fdaf86409cefce54c5fef1855545.1365699399.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 19:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLCg-0004M2-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab3DKRW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 13:22:26 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:59465 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841Ab3DKRWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:22:25 -0400
Received: by mail-ee0-f43.google.com with SMTP id e50so898960eek.2
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 10:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=bmF4PX3s6gCmewf/N9RxkFNh4TvrzY6wjcv8cb/fVnY=;
        b=p3gP99+W1OPfyJr/IUkBkf0I1NEiI1iroHSa9N7ioh6cM8ahFdUAcwc7JWj7/EGc2H
         csErunsHkTjo1SKeRnRQ00ueYL/ECu9JrfwNf03yUmaDmRIAFwaWjDVyRFx7hBgcMneP
         gNCG/PJop0P54khbfpnKtWgU3yIBNi00tvTIy8MwwWm91dgonz4naBN0U2FH6/FyY62m
         aQvL5Uz6bAzi/aZrdTJ2XyhfrAPv1Ht5EmbzffXT5QA9da3Gsb6TgfAQKOAAZ7XIY8aI
         2/kzcxJ9fHgEalRm2lfiz8ELcxBKlIcYLRPV2VY82xFeG4h2Mi0/XzU3fpzfHs7eBBRz
         YFnw==
X-Received: by 10.14.110.198 with SMTP id u46mr18464704eeg.41.1365700944293;
        Thu, 11 Apr 2013 10:22:24 -0700 (PDT)
Received: from localhost.localdomain (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id cd3sm6714322eeb.6.2013.04.11.10.22.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 10:22:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.373.g961c512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220895>

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Documentation/RelNotes/1.8.2.1.txt | 2 +-
 Documentation/RelNotes/1.8.3.txt   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/RelNotes/1.8.2.1.txt b/Documentation/RelNotes/1.8.2.1.txt
index 1354ad0..769a6fc 100644
--- a/Documentation/RelNotes/1.8.2.1.txt
+++ b/Documentation/RelNotes/1.8.2.1.txt
@@ -49,7 +49,7 @@ Fixes since v1.8.2
    common prefix and suffix between the two filenames overlapped.
 
  * "git submodule update", when recursed into sub-submodules, did not
-   acccumulate the prefix paths.
+   accumulate the prefix paths.
 
  * "git am $maildir/" applied messages in an unexpected order; sort
    filenames read from the maildir/ in a way that is more likely to
diff --git a/Documentation/RelNotes/1.8.3.txt b/Documentation/RelNotes/1.8.3.txt
index ca76a2b..537fc7a 100644
--- a/Documentation/RelNotes/1.8.3.txt
+++ b/Documentation/RelNotes/1.8.3.txt
@@ -41,11 +41,11 @@ UI, Workflows & Features
    revert session, just like it does for a cherry-pick and a bisect
    session.
 
- * The handing by "git branch --set-upstream-to" against various forms
-   of errorneous inputs was suboptimal and has been improved.
+ * The handling by "git branch --set-upstream-to" against various forms
+   of erroneous inputs was suboptimal and has been improved.
 
  * When the interactive access to git-shell is not enabled, it issues
-   a message meant to help the system admininstrator to enable it.
+   a message meant to help the system administrator to enable it.
    An explicit way to help the end users who connect to the service by
    issuing custom messages to refuse such an access has been added.
 
@@ -294,4 +294,4 @@ details).
    alphabetical order.
 
  * "git submodule update", when recursed into sub-submodules, did not
-   acccumulate the prefix paths.
+   accumulate the prefix paths.
-- 
1.8.2.373.g961c512
