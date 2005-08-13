From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 5/5] Ignore patch backup files when finding cg-* manpage scripts
Date: Sat, 13 Aug 2005 18:31:40 +0200
Message-ID: <20050813163140.GF968@diku.dk>
References: <20050813162352.GA968@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 18:31:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3yvA-0000jV-Em
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 18:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVHMQbm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 12:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVHMQbm
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 12:31:42 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:61402 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932182AbVHMQbl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 12:31:41 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id BECCF6E13FD; Sat, 13 Aug 2005 18:31:28 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 891856E12E2; Sat, 13 Aug 2005 18:31:28 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A762260A44; Sat, 13 Aug 2005 18:31:40 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050813162352.GA968@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Adds ../cg-*.{orig,rej} to CG_IGNORE.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 Documentation/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -1,4 +1,4 @@
-CG_IGNORE=$(wildcard ../cg-X*)
+CG_IGNORE=$(wildcard ../cg-X* ../cg-*.orig ../cg-*.rej)
 CG_SRC=$(filter-out $(CG_IGNORE), $(wildcard ../cg-*))
 
 MAN1_TXT=$(patsubst ../cg-%,cg-%.txt,$(CG_SRC))

-- 
Jonas Fonseca
