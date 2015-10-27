From: =?UTF-8?q?Micka=C3=ABl=20Thomas?= <mickael9@gmail.com>
Subject: [PATCH] Fix missing accelerators causing crashes with old translations
Date: Tue, 27 Oct 2015 01:09:45 +0100
Message-ID: <1445904585-15822-1-git-send-email-mickael9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mickael9 <mickael9@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 01:09:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqrpt-0007hI-S1
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 01:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbJ0AJx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 20:09:53 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36624 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbJ0AJu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 20:09:50 -0400
Received: by wicfx6 with SMTP id fx6so136998588wic.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=K9q/f2RJ1b8+1q7GcG9/8QqfR3n4DMbwsxDY2Wyu7eY=;
        b=BvXjtjtGllCDHhdMzV7v0aWh4pSQ+wfCbxHqy4PME9IA/Xi0NYMjD0NTvAKqCh5UTj
         pxpViapQimuWp/iCtBq+33ZwXsBvDr2vJ0YHCDPWrU75BHHRpBf7++nCLlxV7rNgDqhj
         Q9qyORwEOOpc9VHZJDl9KzFhLBbtVMGcxORtJ7UUwn/qRTzNwlXXZ/Q6TWeLRchEihsJ
         SKsNP7DvQOj8UuSMMiardSbITX4K/samE9AfEF8JBFUW2342uNuQCQpmswoBjZrlikZ5
         QyPMKBb8aPLSR3PRFPvTKOEueyh0tbfGwQwGUyx7kjutir1vIXehSQkGxl3JZlMJ3H4m
         tQVw==
X-Received: by 10.180.182.49 with SMTP id eb17mr24844559wic.82.1445904589846;
        Mon, 26 Oct 2015 17:09:49 -0700 (PDT)
Received: from mickael-laptop.localdomain (home.mickael9.tk. [82.226.104.223])
        by smtp.gmail.com with ESMTPSA id i10sm15704960wij.9.2015.10.26.17.09.48
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 17:09:48 -0700 (PDT)
Received: by mickael-laptop.localdomain (Postfix, from userid 1000)
	id 01701360985; Tue, 27 Oct 2015 01:09:47 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280234>

=46rom: mickael9 <mickael9@gmail.com>

Signed-off-by: Micka=C3=ABl Thomas <mickael9@gmail.com>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 2028b55..fcc606e 100755
--- a/gitk
+++ b/gitk
@@ -12452,8 +12452,8 @@ if {$cmdline_files ne {} || $revtreeargs ne {} =
|| $revtreeargscmd ne {}} {
     set viewchanged(1) 0
     set vdatemode(1) 0
     addviewmenu 1
-    .bar.view entryconf [mca "Edit view..."] -state normal
-    .bar.view entryconf [mca "Delete view"] -state normal
+    .bar.view entryconf [mca "&Edit view..."] -state normal
+    .bar.view entryconf [mca "&Delete view"] -state normal
 }
=20
 if {[info exists permviews]} {
--=20
2.6.2
