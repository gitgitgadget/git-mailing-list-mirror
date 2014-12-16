From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] t5400: remove dead code
Date: Mon, 15 Dec 2014 19:58:07 -0800
Message-ID: <1418702287-13771-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Dec 16 04:58:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0jHB-0007P6-8s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 04:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbaLPD6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 22:58:16 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:59847 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaLPD6P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 22:58:15 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so7111968igi.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 19:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Kjm6eHTBagQ5B9Rm6s7zwJhkWdzZir/NGEgVSuqYBdE=;
        b=Ffx2RQ3itteHJEopIoVo4t/p2ScDKIkcH6Y3VFXpYP90O6HVhXi+890o3g0gcx9PiV
         ryver86lDaayvxiRTZiJreNiNPG09ojUGp338HMtjKHn8+ZNGIG9mbTu7QQS34+Qgh5z
         Ywpf6zy2DnktGNNtiNW3hadC/R5e0B63IUSNLZz3Bc6yv4YAJmtyRHMnvJQUcIhFpnzS
         27NLtnmnmjSgmQbC1ajPla1OrYDcrr4idshbVhna6stZxp+hreL1XNNm+/BdCxt/JTML
         PdxVsXGp1JqN+XScL0C44tIAsLNo8MDKUhycYYq3N+R63qoHoJd3O2G3YWncFRQEbCAy
         DFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Kjm6eHTBagQ5B9Rm6s7zwJhkWdzZir/NGEgVSuqYBdE=;
        b=Qnfr69fFS4OAVoKiLOs+8r5wSapPm0bR2bUHosHrx56Ww560P4aQC3USA5zyM/+1dU
         4UbcIIg2IM1BU+8mkbSxzl0WnR25G3ntOlN/gcZtEcRCjlBVRdIrTCAP8j1Pl6J4212s
         MQ4fV5U429DBQDe0HKVT5hc6ehvf/UAqaoDsIv7Sa9IbhLWcl560RGZ20HbVqza/LHHz
         w0LkfkkjW94rgwf87GCvN6Mx2EAuJ0IxR5RiV+Im4oh0IQ1JWWLclYD286WT1SP1ftBf
         A/JQOMEvX0YfkpD5RkoWjIxs+4GkME74jRwtNgMMOvB6wBvh5CRKKYkHu3E6vDfEmrQR
         bEkQ==
X-Gm-Message-State: ALoCoQm76ePX2zphVBd08Qt8DmKKq0finFxfr8cn5x8/eDeXEKYxZ9/N8cl5+yR5pnmSikVaXGLD
X-Received: by 10.107.46.28 with SMTP id i28mr32362059ioo.73.1418702294760;
        Mon, 15 Dec 2014 19:58:14 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ccd:69a0:9bbf:bab9])
        by mx.google.com with ESMTPSA id a69sm1260820ioe.18.2014.12.15.19.58.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 19:58:14 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261438>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    When debugging the atomic push series I wondered if we want to have
    tests for the atomic push as well as for atomic send-pack.
    So I looked at the t5400 test if I could easily add tests for send-pack.
    I don't think I will add tests in here, but I found dead code.
    Also I am rambling about the other series this patch is totally unrelated.
    
    Removing dead code is always a joy!
    
    Thanks,
    Stefan

 t/t5400-send-pack.sh | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0736bcb..04cea97 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -76,8 +76,7 @@ test_expect_success 'refuse pushing rewound head without --force' '
 	test "$victim_head" = "$pushed_head"
 '
 
-test_expect_success \
-        'push can be used to delete a ref' '
+test_expect_success 'push can be used to delete a ref' '
 	( cd victim && git branch extra master ) &&
 	git send-pack ./victim :extra master &&
 	( cd victim &&
@@ -196,19 +195,6 @@ rewound_push_setup() {
 	)
 }
 
-rewound_push_succeeded() {
-	cmp ../parent/.git/refs/heads/master .git/refs/heads/master
-}
-
-rewound_push_failed() {
-	if rewound_push_succeeded
-	then
-		false
-	else
-		true
-	fi
-}
-
 test_expect_success 'pushing explicit refspecs respects forcing' '
 	rewound_push_setup &&
 	parent_orig=$(cd parent && git rev-parse --verify master) &&
-- 
2.2.0.31.gad78000.dirty
