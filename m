From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/3] Documentation: user-manual: add information about
 "git help" at the beginning
Date: Fri, 14 Nov 2008 13:27:05 +0100
Message-ID: <20081114132705.5bb9be21.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 13:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0xkb-0004U0-HJ
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 13:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYKNMY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 07:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbYKNMY5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 07:24:57 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:55762 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYKNMY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 07:24:56 -0500
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 7983532A7B6;
	Fri, 14 Nov 2008 13:24:54 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with SMTP id 4119F32A7D3;
	Fri, 14 Nov 2008 13:24:54 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100966>

Talking about "git help" is useful because it has a few more
features (like when using it without arguments or with "-a") and
it may work on non unix like platforms.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/user-manual.txt |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

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
1.6.0.4.617.g621cb
