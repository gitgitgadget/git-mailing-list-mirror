From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] wt-status: move #include "pathspec.h" to the header
Date: Thu, 20 Aug 2015 16:06:27 +0200
Message-ID: <1440079587-26491-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:06:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSQUM-000740-RU
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 16:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbbHTOGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 10:06:37 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33302 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448AbbHTOGg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2015 10:06:36 -0400
Received: from x590d6ed3.dyn.telefonica.de ([89.13.110.211] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZSQUC-0007Np-4r; Thu, 20 Aug 2015 16:06:33 +0200
X-Mailer: git-send-email 2.5.0.415.g33d64ef
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440079593.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276241>

The declaration of 'struct wt_status' requires the declararion of 'stru=
ct
pathspec'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 wt-status.c | 1 -
 wt-status.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 717fd48d13..c327fe8128 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include "pathspec.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
diff --git a/wt-status.h b/wt-status.h
index e0a99f75c7..c9b3b744e9 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include "string-list.h"
 #include "color.h"
+#include "pathspec.h"
=20
 enum color_wt_status {
 	WT_STATUS_HEADER =3D 0,
--=20
2.5.0.415.g33d64ef
