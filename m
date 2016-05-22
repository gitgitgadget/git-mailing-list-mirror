From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/6] git-worktree.txt: keep subcommand listing in alphabetical order
Date: Sun, 22 May 2016 16:33:53 +0700
Message-ID: <20160522093356.22389-4-pclouds@gmail.com>
References: <20160510141416.GA22672@lanh>
 <20160522093356.22389-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 11:34:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4PmX-0001M5-Oe
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 11:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbcEVJem convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 May 2016 05:34:42 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35195 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbcEVJek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 05:34:40 -0400
Received: by mail-pa0-f66.google.com with SMTP id rw9so15069700pab.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4hAJ0UzVQzVTF39aqwVULovum2lBBNQqQDGShJVZrA=;
        b=uZlHvfcw9zG8qDwrDh1hsN4uTP0pMNkjNTytBg0fSqf4H24XQwfFQOhSu3hKI2pK3i
         d9lXRBBbT/LfqSPMIGw3W146IGF50KVmzG9TPIJ6bimErJF0W1Uc/KuhVH/PKDQtEdAo
         u9DiUXRkZYSLHi7myectInoUwwxxwgfMdhx3KebgT2UY370QbwNHXz3SqDPDdDiONACu
         DgUoRy/ARrzziSYmeyaXtQI+6vIacK2tRbFvguSTPS/23Hf2T6Alx05HElrua7yDfASi
         J2VK/zaKqZ23xwaWsm/CEemhN71w8IOxxd63hV/uWSKyDTInmj+gfItuE+sshudsSsfk
         e6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4hAJ0UzVQzVTF39aqwVULovum2lBBNQqQDGShJVZrA=;
        b=LNsTyEuT7xp6gvpte5bF1r7DPDqo0LCXXt55kzNDw1ttuelJPpJ3s6i70yuECS+lEB
         I1pN5jT827TwQlQ96SRV1bPaGzaFSONhn33FKc3oGBV14INBgrQT517G0c7wKUiiPmBx
         0jfU6F+auZ9bf1PYIS9FEyphvwnVvpnaJlrM4F2mQaBRtKPdAWxrBLahW+Rbg9lPncYc
         Hwdx+g7KpogHHMLoLl5mQtSFIfR4lZININZ0RPk0EYm0CWvojVw2ksz7HmYRrM/Y7fQ2
         Ph1MtgQcMtaZBPQIrixzM3HVzYrvYm/mtWf7EbGjxxmhX/uFhVDMrusCLWz2H94tMzWz
         6Tqw==
X-Gm-Message-State: AOPr4FWKeMWRHzprL5s8d3ZGcvusT/T6mShmiSVIiXjSjzs1vuBREMXxom8lz2t4w7bdcg==
X-Received: by 10.66.193.133 with SMTP id ho5mr18821353pac.134.1463909680152;
        Sun, 22 May 2016 02:34:40 -0700 (PDT)
Received: from ash ([171.232.119.25])
        by smtp.gmail.com with ESMTPSA id 64sm38633692pfk.69.2016.05.22.02.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 May 2016 02:34:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 22 May 2016 16:34:35 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160522093356.22389-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295263>

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
