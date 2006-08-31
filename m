From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Include config.mak.autogen in the doc Makefile
Date: Fri, 1 Sep 2006 00:31:08 +0200
Message-ID: <20060831223108.GA482@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 01 00:32:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIv49-0005xG-7y
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 00:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWHaWbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 18:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWHaWbN
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 18:31:13 -0400
Received: from [130.225.96.91] ([130.225.96.91]:29122 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932462AbWHaWbN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 18:31:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 4AF8377005F
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:31:10 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07743-02 for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:31:09 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 2174C77004C
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:31:09 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP id 5DDB66DF89F
	for <git@vger.kernel.org>; Fri,  1 Sep 2006 00:29:42 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0985562A06; Fri,  1 Sep 2006 00:31:08 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26280>

... to install documentation relative to the path set with configure's
--prefix option.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0d9ffb4..ed8b886 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -33,6 +33,8 @@ # DESTDIR=
 
 INSTALL?=install
 
+-include ../config.mak.autogen
+
 #
 # Please note that there is a minor bug in asciidoc.
 # The version after 6.0.3 _will_ include the patch found here:
-- 
1.4.2.g2ba6b-dirty

-- 
Jonas Fonseca
