From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2 resend] Documentation: user-manual: add information
 about "git help" at the beginning
Date: Sun, 16 Nov 2008 18:10:01 +0100
Message-ID: <20081116181001.97c45196.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Nov 16 18:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1l7b-0005LU-GH
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 18:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYKPRIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 12:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYKPRIA
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 12:08:00 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:43731 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYKPRIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 12:08:00 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0B4F61AB2B9;
	Sun, 16 Nov 2008 18:07:57 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 41FF61AB301;
	Sun, 16 Nov 2008 18:07:56 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101141>

Talking about "git help" is useful because it has a few more
features (like when using it without arguments or with "-a") and
it may work on non unix like platforms.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/user-manual.txt |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

	It seems that this patch and the following one have not
	been applyed.

	Here are some more detailed reasons why I think such a patch
	would be useful:

	- neither user-manual.txt nor gitutorial.txt talk, in their
	current state, about "git help",
	- there is a high probability that "man" does not work on
	Windows, though it seems that some work has been done for
	"git help" to work on this platform,
	- "git help" without argument and "git help -a" may be useful
	and have no "man" equivalent, "git help -w" (or "git help -i")
	may also be usefull/friendlier for some people,
	- it seems that "git help" also resolves git aliases,
	- some people still tell that git is not user friendly and
	even develop separate porcelains (like eg) to do a better job
	at helping newbies,
	- at GitTogether'08 many people seemed to agree that "git help"
	should be improved to have more newby friendly features,
	- I don't see the point of trying to improve "git help" any
	further if we don't make it more visible first.

	So, Junio, could you please tell me what is wrong with this patch?

	Thanks in advance,
	Christian.

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 645d752..48f7189 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -17,13 +17,27 @@ People needing to do actual development will also want to read
 
 Further chapters cover more specialized topics.
 
-Comprehensive reference documentation is available through the man
-pages.  For a command such as "git clone <repo>", just use
+Comprehensive reference documentation is available through either the
+linkgit:git-help[1] command or the man pages.  For a command such as
+"git clone <repo>", you can use:
+
+------------------------------------------------
+$ git help clone
+------------------------------------------------
+
+or:
 
 ------------------------------------------------
 $ man git-clone
 ------------------------------------------------
 
+linkgit:git-help[1] has a few more features and is self-documenting
+using:
+
+------------------------------------------------
+$ git help help
+------------------------------------------------
+
 See also <<git-quick-start>> for a brief overview of git commands,
 without any explanation.
 
-- 
1.6.0.4.617.g39d03
