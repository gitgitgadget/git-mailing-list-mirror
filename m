From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] gitremote-helpers.txt: rename from git-remote-helpers.txt
Date: Thu, 31 Jan 2013 20:08:14 +0000
Message-ID: <fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
References: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 21:15:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10Xn-0005I4-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab3AaUPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:15:14 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:50700 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3AaUPM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:15:12 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2013 15:15:12 EST
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D1728161E410;
	Thu, 31 Jan 2013 20:09:02 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pl6OmH5lmPBJ; Thu, 31 Jan 2013 20:09:00 +0000 (GMT)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 8B942161E3CC;
	Thu, 31 Jan 2013 20:08:54 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.1
In-Reply-To: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215163>

When looking up a topic via "git help <topic>", git-help prepends "git-"
to topics that are the names of commands (either builtin or found on the
path) and "git" (no hyphen) to any other topic name.

"git-remote-helpers" is not the name of a command, so "git help
remote-helpers" looks for "gitremote-helpers" and does not find it.

Fix this by renaming "git-remote-helpers.txt" to
"gitremote-helpers.txt".

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Wed, Jan 30, 2013 at 12:28:49PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> >
> > Does this mean that "git-remote-helpers.txt" should lose the first
> > hyphen or is help.c not being clever enough in some way?
> 
> I think it is the former.  "git help tutorial" works exactly the
> same way.

This is the patch to rename it to "gitremote-helpers.txt".

Would we want to do something to avoid breaking links to the existing
document as well?

 Documentation/git-remote-testgit.txt                            | 2 +-
 Documentation/{git-remote-helpers.txt => gitremote-helpers.txt} | 6 +++---
 Documentation/urls.txt                                          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename Documentation/{git-remote-helpers.txt => gitremote-helpers.txt} (99%)

diff --git a/Documentation/git-remote-testgit.txt b/Documentation/git-remote-testgit.txt
index 612a625..f791d73 100644
--- a/Documentation/git-remote-testgit.txt
+++ b/Documentation/git-remote-testgit.txt
@@ -23,7 +23,7 @@ The best way to learn more is to read the comments and source code in
 
 SEE ALSO
 --------
-linkgit:git-remote-helpers[1]
+linkgit:gitremote-helpers[1]
 
 GIT
 ---
diff --git a/Documentation/git-remote-helpers.txt b/Documentation/gitremote-helpers.txt
similarity index 99%
rename from Documentation/git-remote-helpers.txt
rename to Documentation/gitremote-helpers.txt
index e36fdcb..0c91aba 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -1,9 +1,9 @@
-git-remote-helpers(1)
-=====================
+gitremote-helpers(1)
+====================
 
 NAME
 ----
-git-remote-helpers - Helper programs to interact with remote repositories
+gitremote-helpers - Helper programs to interact with remote repositories
 
 SYNOPSIS
 --------
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 539c0a0..3ca122f 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -55,7 +55,7 @@ may be used:
 
 where <address> may be a path, a server and path, or an arbitrary
 URL-like string recognized by the specific remote helper being
-invoked. See linkgit:git-remote-helpers[1] for details.
+invoked. See linkgit:gitremote-helpers[1] for details.
 
 If there are a large number of similarly-named remote repositories and
 you want to use a different format for them (such that the URLs you
-- 
1.8.1.1
