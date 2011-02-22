From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 30/73] gettextize: git-commit advice messages
Date: Tue, 22 Feb 2011 23:41:49 +0000
Message-ID: <1298418152-27789-31-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uH-0008HI-Dp
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755381Ab1BVXoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:08 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab1BVXoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:02 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=4upcn2kVvqsAWVPNDofeuZOPCDfkdRRNe0uXhujRLtg=;
        b=Lna/QCDdkc8ZPurfIpkdtNYGEoeikx8mZrL9FAj6GCFiodMCxcJAYcr1nlHckjzu8K
         5ymCJketPBFKm5TYGLn751mujqWlN58eKsXD4llixdbPkp0ejJ4ENJyhPQ8NUP22a8iW
         jgeRjL/xUtU/igFv8s0NJQA8VZPS9eElvibtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=wnP/qwu9BcPNSUGPdS7nAfDd3AxalNUjOtKx5OZ86eKAkUC9iaIr1mlsN7VeybQtSC
         hfGl+me3xrizMR6+urMd3sTTMmmXpOCPcc3Uk4J/qX/bR8TyVvLW3iIzR0cacWzUSXAI
         gxSioolkIc6eGSCSXHclvktZ8caIpMSX8euqg=
Received: by 10.204.59.140 with SMTP id l12mr2994528bkh.2.1298418241343;
        Tue, 22 Feb 2011 15:44:01 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.00
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:00 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167600>

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
