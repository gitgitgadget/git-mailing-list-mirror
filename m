From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [PATCH 1/2] Add top-level maintainers file with email/canonical repository information
Date: Sun, 30 Dec 2012 13:18:54 -0500
Message-ID: <1356891535-5647-2-git-send-email-jason.k.holden.swdev@gmail.com>
References: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: gitster@pobox.com, paulus@samba.org,
	patthoyts@users.sourceforge.net,
	Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 19:43:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpNqe-0007Ce-Qj
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 19:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802Ab2L3Smf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 13:42:35 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:48897 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab2L3Sme (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 13:42:34 -0500
Received: by mail-vc0-f175.google.com with SMTP id fy7so12159392vcb.20
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JQa5SDW+CwQICEqw3BMlwTnxC35fRXNaWpEi1Vpl29U=;
        b=Vm0EHcjuTJ+a7HKp0Oak/L+xAeLCiRzsvs3Lic07vkIqmXg77lT+zTayfEdsfn98Kx
         IjyuOD4qS9LKY+Vz1AtlhESCSuG43eCnWp58789H6sSa2Tr/S4krLgsY7r73EXe6OKuN
         KbqN9xGijLoZIvcTaSm6Fi0JVaH3fLdnADdBlgmSinKxBcfqHCn11Z8HiIV2aCiM80uo
         NpAxBdPuZDtcv7xxbLl8tGhxbjtM1WATEoug0bQ6mztM5ogUOW8HCJIWw6yeF8aLShh/
         yuzTY75gK0NoJz4vVuabF52F7YngoQTysBYXZEvtBTuaS1Ccz5YVLwoO2KgSHEO1jujN
         6KUA==
X-Received: by 10.52.17.244 with SMTP id r20mr53048324vdd.29.1356891587482;
        Sun, 30 Dec 2012 10:19:47 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id a10sm34079005vez.10.2012.12.30.10.19.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2012 10:19:47 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
In-Reply-To: <1356891535-5647-1-git-send-email-jason.k.holden.swdev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212338>

Certain parts of git have a semi-formalized workflow for
incoming patches.  This file documents the maintainers, their area of
specialization, their email address, and their canonical repository against
which patches should be submitted.

Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 MAINTAINERS

diff --git a/MAINTAINERS b/MAINTAINERS
new file mode 100644
index 0000000..ed23b21
--- /dev/null
+++ b/MAINTAINERS
@@ -0,0 +1,17 @@
+Core Git/Overall Maintainer:
+ Junio C Hamano <gitster@pobox.com>
+ git://git.kernel.org/pub/scm/git/git.git
+
+
+The GUI's packaged with git (git-gui and gitk) are maintained 
+upstream of the core git repository.  Their contact information 
+and canonical repositories are below.  Patches to improve these utilities 
+should be made against the tree's referenced below
+
+gitk:
+ Paul Mackerras <paulus@samba.org>
+ git://ozlabs.org/~paulus/gitk
+
+git-gui:
+ Pat Thoyts <patthoyts@users.sourceforge.net>
+ git://repo.or.cz/git-gui
-- 
1.8.1.rc3.28.g0ab5d1f
