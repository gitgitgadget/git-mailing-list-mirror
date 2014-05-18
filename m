From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v4 28/33] Fix coding style errors in t-061.sh.
Date: Mon, 19 May 2014 00:00:04 +0200
Message-ID: <1400450409-30998-29-git-send-email-cederp@opera.com>
References: <1400450409-30998-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon May 19 00:12:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm9K4-00016y-OF
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 00:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbaERWMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 18:12:45 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:59943 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbaERWMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 18:12:44 -0400
Received: by mail-la0-f43.google.com with SMTP id mc6so3458382lab.16
        for <git@vger.kernel.org>; Sun, 18 May 2014 15:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2OGiYlGeUDsPlFveZIPyUAyis8MyyKrptlRzAbYxkE=;
        b=edB93x8Y6w0nxDJKBZKuI8mOEtYs5tTj+F4PyRGQSXp0Rnq3LAZWTJZdTnaa0O7/Dw
         W4dUwcZmOIm8+qffRKLX35y+u4ix3m5c2/phERR4Fh/JkOW4kkPC6YE8H5LQBdjcBOIb
         KhCvLRNcXBjfmezXQ/YA29zMgACVppdHPYULuhdhaHuF0uXCtBtVOXIlSYp7EU+83avn
         rlc4XhfzC6tuviQK9rXsDTM7sDno7+03OID4PjKO2Q+RKl/knb5FV/4WezB/pqwJtSx9
         330x3s6DK5GVsJ81wlgUHO+ZKiJVMDGaFtkc9DxoSLX5CwE81TehYqP8R2QScnaU3fB8
         d+5A==
X-Gm-Message-State: ALoCoQkPq//lQlX5TbvJ+JALsZOE2rmJW6NuzHSzk2GdzXEy9hfBONEmfv2+CIjgXJszZxg3TW+s
X-Received: by 10.152.6.228 with SMTP id e4mr3212257laa.57.1400451163541;
        Sun, 18 May 2014 15:12:43 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id d8sm17593818lah.12.2014.05.18.15.12.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 18 May 2014 15:12:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400450409-30998-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249543>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
