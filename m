From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] typo fix: Directory `...' exist, ...: s/exist/exists/
Date: Tue, 29 Sep 2009 07:43:57 +0200
Message-ID: <87eipq71b6.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 29 07:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsVVp-0005UE-JB
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 07:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbZI2FoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 01:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbZI2FoC
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 01:44:02 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:56845 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109AbZI2FoA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 01:44:00 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A596C81805A
	for <git@vger.kernel.org>; Tue, 29 Sep 2009 07:44:00 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C5543818068
	for <git@vger.kernel.org>; Tue, 29 Sep 2009 07:43:57 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 50AD658E3F; Tue, 29 Sep 2009 07:43:57 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129282>

Using next, I saw this:

    Directory 'gnulib' exist, but is neither empty nor a git repository


>From 438a7c3a41f0e829779cccd901cf894300b6683e Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Tue, 29 Sep 2009 07:42:25 +0200
Subject: [PATCH] typo fix: Directory `...' exist, ...: s/exist/exists/


Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bfbd36b..0462e52 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -98,7 +98,7 @@ module_clone()
 	if test -d "$path"
 	then
 		rmdir "$path" 2>/dev/null ||
-		die "Directory '$path' exist, but is neither empty nor a git repository"
+		die "Directory '$path' exists, but is neither empty nor a git repository"
 	fi

 	test -e "$path" &&
--
1.6.5.rc2.177.ga9dd6
