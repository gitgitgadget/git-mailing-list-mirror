From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] tag, update-ref: improve description of option "create-reflog"
Date: Fri, 11 Sep 2015 18:04:13 +0200
Message-ID: <1441987453-22125-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 18:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQoO-0003cS-HM
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 18:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753501AbbIKQEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 12:04:20 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38034 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbbIKQES (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 12:04:18 -0400
Received: by wiclk2 with SMTP id lk2so63687650wic.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EexpFHL+668F5mpjlZ7ty8AqKqnmY98HlXoY9IqyGDw=;
        b=EAD5ZG8/PGuJEt8yLvPtee6ThHery/ur+gka135SpQLbm/jY30ppoCs+rcAy44p99X
         cnWlkrsfiLbal0SjXXyKgwpMsXCR5NRd2SHRnXULBqfn56xyfx8lpLAJH4xyHs52nf6+
         JffcuAbZrTGnUZn5mCFWyTWBCTzhgs0TMN/YwZnTuF5oX6Vjs5xWwKFWiH4WMiAYY4iG
         jcJcg1e5RtVxsOUEP9HpT5FWlS/eQB2f2Dxh3p+owFTuv827fwiacViWQe1dUzPkWA1L
         Fb5d7SUA8aBoBDrlVgYQcqz3HxTlA02bf5/HOCu6GOzB4Kz8ZqpnlG5bD4p3SPaOBXms
         jW4Q==
X-Received: by 10.180.104.68 with SMTP id gc4mr5796326wib.78.1441987457080;
        Fri, 11 Sep 2015 09:04:17 -0700 (PDT)
Received: from localhost (cable-94-139-9-29.cust.telecolumbus.net. [94.139.9.29])
        by smtp.gmail.com with ESMTPSA id z2sm1249817wij.1.2015.09.11.09.04.16
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 11 Sep 2015 09:04:16 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc1.199.g678474c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277676>

The description of option "create-reflog" is "create_reflog", which
is neither a good description, nor a sensible string to translate.
Change it to a more meaningful message.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/tag.c        | 2 +-
 builtin/update-ref.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index cccca99..cba0e22 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -606,7 +606,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
-		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create_reflog")),
+		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create a reflog")),
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 04dd00f..7f30d3a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
-		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create_reflog")),
+		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create a reflog")),
 		OPT_END(),
 	};
 
-- 
2.6.0.rc1.199.g678474c
