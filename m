From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 3/4] commit-id micro cleanup
Date: Fri, 02 Sep 2005 12:31:33 +0200
Message-ID: <20050902103133.24918.46625.stgit@zion.home.lan>
References: <20050902103125.24918.905.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 12:36:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB8tP-00024D-BI
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 12:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030384AbVIBKfV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 06:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVIBKfU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 06:35:20 -0400
Received: from [151.97.230.9] ([151.97.230.9]:45794 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030384AbVIBKfS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 06:35:18 -0400
Received: (qmail 12165 invoked by uid 508); 2 Sep 2005 12:35:17 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 2 Sep 2005 12:35:17 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id A2ED221D949;
	Fri,  2 Sep 2005 12:31:33 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050902103125.24918.905.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8019>

Resync commit-id and tree-id: cg-Xlib is not needed in either.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 commit-id |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/commit-id b/commit-id
--- a/commit-id
+++ b/commit-id
@@ -5,8 +5,6 @@
 #
 # Takes the appropriate ID, defaults to HEAD.
 
-. ${COGITO_LIB}cg-Xlib
-
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
 # Trim beginning space; leave end one because it means we must get the type
