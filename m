From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 09/26] git-worktree.txt: keep subcommand listing in alphabetical order
Date: Tue, 16 Feb 2016 20:29:10 +0700
Message-ID: <1455629367-26193-10-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhz-00030x-0Z
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbcBPNaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:30:13 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35944 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330AbcBPNaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:30:09 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so103480035pab.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P3yO7PNRBqLZyPgWn6rJznbBkaX+k1gJiRRc4ohmII4=;
        b=w3znOAqZWGGh0fPXutL9E82CxgFoCocnMLa5nlyKPEu21zhSgOJrRMHELl99LjpIT3
         0DUSdGFLCtYG/RjtGWtTvQvhEpbNPyfuwm8DXkwI+4zHiIYzPt4SBAep19uuv0+Hr8/d
         TuD32d10UcJOiRa6ThPzeTMuFsshZemoou7rleZQuFS5DpQvRNVaLsjDQ0OdPiFyqkmX
         bk2ewkH4sapc9x9J+OjcwKhEiB77/4ZxgVl+3DJXC/GiJjQgqvBRNYDm6anF4QDO+vpB
         Gyd5AtCwp1JUWAZlWzSEUfEXrsi1eJZ7WDz3vNET3Yi8dyR+pIYdDANmj0Wzna9FEmQD
         AYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=P3yO7PNRBqLZyPgWn6rJznbBkaX+k1gJiRRc4ohmII4=;
        b=efr996d2EHmylFbjpgb5NTCNg4nRTg5QlgYQOwPQUMreNglJPMQ/QW/LpdUEsZ/pQg
         OuVYJ/sm+0oOT8jRpTQMtRxZkZUSr3D7wY+BMUbFSKeEZR8346Y4Atuy+ePmiXTvtYtB
         XfnRx1M9VEs5frqLhV5fEk3DwUFHqAQfAkfwiG5hY3+Ujjs+jP2u3LjvlNqZ5QuSRpRH
         QjKt4ZHxwthJlcDu3e2yDxyFY9GC8JNF8kA2CVGhyc3WYFUWFRXXKXoeJ9+Z4hSO3TOa
         pH3AzhoxcEwrBOXiZ9Ka5eDi0wKcQ2Tarw98QQBl6KFcdmct7HpCCh7gwqDXIdmqpIu0
         TKcw==
X-Gm-Message-State: AG10YOSE6sigO2j5pIFC15zFiM71i70H3RAAgWFZ2nENy3Kq/GIvLuQjTcEYilr5GvSnUg==
X-Received: by 10.66.121.10 with SMTP id lg10mr11286599pab.59.1455629408885;
        Tue, 16 Feb 2016 05:30:08 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id sm8sm46034011pac.43.2016.02.16.05.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:30:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:32 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286375>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-worktree.txt | 10 +++++-----
 builtin/worktree.c             |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktre=
e.txt
index 62c76c1..1c9d7c1 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
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
index 475b958..68341e4 100644
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
2.7.0.377.g4cd97dd
