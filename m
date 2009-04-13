From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3 03/13] Docs: send-email: Remove superfluous information in CONFIGURATION
Date: Mon, 13 Apr 2009 13:23:47 -0500
Message-ID: <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-2-git-send-email-mfwitten@gmail.com>
 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 13 20:29:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQu8-0000CZ-KS
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbZDMS1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbZDMS1U
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:27:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:43662 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZDMS1U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:27:20 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1130877wah.21
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=v35W9tgVIWiXMnPYd1QEBGveBrZqSIvhaGd5iXFj4wg=;
        b=ly1HHZbhdflDmvZ71AVO/CStlmo7TOE6CNPu9yo1S2u7LC11TZFf0AGCPvsba39S9I
         hxbJQa7SajxHZ1nl3t96zKivxy/xoLXKB+3sJbDUpgcJYrmF3QIx+iKbzrVCd+sp8omx
         sKyOiUNn4FeHLELP9af5FQL8a6eS4K64NcPvU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nEyKhmNp8ZFua4z/p5Fi2YlDPgIZVBHcH8bXxkZmif6Ls3KDj9L13R1ttpDk8TmLJL
         3SBugxEy2Nnc7anh/k1Ji7vbFBDvN4D/KiFiHAZ8q003TBtxjZWmnYWYlt8+27fkenHe
         Qdd4b5o6cGPqSnBW2Prq6FLUR5qFtFneM+hqs=
Received: by 10.114.133.1 with SMTP id g1mr3302113wad.21.1239647239396;
        Mon, 13 Apr 2009 11:27:19 -0700 (PDT)
Received: from localhost.localdomain (97-116-116-167.mpls.qwest.net [97.116.116.167])
        by mx.google.com with ESMTPS id m30sm5963707wag.12.2009.04.13.11.27.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 11:27:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116464>

In particular, sendemail.confirm was removed, because it's already
described along with its corresponding option.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/git-send-email.txt |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 7b87d6e..b58b433 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -271,12 +271,6 @@ sendemail.multiedit::
 	summary when '--compose' is used). If false, files will be edited one
 	after the other, spawning a new editor each time.
 
-sendemail.confirm::
-	Sets the default for whether to confirm before sending. Must be
-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
-	in the previous section for the meaning of these values.
-
-
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
-- 
1.6.2.2.479.g2aec
