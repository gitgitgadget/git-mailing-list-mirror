From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: "bisect run" can be given bangs before the
 run script.
Date: Thu, 3 May 2007 07:06:07 +0200
Message-ID: <20070503070607.fa2ffe92.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 06:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjTOS-0000Rk-Ul
	for gcvg-git@gmane.org; Thu, 03 May 2007 06:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767386AbXECE6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 00:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767387AbXECE6N
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 00:58:13 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:46205 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767386AbXECE6M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 00:58:12 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id BD851B92E0;
	Thu,  3 May 2007 06:58:10 +0200 (CEST)
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46061>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

Hi Uwe and Junio,

This is the documentation related to my latest patch:

[RFC/PATCH] Bisect: add special treatment for bangs passed to "bisect run".

(http://article.gmane.org/gmane.comp.version-control.git/45943)

Thanks in advance,
Christian.

 Documentation/git-bisect.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 5f68ee1..a1cceb5 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -175,6 +175,12 @@ Any other exit code will abort the automatic bisect process. (A
 program that does "exit(-1)" leaves $? = 255, see exit(3) manual page,
 the value is chopped with "& 0377".)
 
+You can use one or more "!" argument immediately after "git bisect
+run" if you want to revert once or more times the "run" script exit
+code, even if your current shell does not support the "!"
+keyword. Reverting the exit code means 0 gives 1 and anything other
+than 0 gives 0.
+
 You may often find that during bisect you want to have near-constant
 tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
 "revision that does not have this commit needs this patch applied to
-- 
1.5.2.rc0.71.g4342-dirty
