From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 43/73] gettextize: git-merge "Wonderful" message
Date: Tue, 22 Feb 2011 23:42:02 +0000
Message-ID: <1298418152-27789-44-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w7-0000rs-RC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755731Ab1BVXqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:12 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1BVXoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:16 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=zgMXYFcizNplTsxKqPQ89dNZ/z+htz+RSlu40iuXTPk=;
        b=Yl3MmX2rpugAQJO+zlJqR7JsC8fPEKWd+gj8BFA6SUkpq6rZoABKAXYgXJRShv0XA+
         b4/d36OcFe8KCLdAAS2FxC2cCCHrCd7rcaCxngfrtlN/r2+o39unKORnZEDhBcIYgonP
         0djZ6zOm1wrqYzZh0aHw9hTcYKhrF9YGDKB1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IwbC+zjObrpUS9Ub4IhtiOxzGp28Mbz1nb6J/6TsP0+IKfSHVq8rGG5AyY25ffr9Qd
         tvNE4TbDewAHWZBsMZAVxHZmJEUovdj7kPiIMeT0OH22EWjyNs3wGOxGGCLEiCC4NJEI
         eBgCqH/r7HQ8kthdW+RtNtNYCp/TnFVq70JEU=
Received: by 10.204.51.145 with SMTP id d17mr3101242bkg.24.1298418255586;
        Tue, 22 Feb 2011 15:44:15 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.14
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:15 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167633>

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
index b147a1b..87d5d78 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -495,7 +495,7 @@ test_expect_success 'merge fast-forward in a dirty =
tree' '
=20
 test_debug 'git log --graph --decorate --oneline --all'
=20
-test_expect_success 'in-index merge' '
+test_expect_success C_LOCALE_OUTPUT 'in-index merge' '
 	git reset --hard c0 &&
 	git merge --no-ff -s resolve c1 >out &&
 	grep "Wonderful." out &&
--=20
1.7.2.3
