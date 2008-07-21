From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 9/9] Windows: Do not compile git-shell
Date: Mon, 21 Jul 2008 21:19:58 +0200
Message-ID: <1216667998-8879-10-git-send-email-johannes.sixt@telecom.at>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-4-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-5-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-6-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-7-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-8-git-send-email-johannes.sixt@telecom.at>
 <1216667998-8879-9-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL0x1-00025p-Qj
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 21:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbYGUTUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 15:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbYGUTUS
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 15:20:18 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:39829 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbYGUTUE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 15:20:04 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id 5068E33EE2;
	Mon, 21 Jul 2008 21:20:03 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.rc0.18.g6aef2
In-Reply-To: <1216667998-8879-9-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89394>

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1bfffff..f8dd7e6 100644
--- a/Makefile
+++ b/Makefile
@@ -283,7 +283,6 @@ PROGRAMS += git-pack-redundant$X
 PROGRAMS += git-patch-id$X
 PROGRAMS += git-receive-pack$X
 PROGRAMS += git-send-pack$X
-PROGRAMS += git-shell$X
 PROGRAMS += git-show-index$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-update-server-info$X
@@ -812,6 +811,7 @@ EXTLIBS += -lz
 ifndef NO_POSIX_ONLY_PROGRAMS
 	PROGRAMS += git-daemon$X
 	PROGRAMS += git-imap-send$X
+	PROGRAMS += git-shell$X
 endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
@@ -1348,7 +1348,7 @@ endif
 	fi && \
 	{ $(foreach p,$(BUILT_INS), $(RM) "$$execdir/$p" && ln "$$execdir/git$X" "$$execdir/$p" ;) } && \
 	$(RM) "$$execdir/git$X" && \
-	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-shell$X"
+	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
 	$(MAKE) -C Documentation install
-- 
1.6.0.rc0.18.g6aef2
