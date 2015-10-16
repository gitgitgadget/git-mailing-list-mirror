From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pull: add angle brackets to usage string
Date: Thu, 15 Oct 2015 20:22:13 -0600
Message-ID: <1444962133-1266-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: pyokagan@gmail.com, gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 04:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmuf5-00028F-16
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 04:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbJPCWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 22:22:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36740 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbJPCWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 22:22:22 -0400
Received: by pacfv9 with SMTP id fv9so6573273pac.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 19:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8IZ7fp9NNzUJDvC2/yx6XvEtANg52VUftLJqLJrlU1I=;
        b=JvuvNLdhkha7piTXMBYL3e/NgaV//dlpcPNkBeHSpnmxJgwyUU7P5kIjVX3iD9nkWI
         dX/p2oR527zSHxYPOHiSWy6ZVHkb6+NOuyY0j97lXP5LXpZrI/0VPM4Sg4JbQ8YRkviI
         LWq1H4v41KaVI9J+IHF+Ug3FzItDTxedCRFf8FToaDq3EUI4JojlQqC3Dbw74OYsSq+h
         SrYF0XLv1jgFzkC6ldNBX9fqkgAq0+wi7oJ8RratgzluiDOrNqddYgGuj5hewGPfX0CL
         loaUSz7v+ZumhRa7TCElL9u8Nd8r2R41resrmZ5CrLBcpKWcoQuUDJ84SmuEPikb95X1
         ZQKg==
X-Received: by 10.68.96.67 with SMTP id dq3mr13503248pbb.161.1444962141702;
        Thu, 15 Oct 2015 19:22:21 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id x6sm17890262pbt.3.2015.10.15.19.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 19:22:20 -0700 (PDT)
X-Mailer: git-send-email 2.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279727>

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/pull.c               | 2 +-
 contrib/examples/git-pull.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index a39bb0a..bf3fd3f 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -66,7 +66,7 @@ static int parse_opt_rebase(const struct option *opt, const char *arg, int unset
 }
 
 static const char * const pull_usage[] = {
-	N_("git pull [options] [<repository> [<refspec>...]]"),
+	N_("git pull [<options>] [<repository> [<refspec>...]]"),
 	NULL
 };
 
diff --git a/contrib/examples/git-pull.sh b/contrib/examples/git-pull.sh
index 6b3a03f..bcf362e 100755
--- a/contrib/examples/git-pull.sh
+++ b/contrib/examples/git-pull.sh
@@ -8,7 +8,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_STUCKLONG=Yes
 OPTIONS_SPEC="\
-git pull [options] [<repository> [<refspec>...]]
+git pull [<options>] [<repository> [<refspec>...]]
 
 Fetch one or more remote refs and integrate it/them with the current HEAD.
 --
-- 
2.6.1
