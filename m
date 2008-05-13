From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: rev-parse: add a few "--verify" and
 "--default" examples
Date: Tue, 13 May 2008 06:51:41 +0200
Message-ID: <20080513065141.69ff4975.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 13 06:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvmQZ-0007Sa-5d
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 06:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbYEMErB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 00:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753912AbYEMErB
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 00:47:01 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45259 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbYEMErB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 00:47:01 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id DF12A1AB2C9;
	Tue, 13 May 2008 06:46:59 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id ACE441AB2C6;
	Tue, 13 May 2008 06:46:59 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta3 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81986>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-rev-parse.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index b6b2fe9..1d10893 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -378,6 +378,31 @@ C?        option C with an optional argument"
 eval `echo "$OPTS_SPEC" | git-rev-parse --parseopt -- "$@" || echo exit $?`
 ------------
 
+EXAMPLES
+--------
+
+* Print the SHA1 object name of the current commit:
++
+------------
+$ git rev-parse --verify HEAD
+------------
+
+* Print the commit SHA1 from the revision in the $REV shell variable:
++
+------------
+$ git rev-parse --verify $REV
+------------
++
+This will error out if $REV is empty or not a valid revision.
+
+* Same as above:
++
+------------
+$ git rev-parse --default master --verify $REV
+------------
++
+but if $REV is empty, the commit SHA1 from master will be printed.
+
 
 Author
 ------
-- 
1.5.5.1.347.g28d6
