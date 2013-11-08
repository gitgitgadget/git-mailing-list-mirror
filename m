From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: improve error message when pushing to unknown upstream
Date: Fri,  8 Nov 2013 20:44:51 +0100
Message-ID: <1383939891-9458-1-git-send-email-ralf.thielow@gmail.com>
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Fri Nov 08 20:45:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VerzI-0007Nl-In
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 20:45:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758103Ab3KHTo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 14:44:56 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:36454 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494Ab3KHToz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 14:44:55 -0500
Received: by mail-ee0-f48.google.com with SMTP id d49so1217936eek.21
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=NHRQ/PVnLwDfBPq9JIftSsEqnDVYivtppN+2Hf5UEcY=;
        b=TsSgnM6aR+QHVa2NSUa7SQjDOagd3t4y66dfgAyPrwgnf4qy3ttc44BBoBqjIM7A7A
         ysFkKbKWUyb7EDmfVfZBrmj+ORz92r+lD00I2skW2i5kC4yVgC3RvTr5pdDBsDr6z36r
         v27ReQaGQMqdJcVbJNEbfTC9GxeyDfyoc9nDLRrcrX9Ab5pYER1e53Tt5u91SUNJtiVZ
         2EYv1cqmKD2GH2ezyjBeVq2yt6koij/oiFdlkb9Xm3th0O6e4SJc6abYAFqqbiici8SC
         ih8Nc/XhJl8L/mUmjtlE8QFLnXtrh1Bgaui1tvLFmfpWdu2if18G93V8GHwkYXhnRkWX
         mIrA==
X-Received: by 10.15.94.201 with SMTP id bb49mr18867480eeb.23.1383939894648;
        Fri, 08 Nov 2013 11:44:54 -0800 (PST)
Received: from localhost (dslb-178-005-121-004.pools.arcor-ip.net. [178.5.121.4])
        by mx.google.com with ESMTPSA id 43sm1893451eeg.6.2013.11.08.11.44.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 11:44:54 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc1.303.g27c0606
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237465>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/de.po b/po/de.po
index a005dcc..8b824cc 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7923,7 +7923,7 @@ msgid ""
 "to update which remote branch."
 msgstr ""
 "Sie versenden nach '%s', welches kein Upstream-Repository Ihres aktuellen\n"
-"Branches '%s' ist, ohne mir mitzuteilen, was ich versenden soll, um welchen\n"
+"Branches '%s' ist, ohne anzugeben, was versendet werden soll, um welchen\n"
 "Remote-Branch zu aktualisieren."
 
 #: builtin/push.c:167
-- 
1.8.5.rc1.303.g27c0606
