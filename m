From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 6/6] chmod: use lower-case x
Date: Wed,  4 Jan 2012 16:55:39 +0100
Message-ID: <1325692539-26748-7-git-send-email-drizzd@aon.at>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:04:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTKH-0001z4-Ph
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172Ab2ADQEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:04:07 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51957 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756127Ab2ADQEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:04:05 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id B3F1A2C4014;
	Wed,  4 Jan 2012 17:04:57 +0100 (CET)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1325692539-26748-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187929>

---
 t/t5570-git-daemon.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index f2b374b..d9667f9 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -92,7 +92,7 @@ test_remote_error()
 		case $1 in
 		-x)
 			shift
-			chmod -X "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"
+			chmod -x "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"
 			;;
 		-n)
 			shift
@@ -126,7 +126,7 @@ test_remote_error()
 	echo "fatal: remote error: $msg: /$repo" >expect &&
 	test_cmp expect output
 	ret=$?
-	chmod +X "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"
+	chmod +x "$DAEMON_DOCUMENT_ROOT_PATH/repo.git"
 	(exit $ret)
 }
 
-- 
1.7.8
