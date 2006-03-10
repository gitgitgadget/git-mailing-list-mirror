From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 1/4] Simplify wildcards for match files to be ignored
Date: Fri, 10 Mar 2006 15:43:08 +0100
Message-ID: <20060310144308.GB7920@diku.dk>
References: <20060310144106.GA7920@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 15:43:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHipp-00083T-BL
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 15:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCJOnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 09:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWCJOnM
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 09:43:12 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:53675 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751375AbWCJOnL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Mar 2006 09:43:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 23583770032;
	Fri, 10 Mar 2006 15:43:11 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01695-13; Fri, 10 Mar 2006 15:43:09 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 13AF2770030;
	Fri, 10 Mar 2006 15:43:09 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id CA5DC6DFAB0; Fri, 10 Mar 2006 15:41:44 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id F1F9561DC1; Fri, 10 Mar 2006 15:43:08 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20060310144106.GA7920@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17475>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3aad2fb..661c259 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,4 @@
-CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej ../cg-*.in)
+CG_IGNORE=$(wildcard ../cg-X* ../cg-*.*)
 CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg*))
 
 PACKAGE=cogito

-- 
Jonas Fonseca
