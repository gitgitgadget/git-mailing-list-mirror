From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/25] git-worktree.txt: keep subcommand listing in alphabetical order
Date: Wed, 13 Apr 2016 20:15:30 +0700
Message-ID: <1460553346-12985-10-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKf0-0004G4-MW
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760636AbcDMNQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:42 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34758 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760158AbcDMNQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:41 -0400
Received: by mail-pf0-f193.google.com with SMTP id d184so4103488pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=51AMAj7GpxtK/69lvXKFFCVXYP+lfnwTdspawX3kHK4=;
        b=tqSTnyFWvZQ2ldssNgPgMG/p69gnZkyNGOrW84ARF1u5JqAejyMrm4eL2febIS/RvC
         G+WTOOoAzpv6uL2V4/IFkjD7H5/W/Y2/7LEREQ/ssjiyS6r7VROdP5Iau8AKnq9RtIAz
         jMHQT26cFueifJUaSD3SrRG0JgTVqzNxpwWCR3X0JHMVtkfgDU2kxQN/Mrn5Ra1biwwc
         DoRiAdtf5P+Hxiaw8f8miODSQwB0m9CR67nTr+R+gvdc/ivHee5imqNbfybzxQ4vggt6
         XueoeaHdfOBED3vofN+ueg5SRdfb6bkz5666F3dA2CLZMJJKc2OdaxvNy6OwfLJtlcld
         opeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51AMAj7GpxtK/69lvXKFFCVXYP+lfnwTdspawX3kHK4=;
        b=eOTUenxakP4W4+ZxUhkk51iMyqrnw8IpqBBmraAmtt8XKOjMcFU2nNNapFJjtyL43c
         mvqN5XoinXbv8OeK5xj8apcy3gaZnAg7pIKfWxns8CvgN15C3cA5dQVcFJikWGAmmFpa
         UnUBd3gaIixX18Uhn3KNkFUXaCIdLrNhOR5gn79etT8a2JZHFwB4CpP13sCV0NWMbR4b
         pYGGxlPO7lvpcXZS/NUvF9WfdJueQZtYcX1BAgPxkDzyJ83RR7n5BaqpKw0fGqE5da5y
         GtmEPoxgUOk+cTl6XGkPdEKzYvxNGdrXDOkNgT3gkk5nmfBXcahln+iCw5XU3DXrGpUv
         CXAQ==
X-Gm-Message-State: AOPr4FW0+5/zz8JSU2HlSMmOEjxWK3cgWoRRnaMAvyK2oLa1miIx24GGan2z0qkO2KstLg==
X-Received: by 10.98.20.150 with SMTP id 144mr10864042pfu.144.1460553396208;
        Wed, 13 Apr 2016 06:16:36 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id p74sm51184505pfj.22.2016.04.13.06.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:42 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291432>

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
index 38b5609..575f899 100644
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
2.8.0.rc0.210.gd302cd2
