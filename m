From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/3] Document current cvsps limitations.
Date: Sat, 27 May 2006 18:39:33 +0200
Message-ID: <20060527163933.474.4059.stgit@gandelf.nowhere.earth>
References: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 18:35:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk1l7-0000Rf-Sx
	for gcvg-git@gmane.org; Sat, 27 May 2006 18:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWE0QfR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 12:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWE0QfR
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 12:35:17 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:33702 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S964906AbWE0QfP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 12:35:15 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id D05E726582;
	Sat, 27 May 2006 18:35:14 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fk1wv-0006ub-82; Sat, 27 May 2006 18:47:37 +0200
To: junkio@cox.net
In-Reply-To: <20060527163641.474.93575.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20862>


Since there is no bugtracker that I know of, let's just use the scripts
themselves to document their limitations.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 git-cvsexportcommit.perl |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index ed87dc9..3e4e90b 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -1,5 +1,12 @@
 #!/usr/bin/perl -w
 
+# Known limitations:
+# - cannot add or remove binary files
+# - cannot add parent directories when needed
+# - does not propagate permissions
+# - tells "ready for commit" even when things could not be completed
+#   (eg addition of a binary file)
+
 use strict;
 use Getopt::Std;
 use File::Temp qw(tempdir);
