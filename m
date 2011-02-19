From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 61/72] gettextize: git-clean basic messages
Date: Sat, 19 Feb 2011 19:24:44 +0000
Message-ID: <1298143495-3681-62-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUZ-0003dU-1B
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab1BST25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:57 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60199 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab1BST2S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:18 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970492ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=GjVRkowulFX32EyH4x1W+eC4OlRSoT79X6QpmmZwb6E=;
        b=Ma9um/+KQdExjvP+rE/XxQXD5zK/J5FNDSJNVXIl2u6+SZ6rStiB3KRigPgW03nRBh
         giHmTX3INzlXosxAmtYgVE1oqVlugHXQGd5bw3VVnm0LVwhXCBaZtP5WKf8n8tIuXT5N
         t2KzAOvjscOkr01+zehbOR0PJBqU/HQeOq5Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JZHvrIw2cqEmTXph6afYaO6DTOsIj+FpZm3ajxFGg4Hqhntvkb0nRGE+pE+NrpJ0GP
         VawerBAP9nY17Se54CJaX+9Y3f4CZR+CWDUgTGvkT26nERvJ906PCzOd+NT9pfT8z+h7
         OwPB5a+apTZyxpUQM4RAq2CljE2zrmRXhzTU8=
Received: by 10.14.10.141 with SMTP id 13mr2422391eev.45.1298143698214;
        Sat, 19 Feb 2011 11:28:18 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.17
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:17 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167355>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clean.c                  |   20 ++++++++++----------
 t/t7012-skip-worktree-writing.sh |    4 ++--
 t/t7300-clean.sh                 |    6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 4a312ab..2d0054b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -75,7 +75,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 		dir.flags |=3D DIR_SHOW_IGNORED;
=20
 	if (ignored && ignored_only)
-		die("-x and -X cannot be used together");
+		die(_("-x and -X cannot be used together"));
=20
 	if (!show_only && !force)
 		die("clean.requireForce %s to true and neither -n nor -f given; "
@@ -87,7 +87,7 @@ int cmd_clean(int argc, const char **argv, const char=
 *prefix)
 	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
=20
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	if (!ignored)
 		setup_standard_excludes(&dir);
@@ -146,20 +146,20 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 			qname =3D quote_path_relative(directory.buf, directory.len, &buf, p=
refix);
 			if (show_only && (remove_directories ||
 			    (matches =3D=3D MATCHED_EXACTLY))) {
-				printf("Would remove %s\n", qname);
+				printf(_("Would remove %s\n"), qname);
 			} else if (remove_directories ||
 				   (matches =3D=3D MATCHED_EXACTLY)) {
 				if (!quiet)
-					printf("Removing %s\n", qname);
+					printf(_("Removing %s\n"), qname);
 				if (remove_dir_recursively(&directory,
 							   rm_flags) !=3D 0) {
-					warning("failed to remove %s", qname);
+					warning(_("failed to remove %s"), qname);
 					errors++;
 				}
 			} else if (show_only) {
-				printf("Would not remove %s\n", qname);
+				printf(_("Would not remove %s\n"), qname);
 			} else {
-				printf("Not removing %s\n", qname);
+				printf(_("Not removing %s\n"), qname);
 			}
 			strbuf_reset(&directory);
 		} else {
@@ -167,13 +167,13 @@ int cmd_clean(int argc, const char **argv, const =
char *prefix)
 				continue;
 			qname =3D quote_path_relative(ent->name, -1, &buf, prefix);
 			if (show_only) {
-				printf("Would remove %s\n", qname);
+				printf(_("Would remove %s\n"), qname);
 				continue;
 			} else if (!quiet) {
-				printf("Removing %s\n", qname);
+				printf(_("Removing %s\n"), qname);
 			}
 			if (unlink(ent->name) !=3D 0) {
-				warning("failed to remove %s", qname);
+				warning(_("failed to remove %s"), qname);
 				errors++;
 			}
 		}
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-w=
riting.sh
index 582d0b5..6fccd91 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -124,13 +124,13 @@ cat >expected <<EOF
 Would remove expected
 Would remove result
 EOF
-test_expect_success 'git-clean, absent case' '
+test_expect_success NO_GETTEXT_POISON 'git-clean, absent case' '
 	setup_absent &&
 	git clean -n > result &&
 	test_cmp expected result
 '
=20
-test_expect_success 'git-clean, dirty case' '
+test_expect_success NO_GETTEXT_POISON 'git-clean, dirty case' '
 	setup_dirty &&
 	git clean -n > result &&
 	test_cmp expected result
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 02f67b7..70d8168 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -110,7 +110,7 @@ test_expect_success 'git clean with prefix' '
=20
 '
=20
-test_expect_success 'git clean with relative prefix' '
+test_expect_success NO_GETTEXT_POISON 'git clean with relative prefix'=
 '
=20
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
@@ -125,7 +125,7 @@ test_expect_success 'git clean with relative prefix=
' '
 	}
 '
=20
-test_expect_success 'git clean with absolute path' '
+test_expect_success NO_GETTEXT_POISON 'git clean with absolute path' '
=20
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
@@ -377,7 +377,7 @@ test_expect_success 'clean.requireForce and -f' '
=20
 '
=20
-test_expect_success 'core.excludesfile' '
+test_expect_success NO_GETTEXT_POISON 'core.excludesfile' '
=20
 	echo excludes >excludes &&
 	echo included >included &&
--=20
1.7.2.3
