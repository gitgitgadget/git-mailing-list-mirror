From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 1/2] Documentation: config: improve word ordering for http.cookieFile
Date: Fri, 29 Apr 2016 00:23:56 -0600
Message-ID: <20160429062357.12647-1-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:25:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw1rR-0007X3-Jg
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 08:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbcD2GY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 02:24:58 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33122 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbcD2GY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 02:24:58 -0400
Received: by mail-pf0-f181.google.com with SMTP id 206so44129451pfu.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=AxFiguQFEI1rt0uF4KWUZLhT8/5D0ryGd9G0s3ZbI5w=;
        b=h1EJ+MobfIZK9SAXVBLm0vhYT55aNzLBI4r499vM5siCpjp3K+kGOvzasCOQdc4JDD
         M6VLOO8mor7LY4k+atQ/W4oymEcJJ2QMDTNPgd2ozfgVJgMJ0O8nytp7M3FRES2tOva5
         pVZdumGGX1X9/z1PXnrEUzLeZeQ59Cc0OcAkvBat6U6pJ3VTXvSXmskU478XjWQ6gHf1
         kJ/bfUuDY9FEcvJYXoyWfsI81kZSBLWdsiKUu/Y8xLqegLR2SmyH+8Gc54hDiH2gNnOF
         wF3WOTtaz8de33mM5OXSbLc/3P7cT38qYI9AIi/D2LGWXYGTc7MXkVMLoWiTZiuZUWmQ
         y9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AxFiguQFEI1rt0uF4KWUZLhT8/5D0ryGd9G0s3ZbI5w=;
        b=ZWkPBkdCndpF9mDaCmibEldWDxnwVHqL1k57g1HkioHYpzl0BZEXu4J6gF1pfW9N49
         GW2PE4so3r+2Pl9A9LcZCGDAunVkjiR3sPtVahB8H3ZgQDPYZbUYzbO6F16S1j0qaN8C
         iOegQ/wg3k/xaBOfYT0aIgfCKbeCbEkswE6YciVbIopFnLAV7RegK19HzDy2Ee6vGEy9
         jyDIOyUCo7ISY8PXYjWQQXmccUzA7yaKHai+tbEndar/v3LISxx4xmS5XTiFzH9wQE5Y
         j4ziLGL/8NicRb5UCzdaL5viHz4Jy4DEpTNroE2z4TTE5b1+V8uaNg8ATCoLwVz/041d
         I/vA==
X-Gm-Message-State: AOPr4FWoklJLjxAXFQu3oxES5P/X34oww87H4Djz1rhrwWnZ9REdPv35DyZu7dg/VccQoQ==
X-Received: by 10.98.100.77 with SMTP id y74mr26580668pfb.101.1461911097318;
        Thu, 28 Apr 2016 23:24:57 -0700 (PDT)
Received: from briannorris-glaptop2.roam.corp.google.com ([66.232.90.194])
        by smtp.gmail.com with ESMTPSA id a64sm20044853pfa.6.2016.04.28.23.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Apr 2016 23:24:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.340.g018a5d0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292969>

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 42d2b50477b2..a775ad885a76 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1660,7 +1660,7 @@ http.cookieFile::
 	in the Git http session, if they match the server. The file format
 	of the file to read cookies from should be plain HTTP headers or
 	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
-	NOTE that the file specified with http.cookieFile is only used as
+	NOTE that the file specified with http.cookieFile is used only as
 	input unless http.saveCookies is set.
 
 http.saveCookies::
-- 
2.8.1.340.g018a5d0.dirty
