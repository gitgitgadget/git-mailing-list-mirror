From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 29/72] gettextize: git-commit advice messages
Date: Sat, 19 Feb 2011 19:24:12 +0000
Message-ID: <1298143495-3681-30-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTk-0003Eb-CT
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab1BST1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:52 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1BST1t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:49 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=4upcn2kVvqsAWVPNDofeuZOPCDfkdRRNe0uXhujRLtg=;
        b=KwdiEctZWRgZvsOtke1m3W0t163G7a9akSnigQsYwlT7eWuvTGZr8r/1PqihKKIZ2R
         /Ssiygp5kf1KWUdI/3zqOI9iMIXbN53nDsicIU3kVl+t091RSSn/UOv9QfWSHe1RB7+G
         ZagibpKwk5FPzci1sjBNMrBo1R0/NxvUY0TI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=xctISoKcK5vfLqqfWdzbbHb+h7S3oS8ToghneNMbw7RJzEgdqcl5JLh/DACIyTb6tW
         UWI5EXECV8YCl0RSx7G4BmmtH8BFc/ZtLmCsV4Y28mwOZJPaO3OtBCs8FpvF2usAEbMZ
         +gscxbPph8x533SHpWYTbED1QvrCPmtKrS1tI=
Received: by 10.213.28.73 with SMTP id l9mr2530695ebc.54.1298143669093;
        Sat, 19 Feb 2011 11:27:49 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.48
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:48 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167329>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/commit.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ac8da45..df881d5 100644
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
 "After doing this, you may fix the identity used for this commit with:=
\n"
 "\n"
-"    git commit --amend --reset-author\n";
+"    git commit --amend --reset-author\n");
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
@@ -770,7 +770,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	    !(amend && is_a_merge(head_sha1))) {
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
-			fputs(empty_amend_advice, stderr);
+			fputs(_(empty_amend_advice), stderr);
 		return 0;
 	}
=20
@@ -1197,7 +1197,7 @@ static void print_summary(const char *prefix, con=
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
1.7.2.3
