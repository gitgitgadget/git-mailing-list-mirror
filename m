From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 62/73] gettextize: git-clean basic messages
Date: Tue, 22 Feb 2011 23:42:21 +0000
Message-ID: <1298418152-27789-63-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vD-0000K1-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab1BVXok convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:40 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab1BVXof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:35 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4JFQwasVnrxQxcsHq7f1fx9Qpz4m7ZWXHpkR8pL5fnE=;
        b=JFNbpnXY59K67ljIu7OFn1v4kcWyILqXVKX8+R72GScVBzucvMjhkYoIUFAX9aCv1h
         wbL2fxbJha2wUDwMzazQaVv83nQAVPHoplwyMYL9rk5HCtPT7jpIRSOS0yZ2Zd22W4wp
         pTG4l93/mwx5wJ2MCvtq90NfsIg68VjrwvthU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kHglCq7rLA4p6oomL0BfQOa5oMgwGnIrRvGMdn6t+blD/7ZYvwik5nmFLPOISkNcPl
         TeTiDxLz08GN4XEKFXlo8zUkx8WbKZWFV3oJ6llbMmFmr94SGrdDzuVXNM3atJnv8Evd
         MFouGORFo3ndTRwY0FRYt5raUjVzxW0E0SX7E=
Received: by 10.204.53.199 with SMTP id n7mr2979502bkg.53.1298418274471;
        Tue, 22 Feb 2011 15:44:34 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.33
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:33 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167613>

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
index 582d0b5..14fcb1c 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -124,13 +124,13 @@ cat >expected <<EOF
 Would remove expected
 Would remove result
 EOF
-test_expect_success 'git-clean, absent case' '
+test_expect_success C_LOCALE_OUTPUT 'git-clean, absent case' '
 	setup_absent &&
 	git clean -n > result &&
 	test_cmp expected result
 '
=20
-test_expect_success 'git-clean, dirty case' '
+test_expect_success C_LOCALE_OUTPUT 'git-clean, dirty case' '
 	setup_dirty &&
 	git clean -n > result &&
 	test_cmp expected result
diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 02f67b7..7e1be44 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -110,7 +110,7 @@ test_expect_success 'git clean with prefix' '
=20
 '
=20
-test_expect_success 'git clean with relative prefix' '
+test_expect_success C_LOCALE_OUTPUT 'git clean with relative prefix' '
=20
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
@@ -125,7 +125,7 @@ test_expect_success 'git clean with relative prefix=
' '
 	}
 '
=20
-test_expect_success 'git clean with absolute path' '
+test_expect_success C_LOCALE_OUTPUT 'git clean with absolute path' '
=20
 	mkdir -p build docs &&
 	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
@@ -377,7 +377,7 @@ test_expect_success 'clean.requireForce and -f' '
=20
 '
=20
-test_expect_success 'core.excludesfile' '
+test_expect_success C_LOCALE_OUTPUT 'core.excludesfile' '
=20
 	echo excludes >excludes &&
 	echo included >included &&
--=20
1.7.2.3
