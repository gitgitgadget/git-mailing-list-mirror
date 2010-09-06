From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/15] gettextize: git-clean basic messages
Date: Mon,  6 Sep 2010 12:21:32 +0000
Message-ID: <1283775704-29440-4-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osair-0000aR-O5
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab0IFMWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:16 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0IFMWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:12 -0400
Received: by wwj40 with SMTP id 40so6463612wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=xPRSn3BH7G3cx4aSWXL404G9OnsNcftsBlmOVaICux4=;
        b=D0G+gMARpV18VS4B2BOx5DSVWVU9OUDo6AbRpakBjm2DlBO64u9ZycWS4mHeN7pd/O
         qO9s6F+ooinVgTi7CpeDCS8O7Z/a5vNEyrzC2bs/nkxUDYyVoQz5HcokLkQNPoVgwOSh
         0d7EjGdm4VQ6piL/xkrYzMToF4gPxilBt2YHI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xpex2nhY9T5d0vEL2Xsha/XsU+BOpd3b5BbJSjqonlVZa5DjslPxADFnXZK0XeLpG/
         uB3tw7ecW4aaLWqjZSsY1SRgGilbPUUoNNLU7NMxKGBaDIUWphmhDlt2JATA8pmUUoLX
         Ym4ZjjuVxOm5c0mLHo/wcccQgVw0rfzVnhRNM=
Received: by 10.216.7.210 with SMTP id 60mr3332548wep.30.1283775730406;
        Mon, 06 Sep 2010 05:22:10 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.07
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155556>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/clean.c                  |   20 ++++++++++----------
 t/t7012-skip-worktree-writing.sh |    4 ++--
 t/t7300-clean.sh                 |    6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index b508d2c..10dde87 100644
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
-					warning("failed to remove '%s'", qname);
+					warning(_("failed to remove '%s'"), qname);
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
-				warning("failed to remove '%s'", qname);
+				warning(_("failed to remove '%s'"), qname);
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
index 7dbbea1..eed032d 100755
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
1.7.2.3.313.gcd15
