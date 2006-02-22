From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-* manpages: Handle more than one `cg-cmd` per line
Date: Wed, 22 Feb 2006 01:48:18 +0100
Message-ID: <20060222004818.GA24693@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 01:48:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBiB7-0001QT-OX
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 01:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243AbWBVAsW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 19:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWBVAsW
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 19:48:22 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:46039 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1030243AbWBVAsV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2006 19:48:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 7D0EE770002;
	Wed, 22 Feb 2006 01:48:20 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 19844-16; Wed, 22 Feb 2006 01:48:19 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 1228252D461;
	Wed, 22 Feb 2006 01:48:19 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 0D6AB6DFC31; Wed, 22 Feb 2006 01:47:16 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id EC31661C31; Wed, 22 Feb 2006 01:48:18 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16576>

... which is the case for cg-update.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
author Jonas Fonseca <fonseca@diku.dk> Wed, 22 Feb 2006 01:45:18 +0100

 Documentation/make-cg-asciidoc |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
index bc31809..126d4eb 100755
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -42,7 +42,7 @@ CAPTION=$(echo "$HEADER" | head -n 1 | t
 # were referenced as "`cg-command`". This way references from cg-* combos in
 # code listings will be ignored.
 BODY=$(echo "$HEADER" | sed '0,/^$/d' \
-		      | sed 's/`\(cg-[a-z-]\+\)`/gitlink:\1[1]/;s/^\(-.*\)::.*/\1::/')
+		      | sed 's/`\(cg-[a-z-]\+\)`/gitlink:\1[1]/g;s/^\(-.*\)::.*/\1::/')
 
 DESCRIPTION=
 OPTIONS=

-- 
Jonas Fonseca
