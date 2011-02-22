From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 48/73] gettextize: git-reset reset_type_names messages
Date: Tue, 22 Feb 2011 23:42:07 +0000
Message-ID: <1298418152-27789-49-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vC-0000K1-JI
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755570Ab1BVXob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:31 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755228Ab1BVXoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:21 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Pv2BnFaXtTL5pzBUzYksPNNC4AbGRbSI7jABCocSAdY=;
        b=sYfDRbkbegSb1obY7v3zDMc83LXxGV6dF7LBk9oN2HmDHj/Fp8xKn9ZagTbXnyvGZ2
         MUZiLwKDelCzrZZs+44fnqKlyj+OYF4eoMrokoxsAq8AjQpO5cpgcLUbuJ0mkpDb210h
         Ad/zv7me/wOnlg+2odkC38zCIZrnrhDHeyvg4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fw8wjCiqxziWWCpr0RMJzJpfNDxX0b8nJ8bdacUO+bSgWdw+YIRz91xXIaMnymZBG8
         Jzuc+RNrM4VRnNslptzaeC369kd3uOz9h6h3r6NePrc+DxZL3GjPpY2TiUgTZW30gOj7
         7R71HvxzuFVdX5ZMWIXXpCNoeJluFskNzAicY=
Received: by 10.204.98.130 with SMTP id q2mr3055568bkn.31.1298418260461;
        Tue, 22 Feb 2011 15:44:20 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.19
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:19 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167612>

Make the messages in git-reset that use the reset_type_names static
array to be translatable by marking the array items with N_() and
using _() later.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/reset.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 0823955..1465174 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -30,7 +30,7 @@ static const char * const git_reset_usage[] =3D {
=20
 enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
 static const char *reset_type_names[] =3D {
-	"mixed", "soft", "hard", "merge", "keep", NULL
+	N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep"), NULL
 };
=20
 static char *args_to_str(const char **argv)
@@ -228,8 +228,8 @@ static void prepend_reflog_action(const char *actio=
n, char *buf, size_t size)
 static void die_if_unmerged_cache(int reset_type)
 {
 	if (is_merge() || read_cache() < 0 || unmerged_cache())
-		die("Cannot do a %s reset in the middle of a merge.",
-		    reset_type_names[reset_type]);
+		die(_("Cannot do a %s reset in the middle of a merge."),
+		    _(reset_type_names[reset_type]));
=20
 }
=20
@@ -320,8 +320,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		if (reset_type =3D=3D MIXED)
 			warning(_("--mixed with paths is deprecated; use 'git reset -- <pat=
hs>' instead."));
 		else if (reset_type !=3D NONE)
-			die("Cannot do %s reset with paths.",
-					reset_type_names[reset_type]);
+			die(_("Cannot do %s reset with paths."),
+					_(reset_type_names[reset_type]));
 		return read_from_tree(prefix, argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
 	}
@@ -332,8 +332,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		setup_work_tree();
=20
 	if (reset_type =3D=3D MIXED && is_bare_repository())
-		die("%s reset is not allowed in a bare repository",
-		    reset_type_names[reset_type]);
+		die(_("%s reset is not allowed in a bare repository"),
+		    _(reset_type_names[reset_type]));
=20
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
--=20
1.7.2.3
