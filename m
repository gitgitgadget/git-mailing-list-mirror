From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] commit: document a couple of options
Date: Fri,  8 Jun 2012 15:48:30 +0530
Message-ID: <1339150710-12281-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:21:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScwJh-0002ef-B5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 12:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762073Ab2FHKVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 06:21:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42955 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab2FHKVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 06:21:09 -0400
Received: by dady13 with SMTP id y13so2159216dad.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer;
        bh=74M7vLYVqAU8KCQAKJGZAmUN3YM3ACOf/AIP2QtEu/E=;
        b=IknBSPHwoomdML7SVCo7eiqQV+1ccmUEnzAT052IyW/Q4mOFQhjhBVQTMpKTD9NoGV
         D9CXiMomZVYtuhMYa1cDmRu1W0fhsOhvKv5NXlh4+N9VJQ9qRFzn7Q2uxn+vlO4nQEu6
         DjTdQTreRLisiltF520NVTdTtUHMdd0JbKLDck9u81ctzqkI5dkPKfo3fzbPRGgb9Lkm
         acQFGbCeLT2k3Z5ENCNFjVUiO4jb3KdMxREOdIPvxUHmQ9TDNM6nhxpN1SEvtTlbSTU7
         /VQKuwP02ekqeYsXDXH3k71EVwg3Y/rZonjrTsOIX2fJBRthOqXXJ/LUpEczVygnlXIV
         ORaw==
Received: by 10.68.227.197 with SMTP id sc5mr19324098pbc.58.1339150868654;
        Fri, 08 Jun 2012 03:21:08 -0700 (PDT)
Received: from localhost.localdomain ([122.174.108.158])
        by mx.google.com with ESMTPS id of1sm7392899pbb.15.2012.06.08.03.21.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2012 03:21:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199480>

Document git commit '--branch' and '--no-post-rewrite'.  Mention that
'-z' can also be spelt as '--null'.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 I noticed this while reading through builtin/commit.c.

 Documentation/git-commit.txt |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 2d695f6..f400835 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -101,12 +101,16 @@ OPTIONS
 	When doing a dry-run, give the output in the short-format. See
 	linkgit:git-status[1] for details. Implies `--dry-run`.
 
+--branch::
+	Show the branch and tracking info even in short-format.
+
 --porcelain::
 	When doing a dry-run, give the output in a porcelain-ready
 	format. See linkgit:git-status[1] for details. Implies
 	`--dry-run`.
 
 -z::
+--null::
 	When showing `short` or `porcelain` status output, terminate
 	entries in the status output with NUL, instead of LF. If no
 	format is given, implies the `--porcelain` output format.
@@ -189,6 +193,10 @@ OPTIONS
 	current tip -- if it was a merge, it will have the parents of
 	the current tip as parents -- so the current top commit is
 	discarded.
+
+--no-post-rewrite::
+	Bypass the post-rewrite hook.
+
 +
 --
 It is a rough equivalent for:
-- 
1.7.10
