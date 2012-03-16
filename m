From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 12:13:30 +0100
Message-ID: <4F63205A.6000202@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 11:15:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8UBb-0006c5-Gi
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 11:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760028Ab2CPKO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 06:14:58 -0400
Received: from luthien1.map.es ([213.9.211.102]:21419 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752226Ab2CPKO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 06:14:57 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 9C917F8800
	for <git@vger.kernel.org>; Fri, 16 Mar 2012 11:14:39 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 6DE9E2C373
	for <git@vger.kernel.org>; Fri, 16 Mar 2012 11:14:32 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 9C917F8800.307B0
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332497679.67345@Nat+UGwdpAtR54GNitjZ6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193249>

Same as they are informed of what the different commands
do and that they can remove commits.
---
Hi, I was using git rebase -i for some time now and never
occured to me I could reorder the commit lines to affect
the order the commits are applied, learnt that recently 
from a git tutorial, I must admit I have now checked the 
man page and it's well explained, but remarking that on
the user-input screen is an useful addition imo.

 git-rebase--interactive.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..acf1f5c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -846,6 +846,8 @@ cat >> "$todo" << EOF
 #  f, fixup = like "squash", but discard this commit's log message
 #  x, exec = run command (the rest of the line) using shell
 #
+# You can re-order the commit lines to affect the order on which
+# the commits will be applied.
 # If you remove a line here THAT COMMIT WILL BE LOST.
 # However, if you remove everything, the rebase will be aborted.
 #
-- 
1.7.7.6
