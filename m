From: Martin Amdisen <martin.amdisen@praqma.com>
Subject: [PATCH] Fix minor typo in hook documentation
Date: Thu, 25 Feb 2016 09:10:12 +0100
Message-ID: <CACbrkToX7zE0sqynOuN5i_Ytoui1h8pb3+cLKPntymdaVG+pAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 09:10:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYr09-0001z6-RI
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 09:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759140AbcBYIKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 03:10:15 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:33313 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbcBYIKN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 03:10:13 -0500
Received: by mail-io0-f182.google.com with SMTP id z135so81296322iof.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 00:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=praqma-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=QfNN6rsP9yO/g6B1N/coGB/tIGLwuguBmJfLwfCUSwc=;
        b=AL3wE0V2ShkkGtvmxO082e+h4LvFgLmxeYMNyOLtxVamaEbGoYZZAV8LtDDJkbEHwl
         evqGCe7GU2FljimZ92yV7Yleftre0wObS/8WD8I+/HuOQ9gMtsSTParsnAg0NUYDSKa5
         uEyToSxFjInokYh859dii1tX/n4CfA6G1we9299ipzLo3aAIZRQ24EDdsg9iuq0PLULE
         EhzMGWzmzIJeSYCEBlYxTmv5VT3xfPiunP9x59Eneor2Z98CBXRklA0rTIsxp17hCxK8
         tPn4iSK/AdVA+2PgK1aVuwJYVVOHAAaLijf5dSMKBxX8rALH9dvbXiJ7RwwPPr/2cnGt
         IdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=QfNN6rsP9yO/g6B1N/coGB/tIGLwuguBmJfLwfCUSwc=;
        b=C3zJGhvW3LJxRWrDJKlQ4dFK+SR6gzWTohN4Y6iyUV1LouYdNKw+dEOFaX8cjQDNBg
         FX1P9PWxHaqO7oi4yAcc/tU3mK+POslzUZsEohoWqH515aQEeS8Mk06qWe8SiF3V3Sos
         JztA2Ug0gdmSsbY8aovmAkt3Law3OYQajTmQ5ZsPsj+8use5JB8r2XuskTEJAPz2Uuzo
         rdoRdMDCkyyGpbnL7wRImpp+TFL8zoseD1h8awuDRebatZSYBL9nuRVZAOPk/Cezoa18
         ZuGVrvmqjGF3elRldvQEwFy6xi0TrrEFcwt8zrlWQjVrHxWP5Qv6WpKnNLx0ZmCGudEm
         mnTg==
X-Gm-Message-State: AG10YOScM+0Jp0fZTWAkW7zNsa31q+zOqe9TgReKpbmt6q3GZlFRn9Y9ITCN65Cpp/XSYux+Ctbfrf+7F5tvIg==
X-Received: by 10.107.186.87 with SMTP id k84mr1891989iof.91.1456387812693;
 Thu, 25 Feb 2016 00:10:12 -0800 (PST)
Received: by 10.79.25.4 with HTTP; Thu, 25 Feb 2016 00:10:12 -0800 (PST)
X-Google-Sender-Auth: JMcq8mRHnOwVYCE0ynMpiXzGJM8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287338>

Signed-off-by: Martin Mosegaard Amdisen <martin.amdisen@praqma.com>
---
 templates/hooks--update.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index d847583..80ba941 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# An example hook script to blocks unannotated tags from entering.
+# An example hook script to block unannotated tags from entering.
 # Called by "git receive-pack" with arguments: refname sha1-old sha1-new
 #
 # To enable this hook, rename this file to "update".
--
2.6.4
