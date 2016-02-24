From: Martin Amdisen <martin.amdisen@praqma.com>
Subject: [PATCH] Fix minor typo in hook documentation
Date: Wed, 24 Feb 2016 13:51:02 +0100
Message-ID: <CACbrkTpA5qL1aTLGG1ypX06fuyFY4GdMAa4JfjoJnGWp_=WaAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 13:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYYuQ-0003bR-DY
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 13:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbcBXMvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 07:51:05 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:33365 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbcBXMvD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 07:51:03 -0500
Received: by mail-io0-f173.google.com with SMTP id z135so36393132iof.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 04:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=praqma-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=xjX4OXioYZT2cm2iGIXBeUu0h5sYT18Ylz3Ca0ZC3Ys=;
        b=CR2wDfA6BM6l5nq5K9uGwJKiFGuJidCJFPrIaWyv1SujGv2MgxT8LPlHaqgrTX3PJc
         sUmw7Ex6KUApA7G6bA4x87ZIoGShPIZCMsxun3CFiGxuMqjJIq1KGQpDKTfWdVM6L7YI
         pU4sHXH0P34e/1qDU55SePxbBhj4PdaZn5iuiBm4Dp/LmyK6a53ow0irxokvoWFf6r2T
         ESPzgozAk088+bGvLZJOJVxgudZNGcEvsO5i5pISzfb++pFnB4YmNEhpJsVRhV/qv3fO
         IDSAUDoAGJRZKud17mlCceToUePimkEBmFa55oBYs1PvrdN1GI8I1kd8R03joM8dDESF
         af0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to:content-type;
        bh=xjX4OXioYZT2cm2iGIXBeUu0h5sYT18Ylz3Ca0ZC3Ys=;
        b=HXfg6/Audjl9EDeBhDNbTcSLxp4hBJwrwxZVzISwC11oSJ6P3mVvF3fkKre73yyTB6
         j86vMKZw00nsnTqwMzrtaKW/E8b8YqNNOtQ+j7w5Jo+CPYywiXCTr7CF8D8K2KFUwU1W
         fXqOOFe2GMqK2Uppi0huVbm3e7LDvA5eS/M4zZu7HXRAAj623oYdYzpbid/7IVFMjXiV
         zNnAm61whzK+TnyoxThlO0TWw1nCah9x58tS17ROjpYcYlyelYE5T6gKwzlIfFvprEuu
         g+flyeV0P8NnY2VfTLioegQbjUIwZK8Iz1i2FJ7M4/9LxitaGJrPam0rp+N0L0vGAD//
         q8JQ==
X-Gm-Message-State: AG10YORocRoOg7wvswELtw1DjoRkBB9m4CwUQHDUgilhmsxj4c5ytJ/JIVVdpSVETMUFfM5R9yhDk52tvI22BQ==
X-Received: by 10.107.13.65 with SMTP id 62mr39413125ion.186.1456318262389;
 Wed, 24 Feb 2016 04:51:02 -0800 (PST)
Received: by 10.79.25.4 with HTTP; Wed, 24 Feb 2016 04:51:02 -0800 (PST)
X-Google-Sender-Auth: DUPCAsKWipc0DH-ezxyVZn5un-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287205>

>From 3f8fd9e5771791a18e89fdb1f1a681eb6fc66ad1 Mon Sep 17 00:00:00 2001
From: Martin Mosegaard Amdisen <martin.amdisen@praqma.com>
Date: Wed, 24 Feb 2016 08:43:07 +0100
Subject: [PATCH] Fix minor typo in hook documentation

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
