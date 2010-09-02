From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 03/25] gettextize: git-commit advice messages
Date: Thu,  2 Sep 2010 19:40:24 +0000
Message-ID: <1283456446-22577-4-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFf7-0005iA-AR
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab0IBTlQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35561 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0IBTlO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:14 -0400
Received: by wyb35 with SMTP id 35so80782wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HuLBBuaovDCzp5eb3vwVRf4ujyWPqd9fZlLOU97ra7E=;
        b=PQPJAPS6TdtVLDYntGuNrXoXF+l65dfWqMdSop36gZnV3O6KEx/OEbhuBkEn9Etg8M
         M2mBiluXYL+wTWVxYgZkrym8Tw1sOkl2OoZu5nbWdIfYFtL9YTMs9lwncNEc0YHXq4kY
         ED8r3ILr7MqQfVbF4l3+hYnst1DzW9VhpHPlU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qESY3ZH4iDKqPeOzueRTjYP4M/6MukDNC79VQlzSV/84GuIi+BUySxRHrJJaUQs3kO
         tOlGFXBri5671QX0+E798ktgj8TQCaiI4E2ITVCR28rXzIimUXoOJsj9jsWnKWADIRW+
         NFl4gMToCN/qyKcEdIfHPgDDF28E+xolJzZ5Y=
Received: by 10.227.137.193 with SMTP id x1mr308562wbt.80.1283456472571;
        Thu, 02 Sep 2010 12:41:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155164>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3fd479d..3626a8d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -38,7 +38,7 @@ static const char * const builtin_status_usage[] =3D =
{
 };
=20
 static const char implicit_ident_advice[] =3D
-"Your name and email address were configured automatically based\n"
+N_("Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n=
"
 "You can suppress this message by setting them explicitly:\n"
 "\n"
@@ -47,12 +47,12 @@ static const char implicit_ident_advice[] =3D
 "\n"
 "If the identity used for this commit is wrong, you can fix it with:\n=
"
 "\n"
-"    git commit --amend --author=3D'Your Name <you@example.com>'\n";
+"    git commit --amend --author=3D'Your Name <you@example.com>'\n");
=20
 static const char empty_amend_advice[] =3D
-"You asked to amend the most recent commit, but doing so would make\n"
+N_("You asked to amend the most recent commit, but doing so would make=
\n"
 "it empty. You can repeat your command with --allow-empty, or you can\=
n"
-"remove the commit entirely with \"git reset HEAD^\".\n";
+"remove the commit entirely with \"git reset HEAD^\".\n");
=20
 static unsigned char head_sha1[20];
=20
@@ -719,7 +719,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
-			fputs(empty_amend_advice, stderr);
+			fputs(_(empty_amend_advice), stderr);
 		return 0;
 	}
=20
@@ -1156,7 +1156,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1)
 		strbuf_addbuf_percentquote(&format, &committer_ident);
 		if (advice_implicit_identity) {
 			strbuf_addch(&format, '\n');
-			strbuf_addstr(&format, implicit_ident_advice);
+			strbuf_addstr(&format, _(implicit_ident_advice));
 		}
 	}
 	strbuf_release(&author_ident);
--=20
1.7.2.2.614.g1dc9
