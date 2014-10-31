From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] configure.ac: quote AC_PREREQ in configure.ac
Date: Fri, 31 Oct 2014 07:17:26 -0700
Message-ID: <1414765046-15703-1-git-send-email-gitter.spiros@gmail.com>
Cc: jnareb@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 15:17:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkD1F-0001FH-7p
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 15:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759461AbaJaORd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 10:17:33 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61103 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759419AbaJaORc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 10:17:32 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so7749671pab.22
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 07:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CtXb8MCWGHz3FRyKXSm1Oi1y1XuI0F5XJp/NmEDW/Ys=;
        b=Z7h1kYlp/qW5tbLZWFTUMHbZBqs15bkfcU9hno5v18QEbnPJxm1PSJ2wGr6kiBp1f6
         wwBVg3ebomjVCM2Uyjvj5yMYASi0piVM8coJs8uRQ2kZU7YlirDQ66UzR6TpDZtxScPy
         zTSL4ex8vHeYuCaFUTVdMTV53N9eAuP+vNvDaC7xMScHrKe9s7CysdHZDKGYNdOnV9Yb
         A44TIf/MC4NgoTdYpwcbt8dQjkKewl8kyKVpHptZgbv9Y4iSI3hM+MjQorX024aZm9rB
         cgr6KZwHVr6c8G6TuimL7L4UoIVKARyV27F1umgleLIQRlB5Nj4yIUM5zUTIPs32tf79
         4jYQ==
X-Received: by 10.68.132.225 with SMTP id ox1mr24842229pbb.85.1414765052425;
        Fri, 31 Oct 2014 07:17:32 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id vf10sm10069947pbc.11.2014.10.31.07.17.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 31 Oct 2014 07:17:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a old bug autoupdate don't do it before autoconf v2.66

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6af9647..9f01999 100644
--- a/configure.ac
+++ b/configure.ac
@@ -141,7 +141,7 @@ fi
 
 ## Configure body starts here.
 
-AC_PREREQ(2.59)
+AC_PREREQ([2.59])
 AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
 
 AC_CONFIG_SRCDIR([git.c])
-- 
1.7.10.4
