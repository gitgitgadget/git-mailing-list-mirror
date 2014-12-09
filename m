From: Ronald Wampler <rdwampler@gmail.com>
Subject: [PATCH] git-am.txt: --ignore-date flag is not passed to git-apply
Date: Tue,  9 Dec 2014 12:28:18 -0500
Message-ID: <1418146098-30099-1-git-send-email-rdwampler@gmail.com>
Cc: giuseppe.bilotta@gmail.com, gitster@pobox.com,
	Ronald Wampler <rdwampler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 18:30:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyOcZ-00049e-EA
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 18:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbaLIRan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 12:30:43 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38901 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbaLIRan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 12:30:43 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so1337808igi.12
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=O21maQ7y1wQ2+YcCtNuw6Pn4d2KTk9vP9MgKqdR7DJ0=;
        b=Li3I1wZ1kGQ5oW7OEGJ8EJ8SCNMK+6srOgDkNE0oCAZgCCrI/KFvAc3QNaDy6Ps4/E
         kWlFiH0A1x36rgHY3wa51lZ1ARJ6ED0og+Q6LK8laXayDtiPQ1w7eA2Onna5KZ2kY+qd
         raAkWaA9+DO1KTbmoi2Vc4Ut0FD/049XJ25GWdhzxvinxONgCuVvAEPIOGi058KF7moQ
         2Vzwgr6HxZs9TyTFzIx90RHzBOdfLQgS/nhIb1w3lCY/zP6DxbQwDwtVG5azIVn+HqMA
         IvhgAyWD/liZoAAi0wvuOT+ITq184PdZ6S9KrvHhWHCBLH7SO59cES3gPamW7/beuOHF
         yyUw==
X-Received: by 10.50.50.165 with SMTP id d5mr21354690igo.16.1418146242447;
        Tue, 09 Dec 2014 09:30:42 -0800 (PST)
Received: from localhost.localdomain (rrcs-24-123-216-252.central.biz.rr.com. [24.123.216.252])
        by mx.google.com with ESMTPSA id z20sm1152784igp.22.2014.12.09.09.30.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Dec 2014 09:30:41 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc18b867
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261132>

---
 Documentation/git-am.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9adce37..d4ef16c 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -83,7 +83,6 @@ default.   You can use `--no-utf8` to override this.
 	it is supposed to apply to and we have those blobs
 	available locally.
 
---ignore-date::
 --ignore-space-change::
 --ignore-whitespace::
 --whitespace=<option>::
-- 
2.2.0.33.gc18b867
