From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 64/72] gettextize: git-gc basic messages
Date: Sat, 19 Feb 2011 19:24:47 +0000
Message-ID: <1298143495-3681-65-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTs-0003Eb-Op
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756226Ab1BST2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:32 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35962 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079Ab1BST2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:21 -0500
Received: by ewy5 with SMTP id 5so1970567ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=oJiJMMUmGV6tM+dBTmLCwM5WiW96dxoHYwaADPmPxf0=;
        b=czXoe9RlSwZDl3auqdv7u6Y5PBZ/bgFPaaX2BlZLyRo9/kVzgkncHEauXUSLy4oYwL
         EzcdYY6G8BTnn47jBNkfSTKrvewcQkJI2jleBknjIqOM5VHmQINNtISU5w11zy3LuHSX
         vh8gGYp7FJ50NAPf+hipcO4gTC3fh9jAMWIFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=F/LihbYepZ64ogLSXQZYF9u616bDL68YnVu8jy4vMbLozk7uZfrC61U91ommpvQr6s
         y12U378sCgM31PtwMBye/hGb6+MhwGZrnxEW/gCuMuTOTD8Q2R8IqeNWNsemvXi6sYMy
         u6ChIqeMtdROfcu6OTq1E3Md9+vcWMkgzIP+M=
Received: by 10.213.20.78 with SMTP id e14mr2624993ebb.13.1298143700556;
        Sat, 19 Feb 2011 11:28:20 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.19
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:20 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167346>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/gc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 1a80702..a2be62a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -60,7 +60,7 @@ static int gc_config(const char *var, const char *val=
ue, void *cb)
 		if (value && strcmp(value, "now")) {
 			unsigned long now =3D approxidate("now");
 			if (approxidate(value) >=3D now)
-				return error("Invalid %s: '%s'", var, value);
+				return error(_("Invalid %s: '%s'"), var, value);
 		}
 		return git_config_string(&prune_expire, var, value);
 	}
@@ -75,7 +75,7 @@ static void append_option(const char **cmd, const cha=
r *opt, int max_length)
 		;
=20
 	if (i + 2 >=3D max_length)
-		die("Too many options specified");
+		die(_("Too many options specified"));
 	cmd[i++] =3D opt;
 	cmd[i] =3D NULL;
 }
@@ -100,7 +100,7 @@ static int too_many_loose_objects(void)
 		return 0;
=20
 	if (sizeof(path) <=3D snprintf(path, sizeof(path), "%s/17", objdir)) =
{
-		warning("insanely long object directory %.*s", 50, objdir);
+		warning(_("insanely long object directory %.*s"), 50, objdir);
 		return 0;
 	}
 	dir =3D opendir(path);
@@ -251,8 +251,8 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		return error(FAILED_RUN, argv_rerere[0]);
=20
 	if (auto_gc && too_many_loose_objects())
-		warning("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them.");
+		warning(_("There are too many unreachable loose objects; "
+			"run 'git prune' to remove them."));
=20
 	return 0;
 }
--=20
1.7.2.3
