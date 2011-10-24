From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Reindent closing bracket using tab instead of spaces
Date: Mon, 24 Oct 2011 15:24:51 +1100
Message-ID: <1319430291-12612-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 06:27:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIC7q-00014P-J6
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 06:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab1JXE04 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 00:26:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40074 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977Ab1JXE04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 00:26:56 -0400
Received: by ywm3 with SMTP id 3so1104739ywm.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 21:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=++1qiWZXiOueZAR2c/k7JGmyGfU/WZhFxTLyAXI7xP0=;
        b=vOF0tBVJ0y+B0IWOYIjsseeGmUxlaP8lDMQKWtRzPkeQEBXYsYSxIntJ/6vS+JgC4s
         gAMdgsdDvQM+DafVWvzHFuf7m6Arynq7qPaZAFW6AHtmbnG4EWUHRwQGtEWQ8oXU3nWe
         EOyrxJcwanJI9toWX7m4pVxl20VDEIOjH3WI8=
Received: by 10.151.147.17 with SMTP id z17mr7733185ybn.93.1319430415514;
        Sun, 23 Oct 2011 21:26:55 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id l27sm25575679ani.21.2011.10.23.21.26.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 21:26:54 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 15:25:12 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184149>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I'm not going to convert all leading spaces to tabs. But this one look=
s just ugly
 because it mis-aligns with the rest of the function.

 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 8836a52..70fdb76 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -396,7 +396,7 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 	if (s->ignore_submodule_arg) {
 		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
-    }
+	}
 	rev.diffopt.format_callback =3D wt_status_collect_changed_cb;
 	rev.diffopt.format_callback_data =3D s;
 	init_pathspec(&rev.prune_data, s->pathspec);
--=20
1.7.3.1.256.g2539c.dirty
