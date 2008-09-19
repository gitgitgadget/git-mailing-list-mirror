From: Mikael Magnusson <mikachu@gmail.com>
Subject: [Useless PATCH to contrib/examples/git-remote.perl] Typo "does not
 exists" when git remote update remote.
Date: Fri, 19 Sep 2008 15:48:08 +0200 (CEST)
Message-ID: <alpine.LNX.1.00.0809191545010.18409@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 15:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KggMJ-0004aV-KG
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 15:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbYISNsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 09:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYISNsL
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 09:48:11 -0400
Received: from mail.bredband2.net ([82.209.166.4]:5383 "EHLO
	smtp.bredband2.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751185AbYISNsK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 09:48:10 -0400
Received: (qmail 23367 invoked from network); 19 Sep 2008 13:48:58 -0000
Received: from lkf-194-200-233-83.3.cust.bredband2.com (HELO mika.l3ib.org) ([83.233.200.194])
          (envelope-sender <mikachu@gmail.com>)
          by smtp.bredband2.net (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 19 Sep 2008 13:48:58 -0000
User-Agent: Alpine 1.00 (LNX )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96288>

---
I fixed this a few weeks before the git-remote C rewrite then never got 
around to sending it...

  contrib/examples/git-remote.perl |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/examples/git-remote.perl b/contrib/examples/git-remote.perl
index 36bd54c..b17952a 100755
--- a/contrib/examples/git-remote.perl
+++ b/contrib/examples/git-remote.perl
@@ -309,7 +309,7 @@ sub update_remote {
  			}
  		}
  	} else {
-		print STDERR "Remote group $name does not exists.\n";
+		print STDERR "Remote group $name does not exist.\n";
  		exit(1);
  	}
  	for (@remotes) {

--
Mikael Magnusson
