From: Sven van Haastregt <svenvh@gmail.com>
Subject: [PATCH] Documentation: fix version numbering
Date: Thu, 22 Jan 2015 19:32:33 +0000
Message-ID: <1421955153-14066-1-git-send-email-svenvh@gmail.com>
Cc: sandals@crustytoothpaste.net, Sven van Haastregt <svenvh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 20:32:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YENUu-0000bI-GX
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 20:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650AbbAVTcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 14:32:50 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:42000 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753464AbbAVTcr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 14:32:47 -0500
Received: by mail-wg0-f52.google.com with SMTP id y19so3624170wgg.11
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 11:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qYKxH6O1aMRUnTieLSa9HMZ9bGvkj7uQkmKWnleNsfo=;
        b=EVhz0umuuSVXRLJd0aKzAib77DTl9rgCnFGaEVkRae9jKalc2psKaHB56wEdJ7yKPS
         gBBz9qVIYW1h0RkEBY7NE7qQ0uO+vibyl3s1YhoXvAqyZ1lx5J+wQr0tDvlWA69HBSMM
         qylTcj4Q9ySSBti3CZdJQYu9LegtW7mm1KNG/PMqOqI1rhGYqQYlYzsy/4r60UAT5ogC
         YJ2/EjVHF+pSczW7aDZojkE8PV2Wga+rbXmBdOuIS9/A/SrJw/yOsAu7cRiCULSs9TnB
         ge3GZPHOVqlnAIHh5BNaQ852BHaqHYYho4Eoh31LRLgOhlaCEbVcjAFA/xcY4lCAogN2
         8h1w==
X-Received: by 10.194.63.206 with SMTP id i14mr6097615wjs.107.1421955166502;
        Thu, 22 Jan 2015 11:32:46 -0800 (PST)
Received: from localhost.localdomain ([87.114.78.52])
        by mx.google.com with ESMTPSA id fo15sm4261306wic.19.2015.01.22.11.32.45
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 11:32:45 -0800 (PST)
X-Mailer: git-send-email 2.2.2.1.g3bd9421
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262859>

Version numbers in asciidoc-generated content (such as man pages)
went missing as of da8a366 (Documentation: refactor common operations
into variables).  Fix by putting the underscore back in the variable
name.

Signed-off-by: Sven van Haastregt <svenvh@gmail.com>
---
 Documentation/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2f6b6aa..3e39e28 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -103,7 +103,7 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-agit-version=$(GIT_VERSION)
+		-agit_version=$(GIT_VERSION)
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
-- 
2.2.2
