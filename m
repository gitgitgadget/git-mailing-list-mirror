From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/2] post-receive-email example hook: fastforward should have been fast_forward
Date: Thu, 26 Apr 2007 22:35:39 +0100
Message-ID: <200704262235.39590.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 23:36:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBd9-0004d4-CM
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146AbXDZVfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755145AbXDZVfz
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:35:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbXDZVfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:35:54 -0400
Received: by ug-out-1314.google.com with SMTP id 44so702418uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 14:35:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=unZ9fKgLm1zcyWssBz2bsix6ea3d2WmLZ+3HRdSgpGH7mL9O9Vy8ze3jKI8DT7XRZ1uhJgViNuZU5fCZsqFG2sofdD3Sm2FKgBr8NTmbTLBrboItL0QnCs0LbvayC0JMXHjQWGv2zNWO6xpy3qr9OU9xdHRQQTmuCrhxFSoaupI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=c179YPz9cAP7+/G8iDoc1frUUErZr9OPdeO8TDhzyJ6KWUcUe5O7QUIHzsPNeqyRcCsShfRUUfb+zf8I5/2ZS+H4ELDb6VXtujNIfN910I8Ru4tZDKP+S+4LcDMIrjDBnouER3VXdA2ZtT6KNeYz8SJR73Pkm1pa7k5/7gRZGK4=
Received: by 10.67.71.15 with SMTP id y15mr2472293ugk.1177623353761;
        Thu, 26 Apr 2007 14:35:53 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id i39sm5826281ugd.2007.04.26.14.35.52;
        Thu, 26 Apr 2007 14:35:53 -0700 (PDT)
X-TUID: f5499ce3cfde8d22
X-UID: 304
X-Length: 985
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45664>

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 6516015..edb30f6 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -302,7 +302,7 @@ generate_update_branch_email()
 	# List all of the revisions that were removed by this update, in a fast forward
 	# update, this list will be empty, because rev-list O ^N is empty.  For a non
 	# fast forward, O ^N is the list of removed revisions
-	fastforward=""
+	fast_forward=""
 	rev=""
 	for rev in $(git rev-list $newrev..$oldrev)
 	do
-- 
1.5.2.rc0.704.gfe85
