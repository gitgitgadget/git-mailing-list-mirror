From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] completion: add missing options to show-branch and show
Date: Sat, 16 May 2009 20:42:43 -0700
Message-ID: <1242531763-23987-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 17 05:43:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5XHJ-0000qA-4S
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 05:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754615AbZEQDms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 23:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755206AbZEQDmr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 23:42:47 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:63913 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756856AbZEQDmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 23:42:46 -0400
Received: by rv-out-0506.google.com with SMTP id f6so608467rvb.5
        for <git@vger.kernel.org>; Sat, 16 May 2009 20:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=LIzQWqxjXeQCwvER1qFYuesvdorNhQU//XsrxFXjFys=;
        b=cQJdWrht43UOcyv4/bO3Au7du0Ox0jbBfEAbgl8PA6zI5QAFjQsnDrUHc6jBlDRTrA
         vqxmnwpTEENHaBLW57Spg5mFU/4HxBTRAUSAgqvn9QBgIk0z7N8wAPlvULKwLPhBn0eF
         8UkB1NRor07qglk85UZYd5U8YLmG2cewjULkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=p2qZLjlwuSqQcCS4XN6UmkBD2MmHk6Qr9XWWQN2rOi55t4icCgNbDnC5bMUKEUViMl
         ocm2sxjlUjoPGkDOdM/wsFpW3LIxufBz5m/uJvpZYIXzvTf3WbehLti0VVgqMYf701x6
         JvSSvuq4cs2uwii2zRDO7uaeddxti2aYY+1ak=
Received: by 10.141.115.20 with SMTP id s20mr2012085rvm.93.1242531767325;
        Sat, 16 May 2009 20:42:47 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id k37sm8991880rvb.38.2009.05.16.20.42.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 20:42:46 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 16 May 2009 20:42:44 -0700
X-Mailer: git-send-email 1.6.3.1.9.g95405b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119384>

Add --oneline and --abbrev-commit to show and --sparse to show-branch.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad26b7c..50eda85 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1825,7 +1825,7 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format=
+		__gitcomp "--pretty= --format= --abbrev-commit --oneline
 			$__git_diff_common_options
 			"
 		return
@@ -1842,7 +1842,7 @@ _git_show_branch ()
 		__gitcomp "
 			--all --remotes --topo-order --current --more=
 			--list --independent --merge-base --no-name
-			--sha1-name --topics --reflog
+			--sha1-name --sparse --topics --reflog
 			"
 		return
 		;;
-- 
1.6.3.1.9.g95405b
