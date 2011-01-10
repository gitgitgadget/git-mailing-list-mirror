From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] exec_cmd: remove unused extern
Date: Mon, 10 Jan 2011 23:00:49 +0100
Message-ID: <1294696849-1428-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 10 23:01:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcPo6-0006GJ-UX
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 23:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033Ab1AJWB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 17:01:28 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34354 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977Ab1AJWB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 17:01:27 -0500
Received: by eye27 with SMTP id 27so8866429eye.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 14:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=4p/hXD2zgMpoPq33M7LJYYxA7P3b3NZJ6dVuSgcBp/o=;
        b=wjkFmmO2Vby0WbkXx0RpRWCKjYvszernA4WTFTaIzCT8SeZvTpupKTPDLUrAV9m7GT
         j0IKtCnrrTN9NV3o7T/IQi3s9rCrOHI1pGSpltJDiG+11wlFZPubn/Jp/2ojOQeuxin/
         uArq25oIBw43L5zA60VwLARSvkj4eL9yKOCQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=VuPDijg1APNLEEoS6hOehd6ASGtsICVEebyF1iZa9S7/MjPCf/EqjyyswCs+1Vng/b
         TMUEQs5KjUwAAGesPlN+ekeK8CkcQO0QMvrkL/Qkx46pPqIz7Q3lO3ja2+pPUWrMS1Ku
         TkmXJIYeoZvFun2h1S0pLK+T4De/cututSSbw=
Received: by 10.213.33.74 with SMTP id g10mr4016503ebd.61.1294696886180;
        Mon, 10 Jan 2011 14:01:26 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id t5sm5117559eeh.2.2011.01.10.14.01.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 14:01:25 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc1.3196.gfd693
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164902>

This definition was added by commit 77cb17e9, but it's left unused since
commit 511707d. Remove the left-over definition.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Just a left-over definition I found while looking through some code.

 exec_cmd.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index bf22570..38545e8 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -3,7 +3,6 @@
 #include "quote.h"
 #define MAX_ARGS	32
 
-extern char **environ;
 static const char *argv_exec_path;
 static const char *argv0_path;
 
-- 
1.7.4.rc1.3196.gfd693
