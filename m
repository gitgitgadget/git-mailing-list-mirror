From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/15] gettextize: git-gc basic messages
Date: Mon,  6 Sep 2010 12:21:35 +0000
Message-ID: <1283775704-29440-7-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Sep 06 14:22:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osait-0000aR-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753611Ab0IFMWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab0IFMWW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:22 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so6463612wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NdZrGLQPZS2/V0FjBctoFKGX+5k6LHPQh+SnieJcwK4=;
        b=bTfCjxkXL7Du+d6yn2i9GWu1eBcipYaMIVgoN8xaC7AfgSjbkWGFzvSqtHtzNkgaAa
         xcdmzQhPAZNqKNqIJnupGi17HkzY4qktnw299hycSc9PWTa5D8K1p98BYFE1nT6M4Hda
         1BqZwopzxN3GIDQqSKmrLDUbsPjv2B6lQgAEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=WxQmRPY3hQ23Mr0HFGZdAoHNh0jbpMSnfUHIXmAPUf5Epu3o1GdOQ8KDQhthC/VTqs
         0jsEXqAF5PafwH8MAsDZlPgg3IwdcLleKCBHHS3mDQiwW0g+AUA2ERVq0WV8XE3MKSAJ
         0kaOQNe/a855AoJMf7LW5GiwmqAGUkcdiKJ+E=
Received: by 10.227.156.202 with SMTP id y10mr1223125wbw.48.1283775741876;
        Mon, 06 Sep 2010 05:22:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155555>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/gc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c304638..05aed1f 100644
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
@@ -248,8 +248,8 @@ int cmd_gc(int argc, const char **argv, const char =
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
1.7.2.3.313.gcd15
