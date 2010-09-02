From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 02/25] gettextize: git-commit formatting messages
Date: Thu,  2 Sep 2010 19:40:23 +0000
Message-ID: <1283456446-22577-3-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFf6-0005iA-Q7
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756205Ab0IBTlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0IBTlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:09 -0400
Received: by wwj40 with SMTP id 40so1282223wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=TscQc4QT10/89TZ1fKW6hKF3o12WF+7WRGQroVaowsM=;
        b=AJc4xHHppbVeGVsVP/3KPpixua1tERIxpTeH9npP3K6szNRLqdX9q/TbwfLADOz5t1
         2/wIcriI4S+YStc/4Bj63jlZnkakYRfjmGX4YahYtqSDOD1BYR8f0kgRgXlsblKlOuFo
         KEd2ol7XbuRrOO6xuIiMmBE+dK240GbJcWre4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=MPTyV7rg657TFtZXw91QLrKV//jV6aA911j0ksAwwF3VXNkSkGho9I8d4DOtaxxUhh
         TgsGGHTZHRiWG5hUMn9g2UyqvsO+U92wGub+QgdaKUJOpv424iOKFAOJp+cUwaoH3u6X
         9RjNBaZ9sJIpPq4R7sPHqYswGeIuBS8GD9E+I=
Received: by 10.227.27.214 with SMTP id j22mr155439wbc.72.1283456468452;
        Thu, 02 Sep 2010 12:41:08 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.07
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155162>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cabf6e3..3fd479d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -647,28 +647,28 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
=20
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
-			"\n"
-			"# Please enter the commit message for your changes.");
+			_("\n"
+			"# Please enter the commit message for your changes."));
 		if (cleanup_mode =3D=3D CLEANUP_ALL)
 			fprintf(fp,
-				" Lines starting\n"
+				_(" Lines starting\n"
 				"# with '#' will be ignored, and an empty"
-				" message aborts the commit.\n");
+				" message aborts the commit.\n"));
 		else /* CLEANUP_SPACE, that is. */
 			fprintf(fp,
-				" Lines starting\n"
+				_(" Lines starting\n"
 				"# with '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
-				"# An empty message aborts the commit.\n");
+				"# An empty message aborts the commit.\n"));
 		if (only_include_assumed)
 			fprintf(fp, "# %s\n", only_include_assumed);
=20
@@ -677,16 +677,16 @@ static int prepare_to_commit(const char *index_fi=
le, const char *prefix,
 					   getenv("GIT_COMMITTER_EMAIL"));
 		if (strcmp(author_ident, committer_ident))
 			fprintf(fp,
-				"%s"
-				"# Author:    %s\n",
+				_("%s"
+				"# Author:    %s\n"),
 				ident_shown++ ? "" : "#\n",
 				author_ident);
 		free(author_ident);
=20
 		if (!user_ident_sufficiently_given())
 			fprintf(fp,
-				"%s"
-				"# Committer: %s\n",
+				_("%s"
+				"# Committer: %s\n"),
 				ident_shown++ ? "" : "#\n",
 				committer_ident);
=20
@@ -1182,9 +1182,9 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1)
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
 			!strcmp(head, "HEAD") ?
-				"detached HEAD" :
+		   		_("detached HEAD") :
 				head,
-		initial_commit ? " (root-commit)" : "");
+		initial_commit ? _(" (root-commit)") : "");
=20
 	if (!log_tree_commit(&rev, commit)) {
 		rev.always_show_header =3D 1;
--=20
1.7.2.2.614.g1dc9
