From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] doc/git-reset: add reference to git-stash
Date: Wed, 17 Dec 2008 03:59:36 +0100
Message-ID: <200812170359.36253.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 17 04:00:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCmeS-0006Ti-GF
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 04:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbYLQC7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 21:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbYLQC7X
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 21:59:23 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:57970 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYLQC7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 21:59:22 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 84CC2F57AB03;
	Wed, 17 Dec 2008 03:59:21 +0100 (CET)
Received: from [91.19.62.172] (helo=pluto)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1LCmd7-00074X-00; Wed, 17 Dec 2008 03:59:21 +0100
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18/0k7uNpjVGn71Ql7ZGjQaSWYuif9pCge/W7y3
	vLeEFtgX3wSedZk2/CS+YrodENazbyiZ2IrdCbBPXjOQZcVybM
	wC+5MDF/velPmvidi1xg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103303>

The "Interrupted workflow" situation is a good example for using
git-stash.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 Documentation/git-reset.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 52aab5e..29156f6 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -177,6 +177,8 @@ $ git reset                                       <3>
 <3> At this point the index file still has all the WIP changes you
     committed as 'snapshot WIP'.  This updates the index to show your
     WIP files as uncommitted.
++
+See also linkgit:git-stash[1].
 
 Reset a single file in the index::
 +
-- 
1.6.1.rc3.23.gaf48b
