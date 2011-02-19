From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 43/72] gettextize: git-mv basic messages
Date: Sat, 19 Feb 2011 19:24:26 +0000
Message-ID: <1298143495-3681-44-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTo-0003Eb-9r
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113Ab1BST2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:08 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40522 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab1BST2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:03 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347071eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4xx1+CZXpegz9773YktMy6UmP71oBldYxjPAS7O5SZY=;
        b=Hue4zsB1DXhw6j+DtDDCw3zbGmoIkMyREPIiCJM5gZm++nfrc5OTQlQpg4r+QHzQ2x
         2h3sknqvBiCVbSa/3i69yxyno60Ve6ZhkH5+KLEQs13Wh6RuvEOTbkEf4COePkakrsq6
         yOuI3LQG2zxKRhJCARiuS85TD4VhzcEnuNZG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=unyWAMq+CbXrMSYjcZ8XU0J5WazVB2obv9uP0PSOOszyPPIWAndItMGx/CMNPoBMOO
         RsOn/8IQ3ooY/IBZtWM+cB33v/wcWN0BOETHhHVIr+B0spOmgZvodYYwWZMppwl3ianH
         3cQPJDgsvOYRl8b1WIkGHFrSe4bpeEfn4IThk=
Received: by 10.213.104.147 with SMTP id p19mr2527836ebo.77.1298143682618;
        Sat, 19 Feb 2011 11:28:02 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.01
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:02 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167335>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/mv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 93e8995..18a2218 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -74,7 +74,7 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
=20
 	newfd =3D hold_locked_index(&lock_file, 1);
 	if (read_cache() < 0)
-		die("index file corrupt");
+		die(_("index file corrupt"));
=20
 	source =3D copy_pathspec(prefix, argv, argc, 0);
 	modes =3D xcalloc(argc, sizeof(enum update_mode));
@@ -100,7 +100,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 		const char *bad =3D NULL;
=20
 		if (show_only)
-			printf("Checking rename of '%s' to '%s'\n", src, dst);
+			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
=20
 		length =3D strlen(src);
 		if (lstat(src, &st) < 0)
@@ -120,7 +120,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
=20
 			first =3D cache_name_pos(src_w_slash, len_w_slash);
 			if (first >=3D 0)
-				die ("Huh? %.*s is in index?",
+				die (_("Huh? %.*s is in index?"),
 						len_w_slash, src_w_slash);
=20
 			first =3D -1 - first;
@@ -172,7 +172,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 				 * check both source and destination
 				 */
 				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
-					warning("%s; will overwrite!", bad);
+					warning(_("%s; will overwrite!"), bad);
 					bad =3D NULL;
 				} else
 					bad =3D "Cannot overwrite";
@@ -193,7 +193,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 					i--;
 				}
 			} else
-				die ("%s, source=3D%s, destination=3D%s",
+				die (_("%s, source=3D%s, destination=3D%s"),
 				     bad, src, dst);
 		}
 	}
@@ -203,10 +203,10 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 		enum update_mode mode =3D modes[i];
 		int pos;
 		if (show_only || verbose)
-			printf("Renaming %s to %s\n", src, dst);
+			printf(_("Renaming %s to %s\n"), src, dst);
 		if (!show_only && mode !=3D INDEX &&
 				rename(src, dst) < 0 && !ignore_errors)
-			die_errno ("renaming '%s' failed", src);
+			die_errno (_("renaming '%s' failed"), src);
=20
 		if (mode =3D=3D WORKING_DIRECTORY)
 			continue;
@@ -220,7 +220,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    commit_locked_index(&lock_file))
-			die("Unable to write new index file");
+			die(_("Unable to write new index file"));
 	}
=20
 	return 0;
--=20
1.7.2.3
