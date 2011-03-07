From: Namhyung Kim <namhyung@gmail.com>
Subject: [PATCH] gitignore: ignore GNU GLOBAL tag files
Date: Mon,  7 Mar 2011 13:49:09 +0900
Message-ID: <1299473349-6248-1-git-send-email-namhyung@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 05:49:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwSNs-0006He-AR
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 05:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab1CGEtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 23:49:13 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33895 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab1CGEtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 23:49:13 -0500
Received: by pvg12 with SMTP id 12so664673pvg.19
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 20:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=m8FNbhkU895fuGyAJI4hfSwrRol/CsOh9CNq2nz7XdI=;
        b=eckXj5L2ogyFI4ZecbUlNlhdInbdk/jOABK3Z5eA1NrnyjKc6GneRqtDBkcHy4D2E9
         Y1tUBlLYhanZEzaeB6oQbBXiV+FMhgblAvxpe/FyKbn0NBK8G0TM0YHidnlWvzSVWbIt
         d7S+ji+PTdAZ0NFv9+KwbWwPFevX86uOJX0yM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NL9QCkYCLR9AYzEi1mdnuISiTMuwOShxo6zi/ntczE0tcLZXdMibQtbI7KZyNdaMG1
         hawOBL1bypAKHnz7hQWZc3By+K+LvJfRRHtYnyLkzAWdpYdGzqC/riOM+OdimsluwKnQ
         pOw4dDEC9T80aCTsAuAXiw1tlOA97j5BoD5tA=
Received: by 10.143.27.36 with SMTP id e36mr2976095wfj.189.1299473352559;
        Sun, 06 Mar 2011 20:49:12 -0800 (PST)
Received: from localhost.localdomain ([118.176.73.109])
        by mx.google.com with ESMTPS id z8sm3840070wfj.1.2011.03.06.20.49.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 20:49:12 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168569>

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 .gitignore |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index c460c66766a..cec14c5f48d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -207,6 +207,10 @@
 /configure
 /tags
 /TAGS
+/GTAGS
+/GRTAGS
+/GPATH
+/GSYMS
 /cscope*
 *.obj
 *.lib
-- 
1.7.4
