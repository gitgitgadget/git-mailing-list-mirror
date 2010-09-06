From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/15] gettextize: git-bundle basic messages
Date: Mon,  6 Sep 2010 12:21:31 +0000
Message-ID: <1283775704-29440-3-git-send-email-avarab@gmail.com>
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
	id 1Osair-0000aR-7B
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab0IFMWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:14 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab0IFMWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:08 -0400
Received: by wyf22 with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Od5URMf0KvqM4625BriMLib0/kbEj1ik5lcas1kW12I=;
        b=Ddszb3ffU778DQDpVszpVKRwW4l7/WUVINa368YasYQZ7iQjkz//M2QTFkwJpZ3/p1
         5SUC/nyWi3GjvNVT7tDXNq9piAkl22brvFuO/ZMBKo7tKC9SThbefLgZCt9e7aDqkXUb
         CWujLjYN6RkEXgqs1WBA8NTJKSgkxCepmqaIk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=GI+jvCUVSraR4wfOHVRs3WitDU8JqINoY5N3s1SmwsZyUYpYQkiK6FwLEqUC++okWX
         ThD6JJ/cBlj5o5hAK6/+sVtV1aEgblXNwQsTA/AaoApBNdJgddxVDTL5YGSMU36zugQj
         bvtWr3gKbOEDypLzgxP+N5m7FC7ZePouNYr0E=
Received: by 10.216.150.219 with SMTP id z69mr156019wej.75.1283775726998;
        Mon, 06 Sep 2010 05:22:06 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155554>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/bundle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 80649ba..f92970f 100644
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
1.7.2.3.313.gcd15
