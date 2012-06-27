From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 04/10] git p4 test: never create default test repo
Date: Wed, 27 Jun 2012 08:00:57 -0400
Message-ID: <1340798463-14499-5-git-send-email-pw@padd.com>
References: <1340798463-14499-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 14:02:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjqx6-0004dq-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 14:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756600Ab2F0MC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 08:02:28 -0400
Received: from honk.padd.com ([74.3.171.149]:52776 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755837Ab2F0MC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 08:02:28 -0400
Received: from arf.padd.com (unknown [50.55.159.91])
	by honk.padd.com (Postfix) with ESMTPSA id 5C0B4D02;
	Wed, 27 Jun 2012 05:02:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F0E8931383; Wed, 27 Jun 2012 08:02:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.130.gb957a79
In-Reply-To: <1340798463-14499-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200717>


Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 0b09735..4c5b1f6 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -2,6 +2,10 @@
 # Library code for git p4 tests
 #
 
+# p4 tests never use the top-level repo; always build/clone into
+# a subdirectory called "$git"
+TEST_NO_CREATE_REPO=NoThanks
+
 . ./test-lib.sh
 
 if ! test_have_prereq PYTHON; then
-- 
1.7.11.1.69.gd505fd2
