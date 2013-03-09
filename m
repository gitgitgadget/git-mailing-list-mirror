From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] perf: update documentation of GIT_PERF_REPEAT_COUNT
Date: Sat,  9 Mar 2013 16:29:25 +0100
Message-ID: <1362842965-3446-1-git-send-email-apelisse@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 09 16:30:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UELiv-00087Y-CZ
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 16:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758689Ab3CIP3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 10:29:47 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:57309 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588Ab3CIP3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 10:29:47 -0500
Received: by mail-wg0-f47.google.com with SMTP id dr13so3472971wgb.26
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GD/jr6XqYoyv/Sctdi8N8r3MTBJ9R/zHWrA1UI0tIQ4=;
        b=0jOD/f2TzOh13MJ1LQOjVXmLDc/2ExuGT27rq0Gcc36MToHlPgEJ/yG5LMIYsdHpoi
         e1Uu82LE14OPLb47ny0YWXEreZn6ig9N8zb7mcAzMOVlNT4+9Vw05l+HDd/4kxyYdk+m
         CY8XYmklIJaf9ztMws+ULRAVNN0WiGn2NwzIghqr2/z98AJvHKJmdXuGAkJR7Gx9FJit
         o/Xj782CNh+P6HlZPp+7hqymMSes51vH5AZLl9jIKCkELuXW9F+8EC1TuLP5nRmLF/iM
         aSaS3rL/XmW7ImWIhIMIvjsk08dIgpszj7Hbj7UR1ikvuTdmRA2IRTidFEKSoXQzjbTn
         d7Ng==
X-Received: by 10.180.93.234 with SMTP id cx10mr3999494wib.34.1362842985877;
        Sat, 09 Mar 2013 07:29:45 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id c15sm5292410wiw.3.2013.03.09.07.29.44
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 07:29:45 -0800 (PST)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217730>

Currently the documentation of GIT_PERF_REPEAT_COUNT says the default is
five while "perf-lib.sh" uses a value of three as a default.

Update the documentation so that it is consistent with the code.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 t/perf/README |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/README b/t/perf/README
index b2dbad4..c552f56 100644
--- a/t/perf/README
+++ b/t/perf/README
@@ -56,7 +56,7 @@ You can set the following variables (also in your config.mak):
 
     GIT_PERF_REPEAT_COUNT
 	Number of times a test should be repeated for best-of-N
-	measurements.  Defaults to 5.
+	measurements.  Defaults to 3.
 
     GIT_PERF_MAKE_OPTS
 	Options to use when automatically building a git tree for
-- 
1.7.9.5
