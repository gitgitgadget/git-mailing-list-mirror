From: CJ van den Berg <cj@vdbonline.com>
Subject: [PATCH] git-submodule: Fix a typo
Date: Wed, 4 Jul 2007 18:22:14 +0200
Message-ID: <20070704162214.GA28542@prefect.vdbonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 18:56:54 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I689n-0004aA-KV
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 18:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbXGDQ4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbXGDQ4o
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 12:56:44 -0400
Received: from marvin.vdbonline.net ([208.78.101.188]:39442 "EHLO
	marvin.vdbonline.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620AbXGDQ4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 12:56:43 -0400
X-Greylist: delayed 2065 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2007 12:56:43 EDT
Received: from marvin.vdbonline.net (localhost [127.0.0.1])
	by marvin.vdbonline.net (Postfix) with ESMTP id 0FE1F680AC
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 18:22:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	marvin.vdbonline.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	SPF_HELO_PASS autolearn=ham version=3.1.7-deb
Received: from prefect.vdbonline.net (localhost [127.0.0.1])
	by marvin.vdbonline.net (Postfix) with ESMTP
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 18:22:16 +0200 (CEST)
Received: by prefect.vdbonline.net (Postfix, from userid 1000)
	id 0A7A14D4258; Wed,  4 Jul 2007 18:22:14 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51622>

This typo breaks the output of git submodule status.

---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 0ba0161..277fadc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -234,7 +234,7 @@ modules_list()
 			continue;
 		fi
 		revname=$(unset GIT_DIR && cd "$path" && git describe --tags $sha1)
-		set_name_rev "$path" $"sha1"
+		set_name_rev "$path" "$sha1"
 		if git diff-files --quiet -- "$path"
 		then
 			say " $sha1 $path$revname"
-- 
1.5.2.GIT
