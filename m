From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] howto/revert-a-faulty-merge.txt: Fix asciidoc formatting
Date: Fri, 11 Oct 2013 19:24:14 +0100
Message-ID: <5258424E.1000804@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 20:24:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUhNv-0004TJ-8I
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 20:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772Ab3JKSYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 14:24:19 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:47781 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752302Ab3JKSYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 14:24:19 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 1E02EA6584C;
	Fri, 11 Oct 2013 19:24:17 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id E31C1A64D95;
	Fri, 11 Oct 2013 19:24:16 +0100 (BST)
Received: from [192.168.254.8] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Fri, 11 Oct 2013 19:24:16 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235917>


Several uses of the '^' operator are being interpreted by asciidoc
as requests to show the following text as a superscript. In order
to fix this problem, use backticks (`) to quote the text of the
affected git command invocations.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jonathan,

Just noticed this in passing ... I don't know asciidoc that well, so
if there is a better way to fix this, just let me know. ;-)

ATB,
Ramsay Jones

 Documentation/howto/revert-a-faulty-merge.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 075418e..acf3e47 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -37,7 +37,7 @@ where A and B are on the side development that was not so good, M is the
 merge that brings these premature changes into the mainline, x are changes
 unrelated to what the side branch did and already made on the mainline,
 and W is the "revert of the merge M" (doesn't W look M upside down?).
-IOW, "diff W^..W" is similar to "diff -R M^..M".
+IOW, `"diff W^..W"` is similar to `"diff -R M^..M"`.
 
 Such a "revert" of a merge can be made with:
 
@@ -121,9 +121,9 @@ If you reverted the revert in such a case as in the previous example:
        ---A---B                   A'--B'--C'
 
 where Y is the revert of W, A' and B' are rerolled A and B, and there may
-also be a further fix-up C' on the side branch.  "diff Y^..Y" is similar
-to "diff -R W^..W" (which in turn means it is similar to "diff M^..M"),
-and "diff A'^..C'" by definition would be similar but different from that,
+also be a further fix-up C' on the side branch.  `"diff Y^..Y"` is similar
+to `"diff -R W^..W"` (which in turn means it is similar to `"diff M^..M"`),
+and `"diff A'^..C'"` by definition would be similar but different from that,
 because it is a rerolled series of the earlier change.  There will be a
 lot of overlapping changes that result in conflicts.  So do not do "revert
 of revert" blindly without thinking..
-- 
1.8.4
