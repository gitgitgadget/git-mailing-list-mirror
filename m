From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH] config.txt: fix placement of diff.noprefix
Date: Thu,  9 Sep 2010 21:39:37 -0400
Message-ID: <1284082777-18826-1-git-send-email-lodatom@gmail.com>
Cc: Eli Collins <eli@cloudera.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 03:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otsau-0007QS-JQ
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 03:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757528Ab0IJBjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 21:39:54 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39835 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469Ab0IJBjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 21:39:48 -0400
Received: by qwh6 with SMTP id 6so987181qwh.19
        for <git@vger.kernel.org>; Thu, 09 Sep 2010 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=TpZmVmdc5Ngf+kC4yoxza6XVGOx42SyxcGtSBHwQjHc=;
        b=EzsA+GPi4SFe7fC8rIUqxjG9YuZsQlNRL0cc2fcS6CKB2Zk3Tn4+hRjPVphdSBnnlz
         5MI2uCVqrgiv5XQ/L6QaVzaao+jzUaBQjeOMIorHUwCRyYJEkIMmZdozJ3zBDsU5EqRT
         dBZNzS8wlabX2KxcyAvVRwtd2+dWXouMc0hOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CbXnrE6s990ttqhB9pZ68AZWVWs5G7N2DghZm6uzjoQWCzB5AFP5D9cAOcRnlhrqwv
         s0D/aQdsn6Oy5q7xxAM4VpvC2sqNijGH9pT7nk+Iq1CQNawgmiZxboC/ElLYdt3vnCbH
         ADBKOLyP3ZDzTHzmhfiU3O9rc94VU1n9joUV8=
Received: by 10.224.39.148 with SMTP id g20mr521979qae.385.1284082787631;
        Thu, 09 Sep 2010 18:39:47 -0700 (PDT)
Received: from localhost.localdomain (c-69-137-229-191.hsd1.dc.comcast.net [69.137.229.191])
        by mx.google.com with ESMTPS id t24sm2080046qcs.11.2010.09.09.18.39.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Sep 2010 18:39:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155918>

In git-config(1), diff.noprefix was placed in between
diff.mnemonicprefix and the list of mnemonic prefixes, which is
obviously incorrect and very confusing to readers.  Now, it is located
after the end of the explanation of mnemonicprefix, which makes much
more sense.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/config.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d294dd6..d82c0da 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -813,8 +813,6 @@ diff.mnemonicprefix::
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
-diff.noprefix::
-	If set, 'git diff' does not show any source or destination prefix.
 `git diff`;;
 	compares the (i)ndex and the (w)ork tree;
 `git diff HEAD`;;
@@ -826,6 +824,9 @@ diff.noprefix::
 `git diff --no-index a b`;;
 	compares two non-git things (1) and (2).
 
+diff.noprefix::
+	If set, 'git diff' does not show any source or destination prefix.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the 'git diff' option '-l'.
-- 
1.7.2.3
