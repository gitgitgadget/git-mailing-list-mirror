From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 2/2] Documentation/diff-options: reword description of --submodule option
Date: Tue, 13 Mar 2012 15:00:51 -0400
Message-ID: <1331665251-11147-2-git-send-email-tim.henigan@gmail.com>
References: <1331665251-11147-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 13 20:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7WyC-0008RM-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 20:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758815Ab2CMTBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 15:01:09 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:36268 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758691Ab2CMTBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 15:01:08 -0400
X-Greylist: delayed 4478 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2012 15:01:07 EDT
Received: by faas1 with SMTP id s1so247314faa.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 12:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=12K4oGhZJWeKh+aDFVQ6HmAZI4zlO+CYG7XY1hHZyhA=;
        b=B2yfnOcwi+8yYb6GedIvEn3QkBzcpX97enLWgksGu75+krM4xuG0GHBTbUpM0lhKld
         Njb1jAmGFdUHQzU/gF/3F81LQNLMSLSf3g/h4wwNVXsMoXgpFbWK3u5pHzJBjCyuM8dh
         iI7ufpZ2X3tjmgT70Lsvtg3s1y9V5Fu8xb/YcX3GAKGF5fcJUpkZKEUpoboXDCqhfJ+I
         BgDHhp8fUHShiEwUv9JiV1bGy/ZXjx8smlbKk/2tvuPAtG69qpjBvkI2E9aDT1zXHQug
         d6gDLpraQslHZXcbweQt9Q/oTLndIlMli8hhYR3tIIanH5DFDjYuygjUkdu/ZyQah0i0
         Wg+Q==
Received: by 10.224.184.203 with SMTP id cl11mr11437911qab.27.1331665266109;
        Tue, 13 Mar 2012 12:01:06 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id j17sm4758156qaj.9.2012.03.13.12.01.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 12:01:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0
In-Reply-To: <1331665251-11147-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193058>

The previous description was a bit confusing.  This rewrite makes it
easier to understand.

It should be noted that even though 'log' is listed as the default
format, it is not used when the '--submodule' option is missing. This
means that the output of:
   'git diff'             matches 'git diff --submodule=short'
   'git diff --submodule' matches 'git diff --submodule=log'

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Resent due to a typo in the developer list email address.

I will understand if this change is rejected, but I found the current
description difficult to follow the first couple times I read it.

 Documentation/diff-options.txt |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f44f3fc..0e1c753 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -165,11 +165,10 @@ any of those replacements occurred.
 	of the `--diff-filter` option on what the status letters mean.
 
 --submodule[=<format>]::
-	Choose the output format for submodule differences. <format> can be one of
-	'short' and 'log'. 'short' just shows pairs of commit names, this format
-	is used when this option is not given. 'log' is the default value for this
-	option and lists the commits in that commit range like the 'summary'
-	option of linkgit:git-submodule[1] does.
+	Choose the output format for submodule differences. <format> can be one
+	of 'short' or 'log'. The default value is 'log'.
+	'log' lists commits in the commit range like linkgit:git-submodule[1] `--summary`.
+	'short' shows only the SHA1 of the source and destination.
 
 --color[=<when>]::
 	Show colored diff.
-- 
1.7.10.rc0
