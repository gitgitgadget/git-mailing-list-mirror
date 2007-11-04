From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Remove a couple of duplicated include
Date: Sun, 4 Nov 2007 15:35:26 +0100
Message-ID: <e5bfff550711040635v3f95709ck3bd2aab62e575f7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:35:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IogZj-00023W-WE
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755576AbXKDOf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755305AbXKDOf1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:35:27 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:21123 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143AbXKDOf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:35:26 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1270254rvb
        for <git@vger.kernel.org>; Sun, 04 Nov 2007 06:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=3F5//fUYRiSFrR4AQVmxfNf/4jumOfIxOv12FwuIjJ4=;
        b=rFR0zhr8t+mHkUXpohXfpwJlSSMD+DUQvO8n/KCdEymKBded3IlkZJ0mIM+XlTumqZIx2yIBfo33JzYbgBxpy05x2WJvX2JLIQt69YA31K6Vh7kCcO5rHX6iIa/qvX2MCXcRz8FY6Ib8cE07EMHSU5SmKuhTwXeCYB78YqDdYk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G2Rtgqfq3gR6Xgx641xlPyRTXw1YUMuipEtEnVoaKjEhtE2FT1Ps1wi5P38Q+k96IPM0zpT6uqKEFsztkL33NTpgsje6C4vQK+zPdNJUhNtD7INtCoBpuuCTyt9Ec5TT7Avspql76HUtMGjp3cpaEP6Zs+tNaeviHey6smLkmhs=
Received: by 10.141.86.14 with SMTP id o14mr1863865rvl.1194186926056;
        Sun, 04 Nov 2007 06:35:26 -0800 (PST)
Received: by 10.141.203.3 with HTTP; Sun, 4 Nov 2007 06:35:26 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63410>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 compat/inet_ntop.c |    1 -
 compat/inet_pton.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
index 4d7ab9d..f444982 100644
--- a/compat/inet_ntop.c
+++ b/compat/inet_ntop.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <stdio.h>
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
index 5704e0d..4078fc0 100644
--- a/compat/inet_pton.c
+++ b/compat/inet_pton.c
@@ -18,7 +18,6 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <stdio.h>
-- 
1.5.3.5.532.g5c38-dirty
