From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 6/7] i18n: mark checkout --detach messages for translation
Date: Sun, 10 Apr 2011 19:34:07 +0000
Message-ID: <1302464048-21806-7-git-send-email-avarab@gmail.com>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 21:34:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90P5-00036n-Or
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 21:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757947Ab1DJTed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 15:34:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50248 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872Ab1DJTe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 15:34:29 -0400
Received: by eyx24 with SMTP id 24so1534110eyx.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 12:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=R5hkuMhhHhaUM8MwfFLXnm1g9cwv4ebxD4efAbkEQOY=;
        b=sIzFLe1mXh733rVUzj8lewp9DkADc9pb44hrO91fqAkMybv6qrqtzqM0ku8Ut73wbn
         8184XxixODGTFTxAOfFyJK/1P45L3KRxJHwDD4uhoojOUq/PbbI5zT+vx3wNGu2FBs98
         4jL1+6HDlPlgH26CQVD57zwBiFrdC4Y6o3ElY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OFqK+ZZsZC53z8tcmo6wXztoGC7w+e5kQcEWT0KrjOpPkwd5SqtHmLuEBj/OTmTbrq
         yZqozYGJlE9SIrqCDWRxAm251sOIGtdWWY80PEz4GRGd3HgoNv9xxiefxsWoH28SGWJH
         mhqBBVozOPkPGvemiCaou3iUt67pvd+T0V0ng=
Received: by 10.213.27.19 with SMTP id g19mr705058ebc.127.1302464068639;
        Sun, 10 Apr 2011 12:34:28 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id m55sm1147236eei.8.2011.04.10.12.34.26
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 12:34:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1302464048-21806-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171280>

Mark messages added in v1.7.5-rc0~117^2~2 (checkout: introduce
--detach synonym for "git checkout foo^{commit}") by Junio C Hamano
for translation.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/checkout.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index eece5d6..0b65edd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -961,9 +961,9 @@ int cmd_checkout(int argc, const char **argv, const=
 char *prefix)
 		die (_("--patch is incompatible with all other options"));
=20
 	if (opts.force_detach && (opts.new_branch || opts.new_orphan_branch))
-		die("--detach cannot be used with -b/-B/--orphan");
+		die(_("--detach cannot be used with -b/-B/--orphan"));
 	if (opts.force_detach && 0 < opts.track)
-		die("--detach cannot be used with -t");
+		die(_("--detach cannot be used with -t"));
=20
 	/* --track without -b should DWIM */
 	if (0 < opts.track && !opts.new_branch) {
@@ -1043,7 +1043,7 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		}
=20
 		if (opts.force_detach)
-			die("git checkout: --detach does not take a path argument");
+			die(_("git checkout: --detach does not take a path argument"));
=20
 		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incom=
patible when\nchecking out of the index."));
--=20
1.7.4.1
