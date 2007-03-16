From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH/RFC] Documentation: git-daemon inetd configuration fix
Date: Fri, 16 Mar 2007 08:54:29 +0100
Message-ID: <11740316693552-git-send-email-matthias@spinlock.ch>
Cc: git@vger.kernel.org, Matthias Kestenholz <matthias@spinlock.ch>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Mar 16 08:55:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS7HI-0002l6-BD
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 08:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbXCPHys (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 03:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXCPHys
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 03:54:48 -0400
Received: from mail17.bluewin.ch ([195.186.18.64]:35838 "EHLO
	mail17.bluewin.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932334AbXCPHyr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 03:54:47 -0400
Received: from spinlock.ch (85.0.197.176) by mail17.bluewin.ch (Bluewin 7.3.121)
        id 45F50EE10011BEA0; Fri, 16 Mar 2007 07:54:43 +0000
Received: (nullmailer pid 23731 invoked by uid 1000);
	Fri, 16 Mar 2007 07:54:29 -0000
X-Mailer: git-send-email 1.5.0.4.1009.gd3da
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42332>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>
---
 Documentation/git-daemon.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
 

 On my debian server, this change was needed to get git-daemon running.
 I am no inetd expert, so I don't know where the error was.

 Perhaps this patch might help someone else.


diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 9ddab71..499c1f3 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -177,7 +177,7 @@ git-daemon as inetd server::
 +
 ------------------------------------------------
 	git stream tcp nowait nobody  /usr/bin/git-daemon
-		git-daemon --inetd --verbose --export-all
+		/usr/bin/git-daemon --inetd --verbose --export-all
 		/pub/foo /pub/bar
 ------------------------------------------------
 
@@ -190,7 +190,7 @@ git-daemon as inetd server for virtual hosts::
 +
 ------------------------------------------------
 	git stream tcp nowait nobody /usr/bin/git-daemon
-		git-daemon --inetd --verbose --export-all
+		/usr/bin/git-daemon --inetd --verbose --export-all
 		--interpolated-path=/pub/%H%D
 		/pub/www.example.org/software
 		/pub/www.example.com/software
-- 
1.5.0.4.1009.gd3da
