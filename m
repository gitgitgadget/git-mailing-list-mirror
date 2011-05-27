From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] docs: fix some antique example output
Date: Thu, 26 May 2011 22:33:15 -0400
Message-ID: <20110527023315.GD25362@sigill.intra.peff.net>
References: <30543.1305828072@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 04:33:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPmra-0003Nh-L5
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 04:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649Ab1E0CdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 22:33:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44709
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145Ab1E0CdR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 22:33:17 -0400
Received: (qmail 20788 invoked by uid 107); 27 May 2011 02:33:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 22:33:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 22:33:15 -0400
Content-Disposition: inline
In-Reply-To: <30543.1305828072@plover.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174598>

These diff-index and diff-tree sample outputs date back to
the first month of git's existence. The output format has
changed slightly since then, so let's have it match the
current output.

Signed-off-by: Jeff King <peff@peff.net>
---
I just noticed these while auditing all of the "->" in the docs
directory. I didn't read through the whole text to make sure there were
no other inaccuracies, though.

 Documentation/git-diff-index.txt |    4 ++--
 Documentation/git-diff-tree.txt  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 6d18486..2ea22ab 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -96,8 +96,8 @@ show that. So let's say that you have edited `kernel/sched.c`, but
 have not actually done a 'git update-index' on it yet - there is no
 "object" associated with the new state, and you get:
 
-  torvalds@ppc970:~/v2.6/linux> git diff-index HEAD
-  *100644->100664 blob    7476bb......->000000......      kernel/sched.c
+  torvalds@ppc970:~/v2.6/linux> git diff-index --abbrev HEAD
+  :100644 100664 7476bb... 000000...      kernel/sched.c
 
 i.e., it shows that the tree has changed, and that `kernel/sched.c` has is
 not up-to-date and may contain new stuff. The all-zero sha1 means that to
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 4e5f127..1439486 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -138,8 +138,8 @@ so it can be used to name subdirectories.
 
 An example of normal usage is:
 
-  torvalds@ppc970:~/git> git diff-tree 5319e4......
-  *100664->100664 blob    ac348b.......->a01513.......      git-fsck-objects.c
+  torvalds@ppc970:~/git> git diff-tree --abbrev 5319e4
+  :100664 100664 ac348b... a01513...	git-fsck-objects.c
 
 which tells you that the last commit changed just one file (it's from
 this one:
-- 
1.7.4.5.26.g0c6a2
