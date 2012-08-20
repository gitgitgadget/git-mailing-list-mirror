From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 66/66] Use imperative form in help usage to describe an action
Date: Mon, 20 Aug 2012 19:32:55 +0700
Message-ID: <1345465975-16927-67-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:46:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RNE-0001jR-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756Ab2HTMqW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:46:22 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695Ab2HTMqV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:46:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=OgqzZ64ToJjJHYfzMnrk2BVCJ3BqM/KqNAVHmvsEx58=;
        b=JK5hBL6aM9Sub2IbKQqjA/Z/QJpDdIT8ey0Dh6pxLUFT9HFDdw0Hk+Q7UiEQMFoWDw
         H01Yo6FphHSO2hyiL6Y6TZfrusX1KTGH0XSnjR9ZqZNuQU+kiz85J5iBaljW54S2g7Ed
         OJtMN7nyv1cQcfUdsyLV8354lA7AsBqnMLjOW82ViKXXf0Kvh1/AAVhrAxvIc+1bsvsG
         Rp9bYrV47x5s5zZbdTN19bdoT4fz11AgNuS7aqBmcx+88CYTGlYXNl4mVZD93Pp09Lso
         c87Pv/mm+uuasZ6zlZntImwyYxz9xfk5AWK8CVwnqlN0PPTqcQ2Yk+9GhW7xVn4O7A4D
         ta9g==
Received: by 10.66.77.40 with SMTP id p8mr29279808paw.78.1345466781007;
        Mon, 20 Aug 2012 05:46:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id kt8sm11053356pbc.1.2012.08.20.05.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:46:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:40:20 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203838>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 My guts tell me this is correct, but my English foundation is shaking
 so I say "change in the name of consistency"!

 builtin/apply.c          | 2 +-
 builtin/checkout-index.c | 4 ++--
 builtin/config.c         | 8 ++++----
 builtin/grep.c           | 2 +-
 builtin/push.c           | 2 +-
 builtin/update-ref.c     | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index d453c83..0ab81e3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4297,7 +4297,7 @@ int cmd_apply(int argc, const char **argv, const =
char *prefix_)
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOLEAN(0, "numstat", &numstat,
-			N_("shows number of added and deleted lines in decimal notation")),
+			N_("show number of added and deleted lines in decimal notation")),
 		OPT_BOOLEAN(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")=
),
 		OPT_BOOLEAN(0, "check", &check,
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 86b7d36..b1feda7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -184,8 +184,8 @@ int cmd_checkout_index(int argc, const char **argv,=
 const char *prefix)
 	int force =3D 0, quiet =3D 0, not_new =3D 0;
 	struct option builtin_checkout_index_options[] =3D {
 		OPT_BOOLEAN('a', "all", &all,
-			N_("checks out all files in the index")),
-		OPT__FORCE(&force, N_("forces overwrite of existing files")),
+			N_("check out all files in the index")),
+		OPT__FORCE(&force, N_("force overwrite of existing files")),
 		OPT__QUIET(&quiet,
 			N_("no warning for existing files and files not in index")),
 		OPT_BOOLEAN('n', "no-create", &not_new,
diff --git a/builtin/config.c b/builtin/config.c
index 41032cc..31e1354 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -59,13 +59,13 @@ static struct option builtin_config_options[] =3D {
 	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]=
"), ACTION_GET_ALL),
 	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-re=
gex [value-regex]"), ACTION_GET_REGEXP),
 	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variable=
s: name value [value_regex]"), ACTION_REPLACE_ALL),
-	OPT_BIT(0, "add", &actions, N_("adds a new variable: name value"), AC=
TION_ADD),
-	OPT_BIT(0, "unset", &actions, N_("removes a variable: name [value-reg=
ex]"), ACTION_UNSET),
-	OPT_BIT(0, "unset-all", &actions, N_("removes all matches: name [valu=
e-regex]"), ACTION_UNSET_ALL),
+	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACT=
ION_ADD),
+	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-rege=
x]"), ACTION_UNSET),
+	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value=
-regex]"), ACTION_UNSET_ALL),
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name n=
ew-name"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), =
ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
-	OPT_BIT('e', "edit", &actions, N_("opens an editor"), ACTION_EDIT),
+	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_STRING(0, "get-color", &get_color_slot, N_("slot"), N_("find the =
color configured: [default]")),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, N_("slot"), N_("f=
ind the color setting: [stdout-is-tty]")),
 	OPT_GROUP(N_("Type")),
diff --git a/builtin/grep.c b/builtin/grep.c
index d73841c..c9a65b3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -682,7 +682,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BOOLEAN(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
-			 N_("finds in contents not managed by git"), 1),
+			 N_("find in contents not managed by git"), 1),
 		OPT_BOOLEAN(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
diff --git a/builtin/push.c b/builtin/push.c
index 4840bc2..8686a7a 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -364,7 +364,7 @@ int cmd_push(int argc, const char **argv, const cha=
r *prefix)
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRA=
NSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FO=
RCE),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
-			N_("controls recursive pushing of submodules"),
+			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 		OPT_BOOLEAN( 0 , "thin", &thin, N_("use thin pack")),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("re=
ceive pack program")),
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index b30394f..51d2684 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,7 +16,7 @@ int cmd_update_ref(int argc, const char **argv, const=
 char *prefix)
 	int delete =3D 0, no_deref =3D 0, flags =3D 0;
 	struct option options[] =3D {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update"=
)),
-		OPT_BOOLEAN('d', NULL, &delete, N_("deletes the reference")),
+		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
 		OPT_END(),
--=20
1.7.12.rc2.18.g61b472e
