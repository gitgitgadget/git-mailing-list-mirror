From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/22] builtin/config.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:57 +0700
Message-ID: <1456555333-5853-7-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYaS-00037N-AM
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbcB0Gmk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:40 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33849 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbcB0Gmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:42:39 -0500
Received: by mail-pa0-f48.google.com with SMTP id fy10so62457748pac.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3sJfMJbTay4fIki3rxob5Vpuj5TiunDyx4xiGORSG1s=;
        b=dXxjkCULM8O3b6SVlnW1MI4yIZs+DTOlHgEULg/grnnBBIMmI1c1Le5kVanIKw0PE7
         nayNyGg5U8O2MIi47YqpYRYEJKNEp0a814Aw+AZaOEN5a+iiGTmHBE7te56zEug+Jz4A
         4zsiA2bQkT2bG/lXk2b2PredkIjguYbKHhR2uQEHhTyDjWmUyF0nurpRMK7lPEjES6V7
         Y7TJcPViBkWw8YDB49B7SmrsJ1/jgQKYcsNLt0MXVTVt1SjRGFEdV6NBwOi863kxJKTQ
         VRJb0L8SgfEw2M6PE8HfSTli9KYIR/K6qf7hn6ZpG9uWLvDzzmrNnZ1gkOQ8eynBorgm
         7FTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3sJfMJbTay4fIki3rxob5Vpuj5TiunDyx4xiGORSG1s=;
        b=JdCp25jaOHpY5nTigUazGnkyzUT0oPRuv4zg+nC/C1QEGgtQoLxt1ZcinuHiHcqeUL
         CqEHkKBKSpYUcUPB1xIvz/bWVyVjboVMT7dqcTxaiYdvpk+w36O8hI6jG/tbqnDG79Vw
         feP7jM6rTMmJCmtgXafSyasUNtkmE4gLM5wJPgllej9mlngz5FVmFESmqQqo5Og82ijN
         egPGWgd5NPusM2djZfA9u1C29V/FGdOw0B34rI9lJ61aqju+5Dszpeq7DpTv9Bw5uOEe
         fKepcxZBdegmfLMCbS2HKCs6lxRXp2wins6n1i1ZukeXwMWaHOK7t/piKuOlXbZAUxqF
         LFTg==
X-Gm-Message-State: AD7BkJIXRZIZF94GcaHj37kQf2Dov/+DjkxN66fr0flVpTCH1rLhorKwgyDFSG+X0j6gmg==
X-Received: by 10.66.145.194 with SMTP id sw2mr7503675pab.69.1456555359169;
        Fri, 26 Feb 2016 22:42:39 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id kw10sm23553803pab.0.2016.02.26.22.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:56 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287667>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/config.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 98ca43d..b07df26 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -90,7 +90,7 @@ static struct option builtin_config_options[] =3D {
 static void check_argc(int argc, int min, int max) {
 	if (argc >=3D min && argc <=3D max)
 		return;
-	error("wrong number of arguments");
+	error(_("wrong number of arguments"));
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
=20
@@ -213,7 +213,7 @@ static int get_value(const char *key_, const char *=
regex_)
=20
 		key_regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			error("invalid key pattern: %s", key_);
+			error(_("invalid key pattern: %s"), key_);
 			free(key_regexp);
 			key_regexp =3D NULL;
 			ret =3D CONFIG_INVALID_PATTERN;
@@ -234,7 +234,7 @@ static int get_value(const char *key_, const char *=
regex_)
=20
 		regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			error("invalid pattern: %s", regex_);
+			error(_("invalid pattern: %s"), regex_);
 			free(regexp);
 			regexp =3D NULL;
 			ret =3D CONFIG_INVALID_PATTERN;
@@ -381,10 +381,10 @@ static void check_write(void)
 		die(_("not in a git directory"));
=20
 	if (given_config_source.use_stdin)
-		die("writing to stdin is not supported");
+		die(_("writing to stdin is not supported"));
=20
 	if (given_config_source.blob)
-		die("writing config blobs is not supported");
+		die(_("writing config blobs is not supported"));
 }
=20
 struct urlmatch_current_candidate_value {
@@ -489,7 +489,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
=20
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time.");
+		error(_("only one config file at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
@@ -510,7 +510,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME not set");
+			die(_("$HOME not set"));
=20
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
@@ -540,17 +540,17 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (HAS_MULTI_BITS(types)) {
-		error("only one type at a time.");
+		error(_("only one type at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
+		error(_("only one action at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions =3D=3D 0)
@@ -563,7 +563,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		}
 	if (omit_values &&
 	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)=
) {
-		error("--name-only is only applicable to --list or --get-regexp");
+		error(_("--name-only is only applicable to --list or --get-regexp"))=
;
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
@@ -580,10 +580,10 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
 					    &given_config_source,
 					    respect_includes) < 0) {
 			if (given_config_source.file)
-				die_errno("unable to read config file '%s'",
+				die_errno(_("unable to read config file '%s'"),
 					  given_config_source.file);
 			else
-				die("error processing config file(s)");
+				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
@@ -591,11 +591,11 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
=20
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
-			die("not in a git directory");
+			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
-			die("editing stdin is not supported");
+			die(_("editing stdin is not supported"));
 		if (given_config_source.blob)
-			die("editing blobs is not supported");
+			die(_("editing blobs is not supported"));
 		git_config(git_default_config, NULL);
 		config_file =3D xstrdup(given_config_source.file ?
 				      given_config_source.file : git_path("config"));
@@ -620,8 +620,9 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		value =3D normalize_value(argv[0], argv[1]);
 		ret =3D git_config_set_in_file_gently(given_config_source.file, argv=
[0], value);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
-			error("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s.", argv[0=
]);
+			error(_("cannot overwrite multiple values with a single value\n"
+				"Use a regexp, --add or --replace-all to change %s."),
+			      argv[0]);
 		return ret;
 	}
 	else if (actions =3D=3D ACTION_SET_ALL) {
@@ -691,7 +692,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret =3D=3D 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions =3D=3D ACTION_REMOVE_SECTION) {
 		int ret;
@@ -702,7 +703,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret =3D=3D 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions =3D=3D ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
--=20
2.8.0.rc0.205.g7ec8cf1
