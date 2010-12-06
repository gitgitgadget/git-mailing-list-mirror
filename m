From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 2/6] web--browse: split valid_tool list
Date: Mon,  6 Dec 2010 18:49:46 +0100
Message-ID: <1291657790-3719-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 18:50:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPfCt-00066z-1I
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 18:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab0LFRuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 12:50:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56472 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab0LFRuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 12:50:05 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so13094000wwa.1
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 09:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=md0lMHPOP/l+dl2kCGXDrUFgYZXC54EJHr7MDe30NCY=;
        b=vN575vOPyDk8drOhBppSptkfxZpVcXLvYbWhoAw0sryJcBaxxfW/MwXUh4PuwSPTJ+
         cLcPrNsHtf2iTCQVi/W/Izm7v+cZe+ANFtI3FiK369KwZ7mf38WFXl07U+GhXAi3e7/u
         Vk5USfm38jukBM7roHlhunMusu/RvbZPGKrJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DcW0+Ar4aBY7VykZatL1QHBY+scZtPNQ8lIRcnlnG/eQOoEhTgjaApwIqvStSCVRzO
         r15WUfoQmZns+mHqKHr8Wk0bUKGHBzcdqfZixqz5uCdPULQbmdGNZ5kV+EhHIneOTB8R
         FgbkzTAMhovGyZsQ4lVbbc2oiiVbi3sU92Tu8=
Received: by 10.227.145.134 with SMTP id d6mr6044393wbv.195.1291657804389;
        Mon, 06 Dec 2010 09:50:04 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id f35sm3609667wbf.14.2010.12.06.09.50.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 09:50:03 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.664.g294b8.dirty
In-Reply-To: <1291657790-3719-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163005>

It was getting too long, and we want to add some more.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-web--browse.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-web--browse.sh b/git-web--browse.sh
index 7c4568f..e48e30d 100755
--- a/git-web--browse.sh
+++ b/git-web--browse.sh
@@ -31,7 +31,8 @@ valid_custom_tool()
 
 valid_tool() {
 	case "$1" in
-	firefox | iceweasel | chrome | google-chrome | chromium | konqueror | w3m | links | lynx | dillo | open | start)
+	firefox | iceweasel | chrome | google-chrome | chromium |\
+	konqueror | w3m | links | lynx | dillo | open | start)
 		;; # happy
 	*)
 		valid_custom_tool "$1" || return 1
-- 
1.7.3.2.664.g294b8.dirty
