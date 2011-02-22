From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 44/73] gettextize: git-mv basic messages
Date: Tue, 22 Feb 2011 23:42:03 +0000
Message-ID: <1298418152-27789-45-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w7-0000rs-82
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755721Ab1BVXqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:01 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457Ab1BVXoR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:17 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4xx1+CZXpegz9773YktMy6UmP71oBldYxjPAS7O5SZY=;
        b=pjiyRSTMb/GkwoN6p3KLy24vLbnPgKQ/vKhGEyvGNRm6uOmD/5QDz460AfoU+M2HQF
         3lE8xAr4uMs6KxEk0HS0EelKQ/+LMyG/VzkiMDqJQ58GeT1B9rmau4cOqBD3SQukovHY
         DyPsUgiWyn96+m2CltiBx2yQa1lM8yBVgiKoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lWElGyMfwlI02a/fFTIgeryWW8lt/zx3h/eWD1H0GJZs3zOlAKlq+CvlYM/zUKbBjV
         c/HxeoudikJIFzIdU7BvazTy5obFRepJoHAP9073Neur3p8S42o6gqeB01iOD7djVHFT
         MUNILHpNznubd2VptnBubKwf+uL1eA80eMNM4=
Received: by 10.204.123.144 with SMTP id p16mr3009888bkr.25.1298418256661;
        Tue, 22 Feb 2011 15:44:16 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.15
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:16 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167630>

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
