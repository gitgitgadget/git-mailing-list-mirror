From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/7] git-worktree.txt: keep subcommand listing in alphabetical order
Date: Tue, 10 May 2016 21:15:49 +0700
Message-ID: <20160510141553.22967-3-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160510141553.22967-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, rethab.ch@gmail.com,
	rappazzo@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 16:16:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b08So-0007js-Qp
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 16:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbcEJOQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 10:16:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36385 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbcEJOQc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 10:16:32 -0400
Received: by mail-pf0-f193.google.com with SMTP id g132so1063763pfb.3
        for <git@vger.kernel.org>; Tue, 10 May 2016 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4hAJ0UzVQzVTF39aqwVULovum2lBBNQqQDGShJVZrA=;
        b=wD9gNLe45TZHQjKmsb9XT5udIEBo0vWkHF+ufLu/PMwl6qb8OZAhRXWk5sjDSZ7TW1
         8UhZ1U9enQxHhW04IbbtP7Utbdjba6F3oHw3UC8xOsnkl8cmh5SVOsgY7t6/LC9aofxU
         bibNyevsMYKNwRKLQqfue6AC8m91dwb4DhZ3qwodV2CoYkun05kVvyPoMu306zMRMpgN
         IZcffyrg+oim9SM7BtPunJHqvRKY4TqfXwtHXri81mPDVcVEu96uJlT93Q4QFAb1hrxZ
         pIT2Y6v6H2+gct6psaw8c3Lq9YnuMnA3O4xYPnSgc6Vlp/DV5Olj2l+GZ2Vt/+TSUh2m
         plJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4hAJ0UzVQzVTF39aqwVULovum2lBBNQqQDGShJVZrA=;
        b=ULx0QCWyzrr4G4Fb/qUmMGRmesNIBdC6FgTt1RzJigxRjrPMuBRr72bhBRMW8t2wlz
         q+hmMSaHlforh4TI+ngH7L5it8Xm3uk6Aksvauddn/5JlcAaONyN5jkTJwXD0Ilq7WYT
         BWgowGgyECg61QzDml2rIUbaiWLETy6E9cF9GclkkyOLiiL1wzqR9eSjZXJG6SbBtm6N
         wfaKp1zCTxz/DiCACv/6KvjDP0gtrVHZE+gIsukjvVzZaJp272eVV8fOXQe/fChecQex
         vdVSmGx0eBcmq33TezLOvBYwMsy+0U5yJzrD2bcWo+rsrhgkoBHKy6U/fH/wCe7KZl+/
         mzKQ==
X-Gm-Message-State: AOPr4FWJlQWPTbCdIFPVhGFQzRgMfweLvee4WDS2kErpqPDLf8vLyzwMWRxoYhOMAN+Dlw==
X-Received: by 10.98.67.7 with SMTP id q7mr59149339pfa.70.1462889791297;
        Tue, 10 May 2016 07:16:31 -0700 (PDT)
Received: from lanh ([115.76.164.133])
        by smtp.gmail.com with ESMTPSA id v75sm4929592pfa.94.2016.05.10.07.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 07:16:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 May 2016 21:16:32 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160510141553.22967-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294138>

This is probably not the best order. But it makes it no-brainer to know
where to insert new commands. At some point we might want to reorder at
least the synopsis part again, grouping commonly use subcommands togeth=
er.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt | 10 +++++-----
 builtin/worktree.c             |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index c622345..27feff6 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [-b <new-branch>] <pat=
h> [<branch>]
-'git worktree prune' [-n] [-v] [--expire <expire>]
 'git worktree list' [--porcelain]
+'git worktree prune' [-n] [-v] [--expire <expire>]
=20
 DESCRIPTION
 -----------
@@ -54,10 +54,6 @@ If `<branch>` is omitted and neither `-b` nor `-B` n=
or `--detached` used,
 then, as a convenience, a new branch based at HEAD is created automati=
cally,
 as if `-b $(basename <path>)` was specified.
=20
-prune::
-
-Prune working tree information in $GIT_DIR/worktrees.
-
 list::
=20
 List details of each worktree.  The main worktree is listed first, fol=
lowed by
@@ -65,6 +61,10 @@ each of the linked worktrees.  The output details in=
clude if the worktree is
 bare, the revision currently checked out, and the branch currently che=
cked out
 (or 'detached HEAD' if none).
=20
+prune::
+
+Prune working tree information in $GIT_DIR/worktrees.
+
 OPTIONS
 -------
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 12c0af7..bf80111 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -13,8 +13,8 @@
=20
 static const char * const worktree_usage[] =3D {
 	N_("git worktree add [<options>] <path> [<branch>]"),
-	N_("git worktree prune [<options>]"),
 	N_("git worktree list [<options>]"),
+	N_("git worktree prune [<options>]"),
 	NULL
 };
=20
--=20
2.8.2.524.g6ff3d78
