From: larsxschneider@gmail.com
Subject: [PATCH v2 1/2] Documentation: fix git-p4 AsciiDoc formatting
Date: Sun, 20 Mar 2016 19:39:20 +0100
Message-ID: <1458499161-61642-2-git-send-email-larsxschneider@gmail.com>
References: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 20 19:39:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahiGB-0005gP-Fl
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 19:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbcCTSj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 14:39:27 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36803 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbcCTSjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 14:39:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so17292047wml.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pBuRziYpcgzdn/wmy+RAbnn1W3VKH5Z+exWNWPO2D9E=;
        b=p++AOxFXOacmR2eEPsrBoe36uI3YUlvbfdr3YYSfMim3FJMY75BlJXhJIiJ9CZ4MX5
         eCWiRTCml2ZyD1AcBOmgNPUzjmYdd9F4A4h5NJG6tbhaycmNuNUmo3qivJ64KDxod7C5
         nt5evJKf/CJiD9trQ/cYIGAhXLyXNWIxyMs9cPBPPJQcPJmzIU5CjxXtmL4ITE2MGGRl
         N8XVlQX5Igsao4R0FcOqxi/ONdMeS57kVy8m5VaRCU2Bb45bP+bQn+XSDfM1nPnrSxtk
         QmAwyCah2GGZnOu5imx0X0MqL2OTtatnZ2+gn3OUxRJE5YXEtM6Ba47XDTotxUnL2rDq
         7gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pBuRziYpcgzdn/wmy+RAbnn1W3VKH5Z+exWNWPO2D9E=;
        b=GJsSn44LnZ2XiiEiwnDQL0AXD3hViMCpDMlBKC90bGdCFjK7TQG28Ey4LbjgrJhGsc
         zU/FF1PwPvmzvyssh6QPR7vHCk7qsZoDoTEdbL3u7PU13xkPKZxfeX0aggTZ0OnJj053
         bH5cnBIgLz5X0svAyXB4j4pprkErtFkvMxpQdS+2fBBcRDlmFSkX6m1TAVvpC0BgJzfB
         gpJZmXtSgto4B3d71Cr45rQcGNE9KwBSZO1/q2XRMUFJySn5eJO80ctcAhMXxj8gvi66
         4PqmgeUJD/U8p9WXuayq499gZt6x8igGecH6jUREUZXopTkbfhvDTD9KmGSxXNAghqsX
         njvw==
X-Gm-Message-State: AD7BkJKLJF+3clmV4Hej0Aap5eXE6m7lTbo1CgxXya8MwB9AmzHdAADb/qR4ggeZhw0a7g==
X-Received: by 10.194.187.240 with SMTP id fv16mr29928674wjc.53.1458499164221;
        Sun, 20 Mar 2016 11:39:24 -0700 (PDT)
Received: from slxBook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id et11sm21829064wjc.30.2016.03.20.11.39.23
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 11:39:23 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1458499161-61642-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289375>

From: Lars Schneider <larsxschneider@gmail.com>

Noticed-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 738cfde..6457634 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -520,15 +520,13 @@ git-p4.pathEncoding::
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
 	that large file systems do not support the 'git p4 submit' command.
-	Only Git LFS [1] is implemented right now. Download
+	Only Git LFS <<1>> is implemented right now. Download
 	and install the Git LFS command line extension to use this option
 	and configure it like this:
 +
 -------------
 git config       git-p4.largeFileSystem GitLFS
 -------------
-+
-	[1] https://git-lfs.github.com/
 
 git-p4.largeFileExtensions::
 	All files matching a file extension in the list will be processed
@@ -626,3 +624,8 @@ IMPLEMENTATION DETAILS
   message indicating the p4 depot location and change number.  This
   line is used by later 'git p4 sync' operations to know which p4
   changes are new.
+
+REFERENCES
+----------
+
+- [[[1]]] https://git-lfs.github.com/[Git LFS - An open source Git extension for versioning large files]
-- 
2.5.1
