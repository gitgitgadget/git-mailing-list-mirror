From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 1/7] t1402: add some more tests
Date: Sat, 10 Sep 2011 08:50:37 +0200
Message-ID: <1315637443-14012-2-git-send-email-mhagger@alum.mit.edu>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 08:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2HPc-0001xv-Q2
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 08:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab1IJGvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 02:51:09 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33354 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755667Ab1IJGvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 02:51:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEAB10.dip.t-dialin.net [84.190.171.16])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8A6ol8r024666;
	Sat, 10 Sep 2011 08:50:48 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181142>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1402-check-ref-format.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index ed4275a..eeb0b1a 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -13,6 +13,8 @@ invalid_ref() {
 		"test_must_fail git check-ref-format '$1'"
 }
 
+invalid_ref ''
+invalid_ref '/'
 valid_ref 'heads/foo'
 invalid_ref 'foo'
 valid_ref 'foo/bar/baz'
-- 
1.7.6.8.gd2879
