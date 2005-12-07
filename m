From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-object-id: comment the alternate id shortcut parsing
Date: Wed, 7 Dec 2005 22:39:43 +0100
Message-ID: <20051207213943.GC25890@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 07 22:40:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek71d-0004zc-Tq
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 22:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVLGVjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 16:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030363AbVLGVjq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 16:39:46 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:10695 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030362AbVLGVjo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 16:39:44 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id B308B6DFECC; Wed,  7 Dec 2005 22:38:49 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4C8BC6DFE34; Wed,  7 Dec 2005 22:38:49 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9776161556; Wed,  7 Dec 2005 22:39:43 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13342>

Add comment about why Cogito's own 4 digit id shortcut parser is needed.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 3c14cded46e110396127fc5b5e65883eb5cd60b9
tree 593da711de14cfc3f8dc1fd5773990902568b42e
parent 36c0d9fae209ab7fa889333e8eebef22e7f0f55c
author Jonas Fonseca <fonseca@diku.dk> Wed, 07 Dec 2005 08:17:04 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 07 Dec 2005 08:17:04 +0100

 cg-object-id |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/cg-object-id b/cg-object-id
index 56d9f91..ea04dca 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -52,7 +52,9 @@ normalize_id()
 		id="$revid"
 		valid=1
 
-	# Short id's must be lower case and at least 4 digits.
+	# Short id's must be lower case and at least 4 digits. git-rev-parse(1)
+	# allows only down to 5 digits and we want to show the list of matched
+	# ids.
 	elif [[ "$id" == [0-9a-f][0-9a-f][0-9a-f][0-9a-f]* ]]; then
 		idpref=${id:0:2}
 		idpost=${id:2}

-- 
Jonas Fonseca
