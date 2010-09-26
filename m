From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 1/3] gitweb/Makefile: Include gitweb/config.mak
Date: Sun, 26 Sep 2010 15:02:24 +0200
Message-ID: <1285506146-8009-2-git-send-email-jnareb@gmail.com>
References: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 26 15:11:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozr0n-0001r2-BK
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 15:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab0IZNLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 09:11:03 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33662 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757423Ab0IZNLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 09:11:01 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2792344bwz.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yKADLadfHz3OtR/FUVTFZp9+1ofOeSEsPnJt7gnqBFk=;
        b=XNBjQ2WKGPqllHDdmwg02Y9IipddinW3NjPoJK6gC95pIoNAhnCScW2qmak0CvnaJh
         rACMsysDnmTKBTndzGWrKzw4S7hMCa3K6ZmWgnKSy2FizQBRIhOTdT+eN0GCA/pce217
         04xQcv7b14yQ9rxWgA8KD7T19fj01xaqB/QyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t4vJDcLgh7Hy1O4e+38g2LsZnrtmIFhzKf5iQojqGOlknehD3bRX48U6vo18Vna+2i
         XKN1Q0wrPAElE9D9KiY7G4OVN916VoetKLS1nCpdZPhQ/4sWOIePCybBYGpWkD4pX+/C
         9rpYO4tVfeWGkO5lR5iyVlP1kTUMaaxolKU9c=
Received: by 10.204.69.18 with SMTP id x18mr4214267bki.34.1285506660611;
        Sun, 26 Sep 2010 06:11:00 -0700 (PDT)
Received: from localhost.localdomain (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id x13sm3388546bki.0.2010.09.26.06.10.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 06:10:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1285506146-8009-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157223>

Allow for gitweb-specific Makefile config to reside in config.mak file
in the 'gitweb/' subdirectory.  This means that gitweb-specific
build-time configuration variable can reside in gitweb-specific
gitweb/config.mak

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
No longer RFC, but it can still be safely dropped from this series.

 gitweb/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 2fb7c2d..88bcf08 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -39,6 +39,7 @@ GITWEB_SITE_FOOTER =
 # include user config
 -include ../config.mak.autogen
 -include ../config.mak
+-include config.mak
 
 # determine version
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
-- 
1.7.3
