From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] two doc fixes
Date: Tue, 19 Aug 2008 20:49:51 +0200
Message-ID: <87ej4kx2k0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:51:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWIE-00057r-1g
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:50:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbYHSStx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbYHSStx
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:49:53 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:52018 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751258AbYHSStw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:49:52 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id B560F1727A
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 20:49:51 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp6-g19.free.fr (Postfix) with ESMTP id A1AA2196FF
	for <git@vger.kernel.org>; Tue, 19 Aug 2008 20:49:51 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 850DC389DC; Tue, 19 Aug 2008 20:49:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92899>

Here are two patches that have been sitting around for too long:

>From 636a18da43c842ad9655274c679ad93c35109c95 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Tue, 1 Apr 2008 14:53:51 +0200
Subject: [PATCH] fix a typo


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/SubmittingPatches |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b116475..c88a2c3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -71,7 +71,7 @@ run git diff --check on your changes before you commit.

 (1a) Try to be nice to older C compilers

-We try to support wide range of C compilers to compile
+We try to support a wide range of C compilers to compile
 git with. That means that you should not use C99 initializers, even
 if a lot of compilers grok it.

--
1.6.0.9.gae2e487


>From 71413abb8ed3a80315ac9b6109b57a49b53842ae Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Wed, 2 Jul 2008 09:49:59 +0200
Subject: [PATCH] reword --full-index description


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 Documentation/diff-options.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index cba90fd..1759386 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -107,9 +107,9 @@ endif::git-format-patch[]
 	--exit-code.

 --full-index::
-	Instead of the first handful characters, show full
-	object name of pre- and post-image blob on the "index"
-	line when generating a patch format output.
+	Instead of the first handful of characters, show the full
+	pre- and post-image blob object names on the "index"
+	line when generating patch format output.

 --binary::
 	In addition to --full-index, output "binary diff" that
--
1.6.0.9.gae2e487
