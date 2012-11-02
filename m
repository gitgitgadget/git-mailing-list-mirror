From: Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] commit: fixup misplacement of --no-post-rewrite description
Date: Fri, 02 Nov 2012 13:26:47 +0100
Message-ID: <m2hap88a2g.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 13:27:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUGLs-0006br-L1
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 13:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052Ab2KBM0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 08:26:52 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:48074 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab2KBM0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 08:26:51 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XtMwT4d1Sz4KK2y
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 13:26:47 +0100 (CET)
X-Auth-Info: 6Y44mMvYcQ/U0e2ntmYvfsSs+Z37Tk7E2mg3PgVdtBk=
Received: from igel.home (ppp-93-104-133-10.dynamic.mnet-online.de [93.104.133.10])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XtMwR6bdNzbbnj
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 13:26:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 8E007CA2A2; Fri,  2 Nov 2012 13:26:47 +0100 (CET)
X-Yow: I just put lots of the EGG SALAD in the SILK SOCKS --
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208924>

In e858af6 (commit: document a couple of options) the description of the
--no-post-rewrite option was put inside the paragraph for the --amend
option.  Move it down after the paragraph.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 Documentation/git-commit.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 9594ac8..28a5aeb 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -193,10 +193,6 @@ OPTIONS
 	current tip -- if it was a merge, it will have the parents of
 	the current tip as parents -- so the current top commit is
 	discarded.
-
---no-post-rewrite::
-	Bypass the post-rewrite hook.
-
 +
 --
 It is a rough equivalent for:
@@ -213,6 +209,9 @@ You should understand the implications of rewriting history if you
 amend a commit that has already been published.  (See the "RECOVERING
 FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
+--no-post-rewrite::
+	Bypass the post-rewrite hook.
+
 -i::
 --include::
 	Before making a commit out of staged contents so far,
-- 
1.8.0


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
