From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 27/73] gettextize: git-commit formatting messages
Date: Tue, 22 Feb 2011 23:41:46 +0000
Message-ID: <1298418152-27789-28-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1wt-0001H8-Up
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab1BVXqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:46:44 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149Ab1BVXn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:59 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=+FaSbSQJPf6X6q6s+b+r3CqFc94CAeVQGs+iMyxR6Cw=;
        b=VdhbzS7pfH0h4a8XJY2EudnQxk2QmjdnKpatY6AdImK46QVjmFgXIKTOgD2Oe8PMwU
         FHlCO/OFuBDJOA2z+4iPvCECqMScE3dDy41Dz/3WqClBip9hDMKlOH/wqqtoFdxm4GAj
         Ry9Zd5Vck1MdibZu3XQqyTUfzCVuUBm/ywx7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=iL4e/bYLMQu8dWxoi8Tp81BdYMYWvTyq8I4jyjlzsEUYQvMso1Dy1rJXIHQq6cNjdf
         OzfcUScNQJoWHlKA+dFa8bCD3k0WEtExGX3/MaANdm4kw5QLNy2cpRMv/pmScn+3SYKR
         Mc1r77nygJth10tRpjqLYc8M1K2HySp4HipIg=
Received: by 10.204.75.193 with SMTP id z1mr2993585bkj.214.1298418238434;
        Tue, 22 Feb 2011 15:43:58 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.57
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:57 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167649>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c  |   12 ++++++------
 t/t7502-commit.sh |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0198e90..c7c6c59 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -696,12 +696,12 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		char *ai_tmp, *ci_tmp;
 		if (in_merge)
 			fprintf(fp,
-				"#\n"
+				_("#\n"
 				"# It looks like you may be committing a MERGE.\n"
 				"# If this is not correct, please remove the file\n"
 				"#	%s\n"
 				"# and try again.\n"
-				"#\n",
+				"#\n"),
 				git_path("MERGE_HEAD"));
=20
 		fprintf(fp,
@@ -725,15 +725,15 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 		ci_tmp =3D cut_ident_timestamp_part(committer_ident.buf);
 		if (strcmp(author_ident->buf, committer_ident.buf))
 			fprintf(fp,
-				"%s"
-				"# Author:    %s\n",
+				_("%s"
+				"# Author:    %s\n"),
 				ident_shown++ ? "" : "#\n",
 				author_ident->buf);
=20
 		if (!user_ident_sufficiently_given())
 			fprintf(fp,
-				"%s"
-				"# Committer: %s\n",
+				_("%s"
+				"# Committer: %s\n"),
 				ident_shown++ ? "" : "#\n",
 				committer_ident.buf);
=20
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 50da034..034b9c3 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -234,7 +234,7 @@ echo "#
 # Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
 #" >> expect
=20
-test_expect_success 'author different from committer' '
+test_expect_success C_LOCALE_OUTPUT 'author different from committer' =
'
=20
 	echo >>negative &&
 	git commit -e -m "sample"
@@ -248,7 +248,7 @@ rm -f expect.tmp
 echo "# Committer:
 #" >> expect
=20
-test_expect_success 'committer is automatic' '
+test_expect_success C_LOCALE_OUTPUT 'committer is automatic' '
=20
 	echo >>negative &&
 	(
--=20
1.7.2.3
