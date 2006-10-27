X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Documentation: add git in /etc/services.
Date: Fri, 27 Oct 2006 07:00:57 +0200
Message-ID: <20061027070057.cf0a236b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 27 Oct 2006 04:54:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30291>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdJjB-0007tJ-KF for gcvg-git@gmane.org; Fri, 27 Oct
 2006 06:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423624AbWJ0Exy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 00:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423642AbWJ0Exy
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 00:53:54 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:47307 "EHLO
 smtp4-g19.free.fr") by vger.kernel.org with ESMTP id S1423624AbWJ0Exx (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 00:53:53 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net
 [82.243.130.161]) by smtp4-g19.free.fr (Postfix) with SMTP id 5E7EF87BE; Fri,
 27 Oct 2006 06:53:52 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/everyday.txt   |    7 +++++++
 Documentation/git-daemon.txt |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index f1b2265..450ee76 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -372,6 +372,13 @@ example of managing a shared central rep
 
 Examples
 ~~~~~~~~
+We assume the following in /etc/services::
++
+------------
+$ grep 9418 /etc/services
+git		9418/tcp		# Git Version Control System
+------------
+
 Run git-daemon to serve /pub/scm from inetd.::
 +
 ------------
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index a72ed39..dea25af 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -162,6 +162,13 @@ upload-archive::
 
 EXAMPLES
 --------
+We assume the following in /etc/services::
++
+------------
+$ grep 9418 /etc/services
+git		9418/tcp		# Git Version Control System
+------------
+
 git-daemon as inetd server::
 	To set up `git-daemon` as an inetd service that handles any
 	repository under the whitelisted set of directories, /pub/foo
-- 
