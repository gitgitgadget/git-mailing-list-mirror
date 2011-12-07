From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/15] t1511 (rev-parse-caret): fix && chaining
Date: Thu,  8 Dec 2011 01:06:42 +0530
Message-ID: <1323286611-4806-7-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJw-00018H-P9
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab1LGTiR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:17 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48222 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:16 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so701321qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sDxf2nic7GBQtcna7goaw5Scu2C1pDU8sHuHBpCSu+s=;
        b=JFmqZHSLu+KGwSW5VTja1Kfs83JbIFmJbX+ZwmMwZ519o4nYtp34PwNDuL7zM2ewmh
         KM8d7BNBtN8FopJmzEz1B5ANQCKjDWxYpHl+dtLmv6O8NAeXfXNgxZDELaegwhfWykfW
         8KbuUu5epGVaaN5lQiY6Qp5Q/3iDB1KTNdla8=
Received: by 10.50.216.137 with SMTP id oq9mr210325igc.40.1323286696090;
        Wed, 07 Dec 2011 11:38:16 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:15 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186487>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1511-rev-parse-caret.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
index e043cb7..eaefc77 100755
--- a/t/t1511-rev-parse-caret.sh
+++ b/t/t1511-rev-parse-caret.sh
@@ -6,7 +6,7 @@ test_description='tests for ref^{stuff}'
 
 test_expect_success 'setup' '
 	echo blob >a-blob &&
-	git tag -a -m blob blob-tag `git hash-object -w a-blob`
+	git tag -a -m blob blob-tag `git hash-object -w a-blob` &&
 	mkdir a-tree &&
 	echo moreblobs >a-tree/another-blob &&
 	git add . &&
-- 
1.7.7.3
