From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] ls-remote: document the '--get-url' option
Date: Thu,  6 Sep 2012 19:27:21 +0200
Message-ID: <1346952441-20666-1-git-send-email-stefan.naewe@gmail.com>
Cc: gitster@pobox.com, Stefan Naewe <stefan.naewe@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 19:27:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9frj-0001Zk-38
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 19:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475Ab2IFR1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 13:27:35 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47356 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173Ab2IFR1e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 13:27:34 -0400
Received: by bkwj10 with SMTP id j10so964746bkw.19
        for <git@vger.kernel.org>; Thu, 06 Sep 2012 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Kl/2iFED7E29HJVsgpBxldnjinTJLKctebP+5Hb04Zg=;
        b=zQuriSS7QZzUnztGMuPdkpHQrhqqJKTbRDdS3IypUX2Shgz8P1tuQthsTbIY4b053h
         4i5P5Me53MV6sE1O/unP+Puvk0w8Uz7JhSDoW/Dq3TbjzhtmgNzIPSscLZjfYFvdoEif
         5h4LYmmCx95UIdGV2SkG/3Vv60Cs+OwH3/2C0fbdHAT2zw902wDj9el91CM4IBRPM+PQ
         sjLfu8awSHFBmQcVBDcdrF/WK0uBHihHGkrP2W5lNknZT0U6mqQWVPUcQ78WUmprarA2
         tBpIgd3/pK5BgRaJ/LbU//vlaxN/RG2YyIZnlWVHGWEBjXfBfq9B7e6VuTjvVAMup0xh
         5l0Q==
Received: by 10.204.133.193 with SMTP id g1mr1518772bkt.2.1346952453110;
        Thu, 06 Sep 2012 10:27:33 -0700 (PDT)
Received: from darkstar.home (dslc-082-083-206-112.pools.arcor-ip.net. [82.83.206.112])
        by mx.google.com with ESMTPS id hs2sm1886926bkc.1.2012.09.06.10.27.28
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Sep 2012 10:27:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204905>

While looking for a way to expand the URL of a remote
that uses a 'url.<name>.insteadOf' config option I stumbled
over the undocumented '--get-url' option of 'git ls-remote'.
This adds some minimum documentation for that option.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
 Documentation/git-ls-remote.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 7a9b86a..5819ead 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -42,6 +42,10 @@ OPTIONS
 	it successfully talked with the remote repository, whether it
 	found any matching refs.
 
+--get-url::
+	Expand the URL of the given remote repository taking into account any 
+	"url.<base>.insteadOf" config setting (See linkgit:git-config[1]).
+
 <repository>::
 	Location of the repository.  The shorthand defined in
 	$GIT_DIR/branches/ can be used. Use "." (dot) to list references in
-- 
1.7.12
