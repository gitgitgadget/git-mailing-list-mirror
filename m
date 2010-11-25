From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH] git-p4: Corrected typo.
Date: Thu, 25 Nov 2010 01:26:59 +0000
Message-ID: <1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 02:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLQdd-0006E1-2b
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 02:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab0KYB1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 20:27:22 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44369 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0KYB1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 20:27:21 -0500
Received: by wyb28 with SMTP id 28so346909wyb.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=2GCn1iJc6SA8RMZik/7aRDG/bkbmsjqiijKk/im3KJs=;
        b=tnNNh7FvqPA/txyY3RaaWl1x7ffRrGBtZufgW7xIHYnyM1LNCwC4StywgGq5dp03M4
         miiWtp79PqDHzsdgXeE4xgs5zPstMEwtoyBIiItRrgUYktiCj7queJiEF7ca4mcf/m+x
         bLu8qA2zg8i6SL5XSghWTPIsNs7nu5eMrBuaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=iLN7eNa/C/XhJIXYyBpKdZyb4IVMSD4mspQRId2J4G7FmG330FkOLKOKhN2LHKbTWW
         kXLP0J7ZaM+6q8dWee0X/A/CTxhwxRbJTaEo1ZE2JOm1hcTrwSQ9QRSkpvLApZp3YPcM
         IqFRo8aEjvpsxJtonS4NVtec5DmQIHkgr5n+g=
Received: by 10.227.128.7 with SMTP id i7mr94868wbs.165.1290648440117;
        Wed, 24 Nov 2010 17:27:20 -0800 (PST)
Received: from localhost.localdomain (111.216.54.77.rev.vodafone.pt [77.54.216.111])
        by mx.google.com with ESMTPS id i19sm90758wbe.17.2010.11.24.17.27.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 17:27:18 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162096>

---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 0ea3a44..a466847 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -618,7 +618,7 @@ class P4Submit(Command):
         if len(detectRenames) > 0:
             diffOpts = "-M%s" % detectRenames
         else:
-            diffOpts = ("", "-M")[self.detectRenames]
+            diffOpts = ("", "-M")[self.detectRename]
 
         detectCopies = gitConfig("git-p4.detectCopies")
         if len(detectCopies) > 0:
-- 
1.7.2.3
