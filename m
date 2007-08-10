From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Fix an illustration in git-rev-parse.txt
Date: Fri, 10 Aug 2007 00:49:27 -0700
Message-ID: <7v643nvng8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 09:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJPGl-0005oJ-IR
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 09:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757246AbXHJHus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 03:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753897AbXHJHus
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 03:50:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:55608 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbXHJHur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 03:50:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810074927.GCTJ7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 03:49:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a7pT1X0091kojtg0000000; Fri, 10 Aug 2007 03:49:28 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55516>

This hides the backslash at the end of line from AsciiDoc
toolchain by introducing a trailing whitespace on one line in an
illustration in git-rev-parse.txt.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Obviously this needs to be applied without --whitespace=strip

 Documentation/git-rev-parse.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index eea9c9c..4b4d229 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -224,7 +224,7 @@ left-to-right.
     G   H   I   J
      \ /     \ /
       D   E   F
-       \  |  / \
+       \  |  / \ 
         \ | /   |
          \|/    |
           B     C
