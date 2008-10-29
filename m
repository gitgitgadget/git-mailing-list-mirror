From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 5/7] Documentation: elaborate on pushing tags
Date: Wed, 29 Oct 2008 21:25:43 +0100
Message-ID: <1225311945-17100-6-git-send-email-mail@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-3-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-4-git-send-email-mail@cup.kalibalik.dk>
 <1225311945-17100-5-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:28:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHeB-0006P1-RW
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:28:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbYJ2UZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754322AbYJ2UZ6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:58 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42700 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754405AbYJ2UZu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:50 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id B806614085;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 1663614080;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1225311945-17100-5-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99409>

Make the description of pushing tags easier to read, but move the
shorthand notation towards the end of the description. This gives
a better flow.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 9788d49..52035db 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -38,7 +38,7 @@ OPTIONS
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-The <src> side represents the source branch that you
+The <src> side represents the source branch or tag that you
 want to push.  The <dst> side represents the destination location.
 +
 The local ref that matches <src> is used
@@ -46,8 +46,6 @@ to fast forward the remote ref that matches <dst>.  If
 the optional leading plus `+` is used, the remote ref is updated
 even if it does not result in a fast forward update.
 +
-`tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
-+
 A parameter <ref> without a colon pushes the <ref> from the source
 repository to the destination repository under the same name.
 +
@@ -64,6 +62,10 @@ nor in any Push line of the corresponding remotes file---see below).
 The <src> can be an arbitrary "SHA1 expression", such as `HEAD`
 or `master~4` (see linkgit:git-rev-parse[1]). In this case, a
 <dst> location has to be named.
++
+When pushing tags, `tag <tag>` can be used as a shorthand for
+`refs/tags/<tag>:refs/tags/<tag>`. This should be specified as
+two arguments (that is, without quotes in the shell).
 
 --all::
 	Instead of naming each ref to push, specifies that all
-- 
1.6.0.2.514.g23abd3
