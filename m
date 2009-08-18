From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] filter-branch: make the usage string fit on 80 chars terminals.
Date: Tue, 18 Aug 2009 11:51:00 +0200
Message-ID: <1250589060-17808-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 18 11:51:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdLLj-0003bV-JO
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbZHRJvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751994AbZHRJvT
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:51:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45586 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbZHRJvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 05:51:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7I9mJC2009135
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Aug 2009 11:48:19 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MdLLJ-0005nf-Od; Tue, 18 Aug 2009 11:51:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MdLLJ-0004dn-Ml; Tue, 18 Aug 2009 11:51:01 +0200
X-Mailer: git-send-email 1.6.4.171.g24636.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Aug 2009 11:48:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7I9mJC2009135
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251193700.24387@RsEpUW6gvnp0Y4oXkCmXsg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126366>

It used to be a single, huge line, badly wrapped by xterm.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-filter-branch.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 37e044d..a480d6f 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -97,12 +97,12 @@ set_ident () {
 	echo "case \"\$GIT_${uid}_NAME\" in \"\") GIT_${uid}_NAME=\"\${GIT_${uid}_EMAIL%%@*}\" && export GIT_${uid}_NAME;; esac"
 }
 
-USAGE="[--env-filter <command>] [--tree-filter <command>] \
-[--index-filter <command>] [--parent-filter <command>] \
-[--msg-filter <command>] [--commit-filter <command>] \
-[--tag-name-filter <command>] [--subdirectory-filter <directory>] \
-[--original <namespace>] [-d <directory>] [-f | --force] \
-[<rev-list options>...]"
+USAGE="[--env-filter <command>] [--tree-filter <command>]
+            [--index-filter <command>] [--parent-filter <command>]
+            [--msg-filter <command>] [--commit-filter <command>]
+            [--tag-name-filter <command>] [--subdirectory-filter <directory>]
+            [--original <namespace>] [-d <directory>] [-f | --force]
+            [<rev-list options>...]"
 
 OPTIONS_SPEC=
 . git-sh-setup
-- 
1.6.4.171.g24636.dirty
