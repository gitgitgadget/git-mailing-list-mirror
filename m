From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] documentation: bisect: remove bits talking about a
 bisection branch
Date: Sat, 14 Jun 2008 09:21:36 +0200
Message-ID: <20080614092136.50b5b17a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 14 09:18:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Q1j-0005Et-OI
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 09:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbYFNHRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 03:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYFNHRY
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 03:17:24 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:49232 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750910AbYFNHRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 03:17:24 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 08D801AB2F1;
	Sat, 14 Jun 2008 09:17:23 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id BD5081AB2BB;
	Sat, 14 Jun 2008 09:17:22 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84974>

... because we are now bisecting using a detached HEAD.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 37c7acb..3ca0d33 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -85,10 +85,9 @@ Oh, and then after you want to reset to the original head, do a
 $ git bisect reset
 ------------------------------------------------
 
-to get back to the original branch, instead of being in one of the
-bisection branches ("git bisect start" will do that for you too,
-actually: it will reset the bisection state, and before it does that
-it checks that you're not using some old bisection branch).
+to get back to the original branch, instead of being on the bisection
+commit ("git bisect start" will do that for you too, actually: it will
+reset the bisection state).
 
 Bisect visualize
 ~~~~~~~~~~~~~~~~
-- 
1.5.6.rc0.202.g8f5a
