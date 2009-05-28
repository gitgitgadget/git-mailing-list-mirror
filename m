From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t8005: fix typo, it's ISO-8859-5, not KOI8-R
Date: Wed, 27 May 2009 20:57:45 -0500
Message-ID: <TuJlnAOtUS3ByrfKnDYTdfXD5w51hGZBirN3lkOckDwKUmk75rJ82sZ_hHV4a0cKgaLq6apo80Q@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 28 03:58:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Uso-0005fF-7o
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 03:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392AbZE1B57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 21:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758276AbZE1B57
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 21:57:59 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49711 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646AbZE1B56 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 21:57:58 -0400
Received: by mail.nrlssc.navy.mil id n4S1vuwc006233; Wed, 27 May 2009 20:57:56 -0500
X-OriginalArrivalTime: 28 May 2009 01:57:56.0214 (UTC) FILETIME=[B8211160:01C9DF37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120132>

From: Brandon Casey <drafnel@gmail.com>

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


A little leftover typo.  I originally tried out KOI8-R since it seemed to
be more popular according to wikipedia, but then settled on ISO-8859-5
since Solaris supported it.

This patch is on top of bc/old-iconv in next bb43414b.

-brandon


 t/t8005-blame-i18n.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 4460975..9cca14d 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -13,7 +13,7 @@ test_expect_success 'setup the repository' '
 	git add file &&
 	git commit --author "$UTF8_NAME <utf8@localhost>" -m "$UTF8_MSG" &&
 
-	echo "KOI8-R LINE" >> file &&
+	echo "ISO-8859-5 LINE" >> file &&
 	git add file &&
 	git config i18n.commitencoding ISO8859-5 &&
 	git commit --author "$ISO8859_5_NAME <iso8859-5@localhost>" -m "$ISO8859_5_MSG" &&
-- 
1.6.3.1.24.g152f4
