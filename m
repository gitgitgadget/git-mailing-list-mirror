From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH - todo] Changes to e-mailed patch handling in v1.5.0
Date: Wed, 17 Jan 2007 15:06:36 -0800
Message-ID: <7vhcupp81v.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vk5zlqqum.fsf@assigned-by-dhcp.cox.net>
	<7vac0hqq33.fsf@assigned-by-dhcp.cox.net>
	<7vwt3lp97c.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 18 00:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7Jrg-0000YJ-SW
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 00:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbXAQXGj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 18:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbXAQXGj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 18:06:39 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60705 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbXAQXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 18:06:38 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070117230638.JOBL25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 18:06:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CP6v1W0091kojtg0000000; Wed, 17 Jan 2007 18:06:55 -0500
To: git@vger.kernel.org
In-Reply-To: <7vwt3lp97c.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 Jan 2007 14:41:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37046>

This applies to the draft v1.5.0 release notes in 'todo' branch and
summarizes the changes my patches to format-patch bring in.  

I am neutral about changing the default suffix from .txt to .patch;
comments?


diff --git a/v1.5.0.txt b/v1.5.0.txt
index 2fccf8e..6a9a8d6 100644
--- a/v1.5.0.txt
+++ b/v1.5.0.txt
@@ -268,6 +268,21 @@ Updates in v1.5.0 since v1.4.4 series
    excuse us for this very minor one-time inconvenience.
 
 
+* e-mailed patches
+
+ - See the above I18n section.
+
+ - git-format-patch now enables --binary without being asked.
+   git-am does _not_ default to it, as sending binary patch via
+   e-mail is unusual and is harder to review than textual
+   patches and it is prudent to require the person who is
+   applying the patch to explicitly ask for it.
+
+ - The default suffix for git-format-patch output is now ".patch",
+   not ".txt".  This can be changed with --suffix=.txt option,
+   or "format.suffix = .txt" in the configuration.
+
+
 * Foreign SCM interfaces
 
   - git-svn now requires the Perl SVN:: libraries, the
