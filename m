From: Mikael Magnusson <mikachu@gmail.com>
Subject: [PATCH] git-repack uses --no-repack-object, not --no-repack-delta.
Date: Fri, 19 Sep 2008 15:43:48 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0809191543060.18409@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 15:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KggID-0002pU-UG
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbYISNnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 09:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbYISNnu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:43:50 -0400
Received: from mail.bredband2.net ([82.209.166.4]:22108 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751410AbYISNnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:43:50 -0400
Received: (qmail 21329 invoked from network); 19 Sep 2008 13:44:38 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 19 Sep 2008 13:44:38 -0000
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96287>

---
  Documentation/git-repack.txt |    2 +-
  git-repack.sh                |    2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 38ac609..bbe1485 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -60,7 +60,7 @@ OPTIONS
  	linkgit:git-pack-objects[1].

  -f::
-	Pass the `--no-reuse-delta` option to 'git-pack-objects'. See
+	Pass the `--no-reuse-object` option to `git-pack-objects`, see
  	linkgit:git-pack-objects[1].

  -q::
diff --git a/git-repack.sh b/git-repack.sh
index 683960b..d39eb6c 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -10,7 +10,7 @@ git repack [options]
  a               pack everything in a single pack
  A               same as -a, and turn unreachable objects loose
  d               remove redundant packs, and run git-prune-packed
-f               pass --no-reuse-delta to git-pack-objects
+f               pass --no-reuse-object to git-pack-objects
  n               do not run git-update-server-info
  q,quiet         be quiet
  l               pass --local to git-pack-objects

--
Mikael Magnusson
