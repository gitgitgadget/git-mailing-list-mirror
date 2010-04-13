From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Documentation/config.txt: default gc.aggressiveWindow is 250, not 10
Date: Tue, 13 Apr 2010 12:52:55 -0400
Message-ID: <1271177575-68894-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 18:53:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1jMx-0000br-V2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 18:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483Ab0DMQxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 12:53:10 -0400
Received: from mail-qy0-f201.google.com ([209.85.221.201]:42229 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab0DMQxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 12:53:08 -0400
Received: by qyk39 with SMTP id 39so6460035qyk.24
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 09:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=u3JssPxrSJGHW8hathQ62ik91f2Y1vKB7ICqpR5NNx0=;
        b=G7nLJoN+PPCW3xuQj230DDvRFQwrrC8pP3U7YqrF/AZcF2HFjuh+kj2H1eo+fYv/Xg
         Ga8NftSIMjsLGQodCzuQDCvFB9QBdRq4MTRsCHwwzCtCwgB7SMMVfJsP281dAFhP6oWp
         dhK0Ue6aRNl+4DpXQv2e4oGx/kOT4c+OSFW9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=d14hNgCjXSpdWAxMQdUZBEg37HhePcDHa+UB2LFZhNM5EVp9voN7c08LLxrYqd3WbK
         76IJEyKvJimOq0WApNdcOdpJvSbnfrHpdtzl1R02Zl+aNma9m1f2Ql1KqTYDnhbK57YI
         DpKn+tRNiCvgG186vd9LJNrQ9bM9O3RLj1/18=
Received: by 10.229.211.204 with SMTP id gp12mr8524503qcb.59.1271177588001;
        Tue, 13 Apr 2010 09:53:08 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id f5sm7746954qcg.14.2010.04.13.09.53.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 09:53:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.436.g2b878
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144823>

The default for gc.aggressiveWindow has been 250 since 1c192f3
(gc --aggressive: make it really aggressive, 2007-12-06).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06b2f82..aa5411e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -914,7 +914,7 @@ format.signoff::
 gc.aggressiveWindow::
 	The window size parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
-	to 10.
+	to 250.
 
 gc.auto::
 	When there are approximately more than this many loose
-- 
1.7.0.3.436.g2b878
