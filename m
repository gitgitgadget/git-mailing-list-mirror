From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] completion: support format-patch's --cover-letter option
Date: Thu, 21 Feb 2008 16:21:49 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802211621280.17164@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 17:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSECi-0001F9-Dx
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 17:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811AbYBUQWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 11:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbYBUQWS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 11:22:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:34157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932613AbYBUQWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 11:22:16 -0500
Received: (qmail invoked by alias); 21 Feb 2008 16:22:09 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 21 Feb 2008 17:22:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WGqQPhO9WzlPFeP9sOG6uhM1MJv8F0Xm9EaWJSv
	ZLq9mmoSWGb1Gd
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74628>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This obviously is on top of my "make bash completion a first class
	citizen" patch.  I haven't heard any comments about that, yet.

 git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-completion.bash b/git-completion.bash
index 4ea727b..0d6ba71 100755
--- a/git-completion.bash
+++ b/git-completion.bash
@@ -645,6 +645,7 @@ _git_format_patch ()
 			--in-reply-to=
 			--full-index --binary
 			--not --all
+			--cover-letter
 			"
 		return
 		;;
-- 
1.5.4.2.265.geabed
