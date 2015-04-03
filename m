From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 4/4] git-p4: update locked test case
Date: Fri,  3 Apr 2015 19:53:38 +0100
Message-ID: <1428087218-8186-5-git-send-email-luke@diamand.org>
References: <1428087218-8186-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 20:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye6jd-0001J2-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 20:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbbDCSyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 14:54:22 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36632 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbbDCSyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 14:54:16 -0400
Received: by wizk4 with SMTP id k4so51480837wiz.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M3ImbQC5XoCfLl7o5jJ98B3cb+7hc1HxlXdNKqVOvJA=;
        b=Xp4bMD6FCWXYq4HTnltpihiZNwOVTXXg79qACvQk68qgdO7IuMR9wWeVGL39H77ufb
         sjuj6z3/LTsz+w6KWUQwlJdzQAztBFDV8yyLHWxjmTX/36/Oo9MWMpO1WqteMp/rW1Cn
         aUTmHlK3gK13iVoWJ2bCE/jI6IYTlThgZn19w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M3ImbQC5XoCfLl7o5jJ98B3cb+7hc1HxlXdNKqVOvJA=;
        b=jUNnv0vuGnb1c8Y6RUfsBdcUzKZIJdFN5slsC0xR5TYJq/2f0vdlxSUxvc9wg0Su9E
         GhsPpZKOZ6kqMI2LL84foe/tXPwqst3ROJknRxSuHUGA8pxSl0Z1DoY+6rBJwc+ur0tD
         xaD+/BiMhvxEQto7BuH72zC3648+dCoOXo1t2sCHrsIjbZMaNC1HWjofqHzdP7/li3Bj
         u9VkpNBynsTIJ5a3Xp5eDPcOPY5lPnrXCVaPF5cEoT+EoMHP1LLG5AGtW60adkMuA4Em
         st5IsjLYmaMizWOarK1Y7Hsc+v+U8vXxQOi/lO3uUJ8zvA9Kk7tJUqO6o2UhjHuE9r4l
         CxnQ==
X-Gm-Message-State: ALoCoQl0eoiA6LMjOXI2WCqD4gYsruvlNsVjfDJC1z7ZKeNliR+CIZnws3mGCKwPTc3FNcCUzapQ
X-Received: by 10.194.77.230 with SMTP id v6mr7732310wjw.25.1428087255075;
        Fri, 03 Apr 2015 11:54:15 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id fy2sm3782967wic.15.2015.04.03.11.54.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 11:54:14 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428087218-8186-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266720>

The add-new-file and copy-existing-file tests from
t9816-git-p4-locked.sh now pass. Update the test
case accordingly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9816-git-p4-locked.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index 464f10b..d048bd3 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -35,7 +35,7 @@ test_expect_success 'edit with lock not taken' '
 	)
 '
 
-test_expect_failure 'add with lock not taken' '
+test_expect_success 'add with lock not taken' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
@@ -107,7 +107,7 @@ test_expect_failure 'chmod with lock taken' '
 	)
 '
 
-test_expect_failure 'copy with lock taken' '
+test_expect_success 'copy with lock taken' '
 	lock_in_another_client &&
 	test_when_finished cleanup_git &&
 	test_when_finished "cd \"$cli\" && p4 revert file2 && rm -f file2" &&
-- 
2.3.0.rc1.30.g76afe74
