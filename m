From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH] Fix capitalization of "renamelimit" in docs to agree with
 code
Date: Sun, 18 Dec 2011 16:34:52 -0800
Message-ID: <4EEE86AC.2030802@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 01:35:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcRCd-0005WP-14
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 01:35:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab1LSAff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 19:35:35 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:45757 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab1LSAfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 19:35:33 -0500
Received: from homiemail-a54.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 7929F1F6569
	for <git@vger.kernel.org>; Sun, 18 Dec 2011 16:35:34 -0800 (PST)
Received: from homiemail-a54.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a54.g.dreamhost.com (Postfix) with ESMTP id 8AE923A4061;
	Sun, 18 Dec 2011 16:34:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:subject:content-type:
	content-transfer-encoding; q=dns; s=pcharlan.com; b=r+M68xGwhxRG
	xtD7aoaezldbx34HoFIoD6o7mCWm92bPT2E1c7FjpRHe4l2AvFZbaLsZ0XK2KnW/
	yBdQGNELpkrdiJknQ6d9vbf4ziazmHFAoWG3Gde+ug9F5/SzrInDwyiXIq8vNk8s
	O2BM87N+PsUtnb800njRkdMJAEqN/Wc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:subject:content-type:
	content-transfer-encoding; s=pcharlan.com; bh=OiMUJHqL8teBp70+Q2
	OH/jKT6Qk=; b=LPGldO4SwUACjsULwM3dET+3+mz59QwiYiB2Sk2Uc4HKM/RClE
	tf2/vGUk7jfe0EwNEApmd6RQmALMhpsmrgbeH1/EJJtORQ5tQoscq5JTzxMMtc8Z
	gNx72SoY2mgo98O3RlfARfw3et7H8zovvzTm+AKak064YfkM03HFJ99Ek=
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pgit@pcharlan.com)
	by homiemail-a54.g.dreamhost.com (Postfix) with ESMTPSA id 52E6C3A4058;
	Sun, 18 Dec 2011 16:34:53 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111124 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187429>

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
The documentation and bash-completion have always capitalized
"renamelimit" as "renameLimit".  The code has always lowercased the
whole name.  Repair the docs.

 Documentation/diff-config.txt          |    2 +-
 Documentation/merge-config.txt         |    4 ++--
 contrib/completion/git-completion.bash |    4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 1aed79e..1b9a314 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -86,7 +86,7 @@ diff.mnemonicprefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.

-diff.renameLimit::
+diff.renamelimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the 'git diff' option '-l'.

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 861bd6f..fdb3cb6 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -32,10 +32,10 @@ merge.log::
 	actual commits that are being merged.  Defaults to false, and
 	true is a synonym for 20.

-merge.renameLimit::
+merge.renamelimit::
 	The number of files to consider when performing rename detection
 	during a merge; if not specified, defaults to the value of
-	diff.renameLimit.
+	diff.renamelimit.

 merge.renormalize::
 	Tell git that canonical representation of files in the
diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index cc1bdf9..76f66e1 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2122,7 +2122,7 @@ _git_config ()
 		diff.ignoreSubmodules
 		diff.mnemonicprefix
 		diff.noprefix
-		diff.renameLimit
+		diff.renamelimit
 		diff.renames
 		diff.suppressBlankEmpty
 		diff.tool
@@ -2218,7 +2218,7 @@ _git_config ()
 		merge.
 		merge.conflictstyle
 		merge.log
-		merge.renameLimit
+		merge.renamelimit
 		merge.renormalize
 		merge.stat
 		merge.tool
-- 
