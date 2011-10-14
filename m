From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/3] git-gui: fix unintended line break in message string
Date: Fri, 14 Oct 2011 21:25:19 +0200
Message-ID: <0f862de296a94b06495e4418bc731b5d201d5767.1318620267.git.bert.wesarg@googlemail.com>
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:25:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REnNr-0002P3-Bj
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab1JNTZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:25:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59108 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab1JNTZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 15:25:26 -0400
Received: by bkbzt19 with SMTP id zt19so353915bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 12:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=tbySYLq9zI9Q83Gi/5pH2izhnUPRwBofvlwZhjY0a+w=;
        b=b/7jCOjPIbZ+tx4lJ8Bnu/FVxpYLlF543FhEWhodlAv8eYzitHFVZLzDdXlu3BwmL6
         sNht1ultPxCxSPZAsQg9rh9/tyuF9EHj5Lb3s3yY+qxK00opDO3DsVcujxajHI0HGHZj
         eL3rSB77jhz/eqy+m+mPE5QydUpal6omz3Xf8=
Received: by 10.204.132.199 with SMTP id c7mr7865683bkt.45.1318620325270;
        Fri, 14 Oct 2011 12:25:25 -0700 (PDT)
Received: from localhost (p5B2AD5F0.dip.t-dialin.net. [91.42.213.240])
        by mx.google.com with ESMTPS id u10sm9419825bkv.3.2011.10.14.12.25.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 12:25:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183600>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

Probably because of a white-space damaged patch.
---
 lib/index.tcl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index e38b647..3a9c8b7 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -367,8 +367,7 @@ proc do_add_all {} {
 		}
 	}
 	if {[llength $unknown_paths]} {
-		set reply [ask_popup [mc "There are unknown files do you also want
-to stage those?"]]
+		set reply [ask_popup [mc "There are unknown files do you also want to stage those?"]]
 		if {$reply} {
 			set paths [concat $paths $unknown_paths]
 		}
-- 
1.7.6.789.gb4599
