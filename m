From: Glenn Rempe <glenn@rempe.us>
Subject: [PATCH] Fixed minor typo in t/t9001-send-email.sh test command line.
Date: Mon, 24 Sep 2007 13:33:38 -0700
Message-ID: <1190666018-10913-1-git-send-email-glenn@rempe.us>
Cc: Glenn Rempe <glenn@rempe.us>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 22:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZucu-0000fb-6y
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 22:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbXIXUdt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbXIXUdt
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 16:33:49 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:7038 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXIXUdt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 16:33:49 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1002729nze
        for <git@vger.kernel.org>; Mon, 24 Sep 2007 13:33:48 -0700 (PDT)
Received: by 10.114.124.1 with SMTP id w1mr6594806wac.1190666027076;
        Mon, 24 Sep 2007 13:33:47 -0700 (PDT)
Received: from localhost.localdomain ( [64.142.55.11])
        by mx.google.com with ESMTPS id l32sm10415672rvb.2007.09.24.13.33.45
        (version=SSLv3 cipher=OTHER);
        Mon, 24 Sep 2007 13:33:45 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.2.83.gc6869
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59074>

The git-send-email command line in the test was missing a single hyphen.

Signed-off-by: Glenn Rempe <glenn@rempe.us>
---
 t/t9001-send-email.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e9ea33c..83f9470 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -30,7 +30,7 @@ test_expect_success 'Extract patches' '
 '
 
 test_expect_success 'Send patches' '
-     git send-email -from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
+     git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="$(pwd)/fake.sendmail" $patches 2>errors
 '
 
 cat >expected <<\EOF
-- 
1.5.3.2.83.gc6869
