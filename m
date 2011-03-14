From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH] Documentation: running test with --debug keeps "trash" directory
Date: Mon, 14 Mar 2011 20:50:18 +0100
Message-ID: <4D7E717A.8010605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:50:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDmq-0006h2-RU
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:50:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725Ab1CNTu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:50:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50353 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab1CNTu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:50:27 -0400
Received: by fxm17 with SMTP id 17so3287704fxm.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=5QJ5uU/+8okgT5aZkQmsk4K82OrGj36QWFLdcCl1D/8=;
        b=f5jVB5SGRULclnZjMqN6jboJTrdzJOVNkeyviJaZPwBhprmb8ddanXUdJ9QJyToFCi
         f+LqqdCrRJOfAiM+J0UEkBHxrNoDaGadjqvGkzYAOvSnBhF/RBPryesfmSXSN0BvQqwZ
         pBgkaXVKdDilmy6UQ49dd+TCfU+3Om52RlLns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=CEUIXRmBL90Q5aGEBIMX0e+R0tSsRNm4Cw4YiPG8WzZrtaXrq9XlZV10eb3MeR+NHi
         phsfcmcfM2Y57lKb/cxo0AaqCO9pkAsjKlnbCTV5xbMlBsYRLQy9zRQl1MPZcB/z2b6s
         E0IbAI6P7zEtzd6SRI9a7JnLZcnmRZT+8eo+E=
Received: by 10.223.73.133 with SMTP id q5mr3539870faj.127.1300132221119;
        Mon, 14 Mar 2011 12:50:21 -0700 (PDT)
Received: from [192.168.1.101] (amm95.neoplus.adsl.tpnet.pl [83.26.68.95])
        by mx.google.com with ESMTPS id n3sm3260427faa.29.2011.03.14.12.50.19
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Mar 2011 12:50:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169020>



Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 t/README |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

It wasn't documented and I didn't notice it at first and found
it out only after I've started implementing --keep-trash option.

diff --git a/t/README b/t/README
index 78c9e65..5db567e 100644
--- a/t/README
+++ b/t/README
@@ -79,6 +79,9 @@ appropriately before running "make".
 --debug::
 	This may help the person who is developing a new test.
 	It causes the command defined with test_debug to run.
+	The "trash" directory (used to store all temporary data
+	during testing) is not deleted even if there are no
+	failed tests.
 
 --immediate::
 	This causes the test to immediately exit upon the first
-- 
1.7.4.1.228.g9e388

-- 
Piotr Krukowiecki
