From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 42/72] gettextize: git-merge "Wonderful" message
Date: Sat, 19 Feb 2011 19:24:25 +0000
Message-ID: <1298143495-3681-43-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTo-0003Eb-Ru
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab1BST2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:10 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46654 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068Ab1BST2C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:02 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347171eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=vui18mHec7siRWqFwwX5/89iVowXSYIvyTE8LvzwrzA=;
        b=PjGl/4F5XVxWpikT2RdOz0XdlaUb7VNtNSVjPweNbxUmsC+3Y4vm8nAZgzF529tRab
         +S0kSzk4ghEtvvx2dz0Cset6q1lDfSZ9j3EH9W0t2WJvmIy+la19NNWFaLk6xec64Mki
         qngKGSn1P81vl4o7RGosWHto8LFwS5cX8cWBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KEuoIxeqeKbkMx7g8Ads1qZGBG1Hl3m0bO9A+ciH8ESiEKAbF6IMB18fhpS7TXeOib
         wqi1z7smB9J7MOKHNe6JDflqXd3n0etKNKQyBCuXJIfqeusL/Is0xF40q8oEg9gXr3HB
         vpryvH8Y4x0h1hLZPQFccXA6R/cEhtUiQyu5M=
Received: by 10.14.136.17 with SMTP id v17mr2500821eei.29.1298143681833;
        Sat, 19 Feb 2011 11:28:01 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.01
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:01 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167336>

Gettextize the "Wonderful" message. A test in t7600-merge.sh
explicitly checked for this message. Change it to skip under
GETTEXT_POISON=3DYesPlease.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/merge.c  |    2 +-
 t/t7600-merge.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 4f6b34f..f998206 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -803,7 +803,7 @@ static int merge_trivial(void)
 	struct commit_list *parent =3D xmalloc(sizeof(*parent));
=20
 	write_tree_trivial(result_tree);
-	printf("Wonderful.\n");
+	printf(_("Wonderful.\n"));
 	parent->item =3D lookup_commit(head);
 	parent->next =3D xmalloc(sizeof(*parent->next));
 	parent->next->item =3D remoteheads->item;
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b147a1b..3aafdda 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -495,7 +495,7 @@ test_expect_success 'merge fast-forward in a dirty =
tree' '
=20
 test_debug 'git log --graph --decorate --oneline --all'
=20
-test_expect_success 'in-index merge' '
+test_expect_success NO_GETTEXT_POISON 'in-index merge' '
 	git reset --hard c0 &&
 	git merge --no-ff -s resolve c1 >out &&
 	grep "Wonderful." out &&
--=20
1.7.2.3
