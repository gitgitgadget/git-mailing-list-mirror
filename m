From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-cherry-pick documentation
Date: Wed, 18 Apr 2007 22:03:26 -0500
Message-ID: <20070419030326.GB19402@bowser.ruder>
References: <20070416053525.GA18821@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 05:05:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeMy3-0005Wo-5m
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 05:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031084AbXDSDFl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 23:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031077AbXDSDFl
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 23:05:41 -0400
Received: from www.aeruder.net ([65.254.53.245]:3023 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031076AbXDSDFi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 23:05:38 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 8DF7040164;
	Wed, 18 Apr 2007 22:05:37 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070416053525.GA18821@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44982>

Documentation/git-cherry-pick.txt: Remove --replay as it is not
handled by the code (-r is however).

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Documentation/git-cherry-pick.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 3149d08..68bba98 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -38,7 +38,7 @@ OPTIONS
 	development branch), adding this information can be
 	useful.
 
--r|--replay::
+-r::
 	It used to be that the command defaulted to do `-x`
 	described above, and `-r` was to disable it.  Now the
 	default is not to do `-x` so this option is a no-op.
-- 
1.5.1.1.116.g8c4c
