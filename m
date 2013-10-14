From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] git-merge: document the -S option
Date: Tue, 15 Oct 2013 01:41:05 +0200
Message-ID: <1381794065-6657-1-git-send-email-boklm@mars-attacks.org>
Cc: Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 01:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVrlX-0004Kj-Nt
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 01:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab3JNXlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 19:41:32 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:56598 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757110Ab3JNXlb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 19:41:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id BE0BE4238
	for <git@vger.kernel.org>; Tue, 15 Oct 2013 01:41:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VQxd8ny4REt1; Tue, 15 Oct 2013 01:41:43 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 2342915CE;
	Tue, 15 Oct 2013 01:41:43 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id BE3D043920; Tue, 15 Oct 2013 01:41:28 +0200 (CEST)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236152>

The option to gpg sign a merge commit is available but was not
documented. Use wording from the git-commit(1) manpage.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 Documentation/git-merge.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index a74c371..c7915a6 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>]
+	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
@@ -65,6 +65,10 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
+	GPG-sign commit.
+
 -m <msg>::
 	Set the commit message to be used for the merge commit (in
 	case one is created).
-- 
1.8.4
