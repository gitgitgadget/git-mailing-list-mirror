From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] Update documentation of --compose to git-send-email-script.txt
Date: Mon, 5 Sep 2005 01:13:07 -0400
Message-ID: <11258971872608-git-send-email-ryan@michonline.com>
References: <1125897187857-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Mon Sep 05 07:16:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EC9ID-0002sw-BB
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 07:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVIEFNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 01:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVIEFNN
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 01:13:13 -0400
Received: from mail.autoweb.net ([198.172.237.26]:20382 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932178AbVIEFNN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 01:13:13 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1EC9I8-0003jd-Kw
	for git@vger.kernel.org; Mon, 05 Sep 2005 01:13:12 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1EC9I4-00042y-00; Mon, 05 Sep 2005 01:13:08 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1EC9I3-000896-Sb; Mon, 05 Sep 2005 01:13:07 -0400
In-Reply-To: <1125897187857-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8081>

Signed-off-by: Ryan Anderson <ryan@michonline.com>

---

 Documentation/git-send-email-script.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

60765e20aa12da748f43204e25cb582f88fb16c8
diff --git a/Documentation/git-send-email-script.txt b/Documentation/git-send-email-script.txt
--- a/Documentation/git-send-email-script.txt
+++ b/Documentation/git-send-email-script.txt
@@ -33,16 +33,21 @@ The options available are:
 	the value GIT_COMMITTER_IDENT, as returned by "git-var -l".
 	The user will still be prompted to confirm this entry.
 
+   --compose
+	Use \$EDITOR to edit an introductory message for the
+	patch series.
+
    --subject
    	Specify the initial subject of the email thread.
+	Only necessary if --compose is also set.  If --compose
+	is not set, this will be prompted for.
 
    --in-reply-to
 	Specify the contents of the first In-Reply-To header.
 	Subsequent emails will refer to the previous email 
-	instead of this.
-	When overriding on the command line, it may be necessary
-	to set this to a space.  For example
-		--in-reply-to=" "
+	instead of this if --chain-reply-to is set (the default)
+	Only necessary if --compose is also set.  If --compose
+	is not set, this will be prompted for.
 
    --chain-reply-to, --no-chain-reply-to
 	If this is set, each email will be sent as a reply to the previous
