From: Ronald Wampler <rdwampler@gmail.com>
Subject: [PATCH v2] git-am.txt: --ignore-date flag is not passed to git-apply
Date: Tue,  9 Dec 2014 13:28:35 -0500
Message-ID: <1418149715-30938-1-git-send-email-rdwampler@gmail.com>
References: <1418146098-30099-1-git-send-email-rdwampler@gmail.com>
Cc: giuseppe.bilotta@gmail.com, gitster@pobox.com,
	Ronald Wampler <rdwampler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 19:31:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPYr-0003p6-5u
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaLISa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:30:57 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35421 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaLISa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:30:56 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so5025657igb.11
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1mNhY64ixwitb4wm7M/x1qFOIxvGxVtqUIaxb7BWZSA=;
        b=xxtZgNbZd/VxFPnQwfTvNgJkzfZ/jvQera1MQxw80eMEkYirGrgIXykJq46XdszEXk
         NI7w04GGMS3WhBpzU1qTKh7wbBPhxvKGKTToeIe7C0LCepFUv2Hc0G3EtdvGglKdarG6
         nTkBKXseSpNjq0xZ5haRlsQQH4deQrWlXOr78VwLE1NTFtHy4SFA/TVHAqgMJYqqCjMP
         Rg1rGaMutqfoPKKc9MsJ9Y1G5FYHKVbaGGUxUCOcf2fMkgJYuZIW86j/X/EbiAHTHrY2
         e2xmfywfI+CgNZlZNQur6DbG/bZohp90a6LKySZQfEsEUso62XQC/3MPaWo22S2pd9Sd
         FsTw==
X-Received: by 10.107.40.16 with SMTP id o16mr18069492ioo.26.1418149855991;
        Tue, 09 Dec 2014 10:30:55 -0800 (PST)
Received: from localhost.localdomain (rrcs-24-123-216-252.central.biz.rr.com. [24.123.216.252])
        by mx.google.com with ESMTPSA id o185sm908682ioe.40.2014.12.09.10.30.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Dec 2014 10:30:55 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc18b867
In-Reply-To: <1418146098-30099-1-git-send-email-rdwampler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261136>

Signed-off-by: Ronald Wampler <rdwampler@gmail.com>
---
I forgot to add the sign-off in the previous patch. Sorry for the additional noise.

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
