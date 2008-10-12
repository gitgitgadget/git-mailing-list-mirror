From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/4] Tutorial: Explain diffs a little bit better
Date: Sun, 12 Oct 2008 17:11:39 +0200
Message-ID: <20081012151139.17648.28282.stgit@yoghurt>
References: <20081012150825.17648.3315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 12 17:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2cz-0004du-Ug
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753875AbYJLPLo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Oct 2008 11:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbYJLPLo
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:11:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1051 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753827AbYJLPLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:11:43 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Kp2ba-0006Wb-00; Sun, 12 Oct 2008 16:11:38 +0100
In-Reply-To: <20081012150825.17648.3315.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98030>

Say that we use unified diffs, and point to the Wikipedia article
about them. We should probably explain this in more detail ourselves
when we get a proper user guide; but for the tutorial, this is
probably enough.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/tutorial.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 103f3e4..e9d8b22 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -103,10 +103,11 @@ And voil=C3=A0 -- the patch is no longer empty:
            _main()
        finally:
=20
-(I'm assuming you're already familiar with patches like this from Git,
-but it's really quite simple; in this example, I've added the +$$print
-'My first patch!'$$+ line to the file +stgit/main.py+, at around line
-171.)
+(I'm assuming you're already familiar with
+htmllink:http://en.wikipedia.org/wiki/Diff#Unified_format[unified
+diff] patches like this from Git, but it's really quite simple; in
+this example, I've added the +$$print 'My first patch!'$$+ line to the
+file +stgit/main.py+, at around line 171.)
=20
 Since the patch is also a regular Git commit, you can also look at it
 with regular Git tools such as manlink:gitk[].
