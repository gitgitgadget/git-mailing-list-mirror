From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/66] i18n: config: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:05 +0700
Message-ID: <1345465975-16927-17-git-send-email-pclouds@gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHo-0006EX-QO
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045Ab2HTMkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012Ab2HTMkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=S6JBgZYVQW/CAinmVjYZMsRa8CqgAk9/GZeVGCFxlU8=;
        b=wElaT/5vLQBEVcLxjT5IPksUinu5SjkWbkML7nih5lkXo5geFraY7Pke3gOt7o/si2
         NLba9SksCfzGlZQLoVHXP5fZy91VFhj2TAnvsb9itM4kZCHj07l0IJOM+1ZifdxeV0+5
         8snB1v5iYYRiHJHAh711CXkMnaTt+/x5sd2moq62eqwwjsH16JAJ+vHmZZGVvo7kR6ZG
         cR6FDIVsQ/aDXyRb9tFtI0Ha1PrfMYz2vPWNKYorbWKrLWPpRrVi2C6DycAY2GQMocmB
         DWVBI487E0tu6rgXu2aEN+UbfRmXfJFukNjHTtwCw6cJkSfmGIrHr4knphPQ2bLP24Le
         +YYA==
Received: by 10.66.82.168 with SMTP id j8mr24248401pay.73.1345466440878;
        Mon, 20 Aug 2012 05:40:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id pf10sm10903262pbc.56.2012.08.20.05.40.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:40 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203789>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/config.c | 56 ++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cd08da..41032cc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
=20
 static const char *const builtin_config_usage[] =3D {
-	"git config [options]",
+	N_("git config [options]"),
 	NULL
 };
=20
@@ -49,33 +49,33 @@ static int respect_includes =3D -1;
 #define TYPE_PATH (1<<3)
=20
 static struct option builtin_config_options[] =3D {
-	OPT_GROUP("Config file location"),
-	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"=
),
-	OPT_BOOLEAN(0, "system", &use_system_config, "use system config file"=
),
-	OPT_BOOLEAN(0, "local", &use_local_config, "use repository config fil=
e"),
-	OPT_STRING('f', "file", &given_config_file, "file", "use given config=
 file"),
-	OPT_GROUP("Action"),
-	OPT_BIT(0, "get", &actions, "get value: name [value-regex]", ACTION_G=
ET),
-	OPT_BIT(0, "get-all", &actions, "get all values: key [value-regex]", =
ACTION_GET_ALL),
-	OPT_BIT(0, "get-regexp", &actions, "get values for regexp: name-regex=
 [value-regex]", ACTION_GET_REGEXP),
-	OPT_BIT(0, "replace-all", &actions, "replace all matching variables: =
name value [value_regex]", ACTION_REPLACE_ALL),
-	OPT_BIT(0, "add", &actions, "adds a new variable: name value", ACTION=
_ADD),
-	OPT_BIT(0, "unset", &actions, "removes a variable: name [value-regex]=
", ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, "removes all matches: name [value-r=
egex]", ACTION_UNSET_ALL),
-	OPT_BIT(0, "rename-section", &actions, "rename section: old-name new-=
name", ACTION_RENAME_SECTION),
-	OPT_BIT(0, "remove-section", &actions, "remove a section: name", ACTI=
ON_REMOVE_SECTION),
-	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
-	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
-	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color c=
onfigured: [default]"),
-	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the=
 color setting: [stdout-is-tty]"),
-	OPT_GROUP("Type"),
-	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOO=
L),
-	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
-	OPT_BIT(0, "bool-or-int", &types, "value is --bool or --int", TYPE_BO=
OL_OR_INT),
-	OPT_BIT(0, "path", &types, "value is a path (file or directory name)"=
, TYPE_PATH),
-	OPT_GROUP("Other"),
-	OPT_BOOLEAN('z', "null", &end_null, "terminate values with NUL byte")=
,
-	OPT_BOOL(0, "includes", &respect_includes, "respect include directive=
s on lookup"),
+	OPT_GROUP(N_("Config file location")),
+	OPT_BOOLEAN(0, "global", &use_global_config, N_("use global config fi=
le")),
+	OPT_BOOLEAN(0, "system", &use_system_config, N_("use system config fi=
le")),
+	OPT_BOOLEAN(0, "local", &use_local_config, N_("use repository config =
file")),
+	OPT_STRING('f', "file", &given_config_file, N_("file"), N_("use given=
 config file")),
+	OPT_GROUP(N_("Action")),
+	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTI=
ON_GET),
+	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]=
"), ACTION_GET_ALL),
+	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [value-regex]"), ACTION_GET_REGEXP),
+	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [value_regex]"), ACTION_REPLACE_ALL),
+	OPT_BIT(0, "add", &actions, N_("adds a new variable: name value"), AC=
TION_ADD),
+	OPT_BIT(0, "unset", &actions, N_("removes a variable: name [value-reg=
ex]"), ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, N_("removes all matches: name [valu=
e-regex]"), ACTION_UNSET_ALL),
+	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
+	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
+	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_BIT('e', "edit", &actions, N_("opens an editor"), ACTION_EDIT),
+	OPT_STRING(0, "get-color", &get_color_slot, N_("slot"), N_("find the =
color configured: [default]")),
+	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, N_("slot"), N_("f=
ind the color setting: [stdout-is-tty]")),
+	OPT_GROUP(N_("Type")),
+	OPT_BIT(0, "bool", &types, N_("value is \"true\" or \"false\""), TYPE=
_BOOL),
+	OPT_BIT(0, "int", &types, N_("value is decimal number"), TYPE_INT),
+	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYP=
E_BOOL_OR_INT),
+	OPT_BIT(0, "path", &types, N_("value is a path (file or directory nam=
e)"), TYPE_PATH),
+	OPT_GROUP(N_("Other")),
+	OPT_BOOLEAN('z', "null", &end_null, N_("terminate values with NUL byt=
e")),
+	OPT_BOOL(0, "includes", &respect_includes, N_("respect include direct=
ives on lookup")),
 	OPT_END(),
 };
=20
--=20
1.7.12.rc2.18.g61b472e
