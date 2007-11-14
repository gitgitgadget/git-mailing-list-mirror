From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH] Grammar fixes for gitattributes documentation
Date: Wed, 14 Nov 2007 08:51:41 +0100
Message-ID: <33080F0B-80C0-4860-9A74-C6878EE3B2CD@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 08:52:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsD2Z-0008FF-0x
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 08:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbXKNHvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 02:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbXKNHvq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 02:51:46 -0500
Received: from wincent.com ([72.3.236.74]:35042 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751416AbXKNHvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 02:51:46 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAE7pg1b004600;
	Wed, 14 Nov 2007 01:51:43 -0600
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64957>

Tweak the "filter" section of the gitattributes documentation to add  
some
missing articles and improve some word choices without changing the
semantics of the section.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
  Documentation/gitattributes.txt |   17 +++++++++--------
  1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/ 
gitattributes.txt
index 20cf8ff..b01786b 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -148,22 +148,23 @@ with `$Id$` upon check-in.
  `filter`
  ^^^^^^^^

-A `filter` attribute can be set to a string value.  This names
+A `filter` attribute can be set to a string value which names a
  filter driver specified in the configuration.

-A filter driver consists of `clean` command and `smudge`
+A filter driver consists of a `clean` command and a `smudge`
  command, either of which can be left unspecified.  Upon
-checkout, when `smudge` command is specified, the command is fed
-the blob object from its standard input, and its standard output
-is used to update the worktree file.  Similarly, `clean` command
-is used to convert the contents of worktree file upon checkin.
+checkout, when the `smudge` command is specified, the command is
+fed the blob object from its standard input, and its standard
+output is used to update the worktree file.  Similarly, the
+`clean` command is used to convert the contents of worktree file
+upon checkin.

-Missing filter driver definition in the config is not an error
+A missing filter driver definition in the config is not an error
  but makes the filter a no-op passthru.

  The content filtering is done to massage the content into a
  shape that is more convenient for the platform, filesystem, and
-the user to use.  The keyword here is "more convenient" and not
+the user to use.  The key phrase here is "more convenient" and not
  "turning something unusable into usable".  In other words, the
  intent is that if someone unsets the filter driver definition,
  or does not have the appropriate filter program, the project
-- 
1.5.3.5
