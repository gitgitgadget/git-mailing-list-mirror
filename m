From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/5] stash: make "saved" message translatable
Date: Wed, 2 May 2012 15:49:23 +0200
Message-ID: <abd19c2c02ba6d1e8eac8a1f3df055e9ad8ea969.1335966202.git.trast@student.ethz.ch>
References: <cover.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZwD-0004vt-9x
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab2EBNtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 09:49:31 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:3500 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab2EBNta (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:49:30 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:49:28 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 15:49:27 +0200
X-Mailer: git-send-email 1.7.10.625.g300dcf
In-Reply-To: <cover.1335966202.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196820>

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-stash.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..e614eb7 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -233,7 +233,7 @@ save_stash () {
 
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "$(gettext "Cannot save the current status")"
-	say Saved working directory and index state "$stash_msg"
+	say "$(eval_gettext "Saved working directory and index state \"\$stash_msg\"")"
 
 	if test -z "$patch_mode"
 	then
-- 
1.7.10.625.g300dcf
