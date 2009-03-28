From: =?utf-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [PATCH 1/4] Documentation: enhance branch.<name>.{remote,merge}
Date: Sun, 29 Mar 2009 00:10:01 +0100
Message-ID: <1238281804-30290-2-git-send-email-santi@agolina.net>
References: <1238281804-30290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 00:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnhgr-0002uR-Q2
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 00:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbZC1XKY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Mar 2009 19:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbZC1XKW
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 19:10:22 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:10007 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbZC1XKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 19:10:20 -0400
Received: by mu-out-0910.google.com with SMTP id g7so629764muf.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 16:10:17 -0700 (PDT)
Received: by 10.103.214.8 with SMTP id r8mr1004638muq.6.1238281817322;
        Sat, 28 Mar 2009 16:10:17 -0700 (PDT)
Received: from localhost (p5B0D7403.dip.t-dialin.net [91.13.116.3])
        by mx.google.com with ESMTPS id 7sm5975462mup.19.2009.03.28.16.10.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 16:10:17 -0700 (PDT)
X-Mailer: git-send-email 1.6.1.258.g7ff14
In-Reply-To: <1238281804-30290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114988>

The documentation for branch.*.merge is very dense, so add a simple
explanation on top of it.

And branch.*.remote also afects 'git push'. Text taken from
'push.default'.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 Documentation/config.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 089569a..56f0cd7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -473,10 +473,14 @@ branch.autosetuprebase::
 	This option defaults to never.
=20
 branch.<name>.remote::
-	When in branch <name>, it tells 'git-fetch' which remote to fetch.
-	If this option is not given, 'git-fetch' defaults to remote "origin".
+	When in branch <name>, it tells 'git-fetch' and 'git-push' which
+	remote to fetch/push, and defaults to `origin` if no remote is
+	configured. `origin` is also used if you are not on any branch.
=20
 branch.<name>.merge::
+	It defines, together with branch.<name>.remote, the tracking branch
+	for the current branch. It tells 'git-fetch'/'git-pull' which
+	branch to merge.
 	When in branch <name>, it tells 'git-fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
 	handled like the remote part of a refspec, and must match a
--=20
1.6.1.258.g7ff14
