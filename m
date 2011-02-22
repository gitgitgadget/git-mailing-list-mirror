From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 61/73] gettextize: git-bundle basic messages
Date: Tue, 22 Feb 2011 23:42:20 +0000
Message-ID: <1298418152-27789-62-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vE-0000K1-QR
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab1BVXom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:42 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:52041 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab1BVXoe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:34 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867035bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=cnHs0bylf5gsjpvcC032yXa8GLhJLxIeCCe0tZqPAOo=;
        b=TQDuqvq53enmlT3nBsm6VM6a/jE1giLzax8SPD7rbYnGtcyuLyTg6Do2hNujcvegzN
         UOYs9MwCTzlO4kijc6h404leyiz6WitmvMSk5eok4bgVm20X+iKqANrJLcHorQrQiIO1
         0aHHuCy7EhpVCNBf8KfQCpQYK0HWdIuyL4BFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=aQJR1wjzPd61AlWzGYrQh5bQOPe1BHlSZUUSUJPDKJ/AcXgxAz2m4mslR2N2C2u/1Y
         mj65O5CsJNwg5qXs7GAxR1vXLTzUlvri6bJEshqr2GmdbhTmOfBoujnzduHgq/ajike1
         vswlArDMMqZZvp2wMyZcuxPogIstCQNssIsmw=
Received: by 10.204.124.6 with SMTP id s6mr2978102bkr.51.1298418273371;
        Tue, 22 Feb 2011 15:44:33 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.32
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:32 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167614>

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
