From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 60/72] gettextize: git-bundle basic messages
Date: Sat, 19 Feb 2011 19:24:43 +0000
Message-ID: <1298143495-3681-61-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUZ-0003dU-JO
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303Ab1BST27 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:59 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60431 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab1BST2R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:17 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970440ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=cnHs0bylf5gsjpvcC032yXa8GLhJLxIeCCe0tZqPAOo=;
        b=l6hOLHdv4JFkuuq2HWbDx2150YX9tfeESDteWflouzq0/hb0t8Ev1pXsOTJHvFZkf/
         wBAjLIKaPjNiDUg2NLpyG7gNmtTWlhre/ZjKGgmOLbiE0iz7LOqg7mKuBN3T1LyKVfv/
         hECFXiOzwNUzFB7nVpCipJNxDj5cK07vVBxus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sBSwsqU5GINNJFnuir+LFFezlK+bPuGmw4YLk5Mf06Kq80p1qMKzseAnKV2HipcYQs
         f1FY5O6n/nzFlsv4ybsGYS3OvHm4A+Ww+eJEf4WcUe0oO4RTpIyctn169FSH59IFcmot
         Ka7xNTWSIPWn0RP4lPcvWC4X4Xf9sJVXYX5S0=
Received: by 10.213.32.137 with SMTP id c9mr2575197ebd.7.1298143697107;
        Sat, 19 Feb 2011 11:28:17 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.16
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:16 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167354>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/bundle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 9b87fb9..81046a9 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -44,7 +44,7 @@ int cmd_bundle(int argc, const char **argv, const cha=
r *prefix)
 		close(bundle_fd);
 		if (verify_bundle(&header, 1))
 			return 1;
-		fprintf(stderr, "%s is okay\n", bundle_file);
+		fprintf(stderr, _("%s is okay\n"), bundle_file);
 		return 0;
 	}
 	if (!strcmp(cmd, "list-heads")) {
@@ -53,11 +53,11 @@ int cmd_bundle(int argc, const char **argv, const c=
har *prefix)
 	}
 	if (!strcmp(cmd, "create")) {
 		if (!startup_info->have_repository)
-			die("Need a repository to create a bundle.");
+			die(_("Need a repository to create a bundle."));
 		return !!create_bundle(&header, bundle_file, argc, argv);
 	} else if (!strcmp(cmd, "unbundle")) {
 		if (!startup_info->have_repository)
-			die("Need a repository to unbundle.");
+			die(_("Need a repository to unbundle."));
 		return !!unbundle(&header, bundle_fd) ||
 			list_bundle_refs(&header, argc, argv);
 	} else
--=20
1.7.2.3
