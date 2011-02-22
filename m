From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 65/73] gettextize: git-gc basic messages
Date: Tue, 22 Feb 2011 23:42:24 +0000
Message-ID: <1298418152-27789-66-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vF-0000K1-Bu
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608Ab1BVXon convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:43 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583Ab1BVXoi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:38 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=oJiJMMUmGV6tM+dBTmLCwM5WiW96dxoHYwaADPmPxf0=;
        b=qfNYkQb70rw1AO1sXtXDoLYyXGdkvSMRcNyWejmswsxJhs5SBrmQZIgAKweD0k5DcO
         f0a96OVSMZ0BCDoKe8D4VptwTX203CNTJqHQ8nXqydjPTcY3VreyiLRTHBON9Gxn4Vtz
         brOi/bRXgREUT7hD9YFi/KofAkU1d6gk6jess=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=K+okYrG32iAOfptq7j4v/cVoytSdsKixpPg8TIhuLx8tdwgoGcrtP91v21xxhbWr22
         E7pF0MXCah7FOCiy52LOMR1A3NPr4DELi3PkgZIh9lyomFffoo9rVx+ZzkkUH0VgmCG4
         jAGcouXGX8kSlirmvMtXJKSJp2r/cKdchy0lY=
Received: by 10.204.45.87 with SMTP id d23mr3055643bkf.56.1298418277804;
        Tue, 22 Feb 2011 15:44:37 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.36
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:37 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167615>

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
