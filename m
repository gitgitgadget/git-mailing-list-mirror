From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] t0300: add missing EOF terminator for <<
Date: Fri, 16 Sep 2011 13:51:34 +0200
Message-ID: <a6397f7f28a5adcd34aeac98cca6500e336698aa.1316173346.git.trast@student.ethz.ch>
References: <20110914191757.GB28267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 16 13:51:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4WxN-0001mg-JO
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 13:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354Ab1IPLvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 07:51:38 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34918 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968Ab1IPLvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 07:51:38 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 16 Sep
 2011 13:51:35 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 16 Sep
 2011 13:51:35 +0200
X-Mailer: git-send-email 1.7.7.rc1.366.ge210a6
In-Reply-To: <20110914191757.GB28267@sigill.intra.peff.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181529>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This doesn't really matter on my system, but the shell warns about it.


 t/t0300-credentials.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 613c3fb..076a109 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -136,6 +136,7 @@ test_expect_success 'usernames can be preserved' '
 	password=three
 	--
 	verbatim: --username=one
+	EOF
 '
 
 test_expect_success 'usernames can be overridden' '
-- 
1.7.7.rc1.366.ge210a6
