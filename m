From: Pascal Obry <pascal.obry@gmail.com>
Subject: [PATCH] Add prefix oriented completions for diff and format-patch commands.
Date: Sun,  6 Apr 2008 18:56:08 +0200
Message-ID: <1207500968-792-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 06 18:57:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiYB7-0007Gj-WD
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 18:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbYDFQ4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 12:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbYDFQ4S
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 12:56:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:54467 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbYDFQ4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 12:56:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so360173nfb.21
        for <git@vger.kernel.org>; Sun, 06 Apr 2008 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=cQyelmRC9JazmTZjhG37xGWjBMzVflheSVz4jYNXZvA=;
        b=HIxcTda0CWj0i1+ZZ3BvblvJDF0TYy96/0eVv5f03ZP66GlUA4LPF0d8AUzn/Mw9WDVDxyJeTZSoFr0GMPrJ61SWHEq+DK/mZBLwCTouE2EDPCEmnvOuoQDWsMVd8i/2rygb8eSbgC0ZK5cuWTjQrJ6QC3QfFYH3J2HYt34vltQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=pSPh6/FOvrYrJrPxM+tUEgSVnhY9bzkFTyi5jFQi1qMstBMScncnHQxmOcdtyyqkcqVpXXM6VkzfZtC5Zszs4YGrlepDweJf6JKFMOXFeCYJq90VkYuaZIIglk1EaEU1lTtj4Y3p9zBuM+D2W0mkfulAyMR0sx+n1iD1OoXaBPU=
Received: by 10.78.173.20 with SMTP id v20mr8872798hue.22.1207500975756;
        Sun, 06 Apr 2008 09:56:15 -0700 (PDT)
Received: from pascal.obry@gmail.com ( [82.124.251.208])
        by mx.google.com with ESMTPS id 7sm19474888nfv.18.2008.04.06.09.56.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Apr 2008 09:56:15 -0700 (PDT)
Received: by pascal.obry@gmail.com (sSMTP sendmail emulation); Sun, 06 Apr 2008 18:56:08 +0200
X-Mailer: git-send-email 1.5.5.rc2.6.gf58d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78898>

Signed-off-by: Pascal Obry <pascal@obry.net>
---
 contrib/completion/git-completion.bash |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 791e30f..618d278 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -639,7 +639,9 @@ _git_diff ()
 			--find-copies-harder --pickaxe-all --pickaxe-regex
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --exit-code --quiet --ext-diff
-			--no-ext-diff"
+			--no-ext-diff
+			--no-prefix --src-prefix= --dst-prefix=
+			"
 		return
 		;;
 	esac
@@ -696,6 +698,7 @@ _git_format_patch ()
 			--full-index --binary
 			--not --all
 			--cover-letter
+			--no-prefix --src-prefix= --dst-prefix=
 			"
 		return
 		;;
-- 
1.5.5.rc2.6.gf58d
