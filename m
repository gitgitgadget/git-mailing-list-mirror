From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/4] Replace "git repo-config" with "git config" in help
	texts
Date: Sun, 26 Aug 2007 22:26:26 +0200
Message-ID: <20070826202626.15933.27528.stgit@yoghurt>
References: <20070826202309.15933.54183.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:27:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOhQ-00068z-Pp
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbXHZU0u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753758AbXHZU0t
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:26:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3260 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbXHZU0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:26:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOgl-0005tA-00; Sun, 26 Aug 2007 21:26:27 +0100
In-Reply-To: <20070826202309.15933.54183.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56716>

It makes sense to still use git-repo-config instead of git-config in
the code, since the latter name is not available in older gits, but
it's better to use the new name in the help texts since the
overwhelming majority of users aren't going to use a very old git.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 examples/gitconfig |    2 +-
 stgit/stack.py     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index e402208..f1c653e 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -1,6 +1,6 @@
 # StGIT configuration file. Copy it to any of ~/.gitconfig or
 # .git/config and modify as needed. Note that the latter overrides
-# the former. The "git repo-config" command can be used as well
+# the former. The "git config" command can be used as well
=20
 [user]
 	# Default author/committer details (standard GIT variables)
diff --git a/stgit/stack.py b/stgit/stack.py
index 0ce9992..1ab10c5 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -515,7 +515,7 @@ class Series(PatchSet):
             out.note(('No parent remote declared for stack "%s",'
                       ' defaulting to "origin".' % self.get_name()),
                      ('Consider setting "branch.%s.remote" and'
-                      ' "branch.%s.merge" with "git repo-config".'
+                      ' "branch.%s.merge" with "git config".'
                       % (self.get_name(), self.get_name())))
             return 'origin'
         else:
@@ -532,7 +532,7 @@ class Series(PatchSet):
             out.note(('No parent branch declared for stack "%s",'
                       ' defaulting to "heads/origin".' % self.get_name=
()),
                      ('Consider setting "branch.%s.stgit.parentbranch"=
'
-                      ' with "git repo-config".' % self.get_name()))
+                      ' with "git config".' % self.get_name()))
             return 'heads/origin'
         else:
             raise StackException, 'Cannot find a parent branch for "%s=
"' % self.get_name()
