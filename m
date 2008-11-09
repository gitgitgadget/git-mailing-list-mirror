From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: bisect: change a few instances of "git-cmd"
 to "git cmd"
Date: Sun, 9 Nov 2008 14:53:14 +0100
Message-ID: <20081109145314.cab893d7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 09 14:52:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzAiB-0002pu-7N
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 14:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbYKINu7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 08:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYKINu6
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 08:50:58 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:48519 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795AbYKINu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 08:50:58 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 28E7017B53D;
	Sun,  9 Nov 2008 14:50:56 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id E80F517B529;
	Sun,  9 Nov 2008 14:50:55 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100444>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-bisect.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c7981ef..39034ec 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect log
  git bisect run <cmd>...
 
-This command uses 'git-rev-list --bisect' to help drive the
+This command uses 'git rev-list --bisect' to help drive the
 binary search process to find which change introduced a bug, given an
 old "good" commit object name and a later "bad" commit object name.
 
@@ -101,7 +101,7 @@ $ git bisect visualize
 to see the currently remaining suspects in 'gitk'.  `visualize` is a bit
 too long to type and `view` is provided as a synonym.
 
-If 'DISPLAY' environment variable is not set, 'git-log' is used
+If 'DISPLAY' environment variable is not set, 'git log' is used
 instead.  You can even give command line options such as `-p` and
 `--stat`.
 
@@ -215,7 +215,7 @@ tweaks (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or
 work around other problem this bisection is not interested in")
 applied to the revision being tested.
 
-To cope with such a situation, after the inner 'git-bisect' finds the
+To cope with such a situation, after the inner 'git bisect' finds the
 next revision to test, with the "run" script, you can apply that tweak
 before compiling, run the real test, and after the test decides if the
 revision (possibly with the needed tweaks) passed the test, rewind the
-- 
1.6.0.3.614.g0f3b9
