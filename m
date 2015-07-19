From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/6] config.txt: refer to "git worktree prune", not "prune --worktree"
Date: Sat, 18 Jul 2015 19:10:57 -0700
Message-ID: <47bb6cfeed994694bf333facb5956583da9b934b.1437271363.git.mhagger@alum.mit.edu>
References: <cover.1437271363.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 19 04:11:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGe53-0008Qc-KO
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 04:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbbGSCLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 22:11:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:53910 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752545AbbGSCLn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2015 22:11:43 -0400
X-AuditID: 1207440e-f79516d0000012b3-b0-55ab075bf66b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id E3.FD.04787.B570BA55; Sat, 18 Jul 2015 22:11:39 -0400 (EDT)
Received: from localhost.localdomain ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6J2BUOf011238
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jul 2015 22:11:38 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1437271363.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsUixO6iqBvNvjrUYFWrgkXXlW4mi4beK8wW
	t1fMZ7bonvKW0eLMm0ZGB1aPv+8/MHnsnHWX3ePiJWWPxQ+8PD5vkgtgjeK2SUosKQvOTM/T
	t0vgzji7fxZ7wXHWipM3drE2MJ5j6WLk5JAQMJH4tvIeM4QtJnHh3nq2LkYuDiGBy4wSP7e/
	ZoJw1jNJ/H45H6yDTUBXYlFPMxOILSKwiVGi9XU+iM0s4CCx+XMjI4gtLBAmseREByuIzSKg
	KrH20E+geg4OXoEoiTXfzCGWyUmcP/4TbDGngIXEpFctbCC2kIC5xO15/5gnMPIuYGRYxSiX
	mFOaq5ubmJlTnJqsW5ycmJeXWqRrrJebWaKXmlK6iRESUHw7GNvXyxxiFOBgVOLhtfiyKlSI
	NbGsuDL3EKMkB5OSKG/pK6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd58xtWhQrwpiZVVqUX5
	MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCd4FbECNgkWp6akVaZk5JQhpJg5OkOFc
	UiLFqXkpqUWJpSUZ8aDIiC8GxgZIigdo71yQdt7igsRcoChE6ylGXY4FP26vZRJiycvPS5US
	53UAKRIAKcoozYNbAUsfrxjFgT4W5t0PUsUDTD1wk14BLWECWtK5egXIkpJEhJRUA6PvC9//
	C+237Pp6g2FPw78GpaPzm911UwxXzpvWHa52qFg1gJHZPz3U3SPC7db3Hyn3di68fXQ9z/wd
	SicPf1Q5WSWTcNz5YuArzreX9UWO3pbyWLrPq72KfZLEA6av77XdX5d4Vc3raDto 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274188>

The latter doesn't exist.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3e37b93..7f65dbb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1293,7 +1293,7 @@ gc.pruneExpire::
 
 gc.pruneWorktreesExpire::
 	When 'git gc' is run, it will call
-	'prune --worktrees --expire 3.months.ago'.
+	'git worktree prune --expire 3.months.ago'.
 	Override the grace period with this config variable. The value
 	"now" may be used to disable the grace period and prune
 	$GIT_DIR/worktrees immediately.
-- 
2.1.4
