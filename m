From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/6] Unset (comment out) NO_C99_FORMAT on Cygwin.
Date: Sat, 03 Mar 2007 18:28:39 +0000
Message-ID: <45E9BE57.4020104@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNYz5-0007PA-UW
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:29:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbXCCS3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbXCCS3S
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:29:18 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2787 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030334AbXCCS3S (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 13:29:18 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Mar 2007 13:29:18 EST
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYyl-000C0d-3n; Sat, 03 Mar 2007 18:29:12 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41307>


This should only be set based on the capability of your
compiler/library to support c99 format specifiers. In this
case the version of gcc/newlib and indirectly the version
of Cygwin. It should probably only be set in your config.mak
file.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Erm, given what I said above, I should have deleted this
line, rather than commenting it out! <blush>

[Note: my version info: gcc 3.4.4, newlib 1.14.0, cygwin 1.5.22(0.156/4/2)]

  Makefile |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 40bdcff..8390a94 100644
--- a/Makefile
+++ b/Makefile
@@ -369,7 +369,7 @@ ifeq ($(uname_O),Cygwin)
  	NO_STRCASESTR = YesPlease
  	NO_SYMLINK_HEAD = YesPlease
  	NEEDS_LIBICONV = YesPlease
-	NO_C99_FORMAT = YesPlease
+	# NO_C99_FORMAT = YesPlease
  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
  	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
  	# There are conflicting reports about this.
-- 
1.5.0
