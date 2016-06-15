From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 14/25] gettextize: git-mv basic messages
Date: Thu,  2 Sep 2010 19:40:35 +0000
Message-ID: <1283456446-22577-15-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFfb-00061i-Mg
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0IBTlz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649Ab0IBTlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:53 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7FMs0kPD5y+9s7tERDeFLjspmnjI4G/ITthwpOoSY6c=;
        b=WnYX+9DZFBqvyLMHV2fX1J1chd2zKbC4/nVc+yrxXs+bgM0mL/dIy+IhkY4oQqNnDM
         LTfw1VOrAfNeXzAQM3eoxEi9f2ZDR7zk+uYYjaSBfnI6sPVjb3ilYPZfllx8L1ebSMxy
         3+UzjTMHcWAVVv66cXowSmhrNTH5NgDjJXHXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rZDdRCDlnTx/PlFMY87Xf/R8Y5DlUHsw2q2DQrvqONPJRTpScrCWRNqnJIFOewwbck
         hdu2IoMv64Eeo5bA2Bhqs0N7u/5lxsjxlqVzelhWm8iRczbayOC/bEWGZ7E/AyENVn3C
         r9rjO5VRwyfJsZa6aEYMQjGqFHCELP9Qt9T1I=
Received: by 10.227.134.129 with SMTP id j1mr74106wbt.79.1283456512624;
        Thu, 02 Sep 2010 12:41:52 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155173>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/mv.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index cdbb094..5d99973 100644
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
1.7.2.2.614.g1dc9
