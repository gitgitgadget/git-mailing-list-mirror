From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v3 28/31] Fix coding style errors in t-061.sh.
Date: Fri, 16 May 2014 16:46:15 +0200
Message-ID: <1400251578-17221-29-git-send-email-cederp@opera.com>
References: <1400251578-17221-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 16:56:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlJYx-0003ds-4E
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 16:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756502AbaEPO4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 10:56:39 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:54988 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbaEPO4h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 10:56:37 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so2072832lab.31
        for <git@vger.kernel.org>; Fri, 16 May 2014 07:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=swHls+D2GS2nZo5w3dh1xdXY9m2mgmsz9KSYb2HkbEM=;
        b=WWry+R7LX46kwdiOVcbvLn2vemZATWTFOd76qrP993ROm8RPd9eppDEiH8vqkgA0fS
         V0el9rHkPEPwqMniJRu8ammFOKxu0nw987koGhhHQG1pFUQcIVFtla5efVi7ldnt9LcB
         MocLc/J2okb0oT/VaZPQ9X6oyPSDLDZZOlG9BBBl99FnRu61YQiX5khhlZuc0aTMz4Mb
         XBmkQgy9jfSlPr8kZmVLlUwXPCdvCAnqV51A6xuH731XcTN1rtPe8TfsPqLKUqKh/l4T
         8Bm5lksuIFEknrt+Q9iNXoJobvASEadzyLzTIW7xkB0RY9SaLIyysWzYpFA6/WCak/HX
         Iq2A==
X-Gm-Message-State: ALoCoQlCfSMyFOQ9HKsnUfvGxf7x/3NsdDwEm8vWFx5v6YiHpUTxJRW0IJq0zQPp52F/gVmlhE0l
X-Received: by 10.152.121.72 with SMTP id li8mr2430832lab.45.1400252196520;
        Fri, 16 May 2014 07:56:36 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id o1sm8684320lbw.27.2014.05.16.07.56.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 16 May 2014 07:56:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400251578-17221-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249337>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 regression/t-061.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/regression/t-061.sh b/regression/t-061.sh
index db26e12..bda50c7 100755
--- a/regression/t-061.sh
+++ b/regression/t-061.sh
@@ -15,8 +15,7 @@ old_style_branch() {
 
 remove_topic() {
 	cmd guilt pop -a
-	if git rev-parse --verify --quiet guilt/master >/dev/null
-	then
+	if git rev-parse --verify --quiet guilt/master >/dev/null; then
 		cmd git checkout guilt/master
 	else
 		cmd git checkout master
@@ -46,8 +45,7 @@ cmd git for-each-ref
 
 cmd list_files
 
-for i in `seq 5`
-do
+for i in `seq 5`; do
 	if [ $i -ge 5 ]; then
 		shouldfail guilt pop
 	else
-- 
1.8.3.1
