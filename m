From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v3 6/9] user-manual: Use 'git config --global user.*' for setup
Date: Sun, 17 Feb 2013 19:15:58 -0500
Message-ID: <27886ef1313956bc19ddb9e658c4eb181fab2e46.1361146398.git.wking@tremily.us>
References: <20130217170606.GA3432@odin.tremily.us>
 <cover.1361146398.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 01:17:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7EQA-0000ml-8T
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 01:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab3BRAQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2013 19:16:49 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:53018 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757417Ab3BRAQs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2013 19:16:48 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIE00HO03EWSY30@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 17 Feb 2013 18:16:36 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 140E3885668; Sun,
 17 Feb 2013 19:16:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361146568; bh=eAj7zFjZwT54fjOT2j3itrUPB0wiEIiKYGVJp3lVPg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:	 References;
	b=sh59KT7Pi21SoVnTIo02wAcumaR42zKG6XOGQIFiKK//eeJy8TfSqfcSj/syzny1b
 yIUzxCfv+uV0fODiohUu9/YjPWD07ONE0K++7lw2wb+7I1Lhn6mR21gqI0sHzFRqv/
 7bvcrsAlmOP/bhVrEQikIiS+QoHNOp3xIN4kuhGo=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <cover.1361146398.git.wking@tremily.us>
In-reply-to: <cover.1361146398.git.wking@tremily.us>
References: <cover.1361146398.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216418>

From: "W. Trevor King" <wking@tremily.us>

A simple command line call is easier than spawning an editor,
especially for folks new to ideas like the "command line" and "text
editors".  This is also the approach suggested by 'git commit' if you
try and commit without having configured user.name or user.email.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/user-manual.txt | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a79b3e31..d9276d7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -991,9 +991,16 @@ Developing with Git
 Telling Git your name
 ---------------------
 
-Before creating any commits, you should introduce yourself to Git.  The
-easiest way to do so is to make sure the following lines appear in a
-file named `.gitconfig` in your home directory:
+Before creating any commits, you should introduce yourself to Git.
+The easiest way to do so is to use linkgit:git-config[1]:
+
+------------------------------------------------
+$ git config --global user.name 'Your Name Comes Here'
+$ git config --global user.email 'you@yourdomain.example.com'
+------------------------------------------------
+
+Which will adds the following to a file named `.gitconfig` in your
+home directory:
 
 ------------------------------------------------
 [user]
@@ -1001,8 +1008,9 @@ file named `.gitconfig` in your home directory:
 	email = you@yourdomain.example.com
 ------------------------------------------------
 
-(See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
-details on the configuration file.)
+See the "CONFIGURATION FILE" section of linkgit:git-config[1] for
+details on the configuration file.  The file is plain text, so you can
+also edit it with your favorite editor.
 
 
 [[creating-a-new-repository]]
-- 
1.8.1.336.g94702dd
