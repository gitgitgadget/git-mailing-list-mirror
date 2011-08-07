From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/4] git-p4: add missing && in test
Date: Sun, 7 Aug 2011 09:34:25 -0400
Message-ID: <20110807133425.GB27737@arf.padd.com>
References: <20110807133144.GA27521@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 07 15:34:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qq3Uz-0002F7-3d
	for gcvg-git-2@lo.gmane.org; Sun, 07 Aug 2011 15:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab1HGNe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Aug 2011 09:34:29 -0400
Received: from honk.padd.com ([74.3.171.149]:57072 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab1HGNe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2011 09:34:29 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 7912E1F9E;
	Sun,  7 Aug 2011 06:34:28 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E54AC3143E; Sun,  7 Aug 2011 09:34:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110807133144.GA27521@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178913>

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-by: Luke Diamand <luke@diamand.org>
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
