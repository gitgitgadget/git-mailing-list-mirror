From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 2/4] git-p4: add missing && in test
Date: Sun, 31 Jul 2011 09:45:17 -0400
Message-ID: <20110731134517.GD6564@arf.padd.com>
References: <20110731003557.GA4867@arf.padd.com>
 <20110731134416.GB6564@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 15:45:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnWKc-0005ZJ-1o
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab1GaNpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 09:45:22 -0400
Received: from honk.padd.com ([74.3.171.149]:41016 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab1GaNpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 09:45:20 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 57A86330B;
	Sun, 31 Jul 2011 06:45:20 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 92F383149A; Sun, 31 Jul 2011 09:45:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110731134416.GB6564@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178253>

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9800-git-p4.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index aec3ba1..b7eda82 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -202,7 +202,7 @@ test_expect_success 'preserve user where author is unknown to p4' '
 	"$GITP4" clone --dest="$git" //depot &&
 	test_when_finished cleanup_git &&
 	cd "$git" &&
-	git config git-p4.skipSubmitEditCheck true
+	git config git-p4.skipSubmitEditCheck true &&
 	echo "username-bob: a change by bob" >> file1 &&
 	git commit --author "Bob <bob@localhost>" -m "preserve: a change by bob" file1 &&
 	echo "username-unknown: a change by charlie" >> file1 &&
-- 
1.7.5.4
