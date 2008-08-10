From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [PATCH v3 2/4] diff-tree: Note that the commit ID is printed with
	--stdin
Date: Sun, 10 Aug 2008 18:12:53 +0200
Message-ID: <20080810161253.7116.79513.stgit@yoghurt>
References: <20080810161035.7116.2171.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 18:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSDZF-00052w-0Z
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 18:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbYHJQNr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 12:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752589AbYHJQNr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 12:13:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3175 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbYHJQNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 12:13:46 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KSDsq-0008Kl-00; Sun, 10 Aug 2008 17:35:08 +0100
In-Reply-To: <20080810161035.7116.2171.stgit@yoghurt>
User-Agent: StGIT/0.14.3.223.g12ca.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91852>

It's sort of already documented with the --no-commit-id command-line
flag, but let's not hide important information from the user.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/git-diff-tree.txt |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)


diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-t=
ree.txt
index 1fdf20d..1f4b91e 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -52,10 +52,14 @@ include::diff-options.txt[]
 	reads either one <commit> or a list of <commit>
 	separated with a single space from its standard input.
 +
-When a single commit is given on one line of such input, it compares
-the commit with its parents.  The following flags further affects its
-behavior.  The remaining commits, when given, are used as if they are
+When a single commit is given, it compares the commit with its
+parents.  The remaining commits, when given, are used as if they are
 parents of the first commit.
++
+The ID of the first (or only) commit, followed by a newline, is
+printed before the differences.
++
+The following flags further affects its behavior.
=20
 -m::
 	By default, 'git-diff-tree --stdin' does not show
