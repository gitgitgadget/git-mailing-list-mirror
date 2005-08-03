From: Ryan Anderson <ryan@michonline.com>
Subject: [PATCH 2/2] Doc: update git-send-email-script documentation.
Date: Tue, 2 Aug 2005 21:45:22 -0400
Message-ID: <11230335222661-git-send-email-ryan@michonline.com>
References: <1123033522656-git-send-email-ryan@michonline.com>
Reply-To: Ryan Anderson <ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 03:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E08Mo-0006wF-42
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 03:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVHCBqh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 21:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVHCBp2
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 21:45:28 -0400
Received: from mail.autoweb.net ([198.172.237.26]:20445 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261953AbVHCBpZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2005 21:45:25 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E08Jv-0007wE-JE; Tue, 02 Aug 2005 21:45:23 -0400
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E08U3-0003ep-00; Tue, 02 Aug 2005 21:55:51 -0400
Received: from localhost ([127.0.0.1] helo=mythryan)
	by mythryan with smtp (Exim 4.52)
	id 1E08Ju-0006XU-Sa; Tue, 02 Aug 2005 21:45:22 -0400
In-Reply-To: <1123033522656-git-send-email-ryan@michonline.com>
X-Mailer: git-send-email-script
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ryan Anderson <ryan@michonline.com>
---

 Documentation/git-send-email-script.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

b09788cd193a52bb44ab39826c9c6959f79305d5
diff --git a/Documentation/git-send-email-script.txt b/Documentation/git-send-email-script.txt
--- a/Documentation/git-send-email-script.txt
+++ b/Documentation/git-send-email-script.txt
@@ -44,6 +44,19 @@ The options available are:
 	to set this to a space.  For example
 		--in-reply-to=" "
 
+   --chain-reply-to, --no-chain-reply-to
+	If this is set, each email will be sent as a reply to the previous
+	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	the first will be sent as replies to the first email sent.  When using
+	this, it is recommended that the first file given be an overview of the
+	entire patch series.
+	Default is --chain-reply-to
+
+   --smtp-server
+	If set, specifies the outgoing SMTP server to use.  Defaults to
+	localhost.
+
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
